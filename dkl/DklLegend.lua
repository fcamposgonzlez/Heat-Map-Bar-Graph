--
-- DklLegend.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

function DklLegend(w,h,items,colors,mode,gap)

	local n = #items

	--textBaseline(CENTER)
	if (mode==VERTICAL) then
		textAlign(LEFT)
	elseif (mode==HORIZONTAL) then
		textAlign(CENTER)
	end

	stroke(0)
	strokeWeight(1)
	for i=1,n do
		fill(colors[i])
		if (mode==VERTICAL) then
			rect(0, (h+gap)*i, w, h)
		elseif (mode==HORIZONTAL) then
			rect(0+(w+gap)*i, 0, w, h);
		end
	end
	fill(0)
	for i=1,n do
		if (mode==VERTICAL) then
			text(items[i], (w+gap), (h+gap)*i+h/2)
		elseif (mode==HORIZONTAL) then
			text(items[i], (w+gap)*i+w/2, h+gap)
		end
	end
end
