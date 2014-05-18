require "pp"

mec = 10	# ug/ml
mtc = 20	# ug/ml
halfLile = 22	# hr
volume = 3000	# ml
dosage = 100 * 1000	# ug
absorptionFraction = 0.12	# (unitless)
interval = 8

eliminationConstant = -1 * Math.log(0.5) / halfLile # 1/hr

drugInSystem = []	# ug
drugInSystem[0] = absorptionFraction * dosage

simHrs = 168	# hr
dX = 2.to_f / 60	# hr

def xtoi x,dX
	x / dX + 1
end

def itox i,dX
	(i-1) * dX
end

i = 0
simtime = 0

while simtime < simHrs do
	i += 1
	simtime += dX

	if itox(i,dX) % interval == 0
		ingested = absorptionFraction * dosage
	else
		ingested = 0
	end
	eliminated = (eliminationConstant * drugInSystem[i-1]) * dX
	drugInSystem[i] = drugInSystem[i-1] + ingested - eliminated
end
pp concentration = drugInSystem.map{|a| a.to_f / volume}

