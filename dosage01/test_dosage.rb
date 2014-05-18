require "pp"

halflife = 3.2       # hr
plasmaVolume = 3000  # ml

eliminationConstant = -1 * Math.log(0.5) / halflife         # 1/hr

aspirinInPlasma = []
aspirinInPlasma[0] = 2 * 325 * 1000 # ug (micrograms)

simulationHours = 8      # hr
deltaX = (5.to_f / 60)   # hr


i = 0
simtime = 0
while simtime <= simulationHours do
	i = i + 1
	simtime = simtime + deltaX
	elimination = (eliminationConstant * aspirinInPlasma[i-1]) * deltaX
	aspirinInPlasma[i] = aspirinInPlasma[i-1] - elimination
end
plasmaConscentration = aspirinInPlasma.map{|a| a / plasmaVolume} # ug/ml

plasmaConscentration.each do |v|
	$stdout.printf "%10.2f %s \n", (v * 100).to_i.to_f / 100 ,"*" * (v / 2).to_i
end
