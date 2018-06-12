--
-- DklRectCatAxis.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

function DklRectCatAxisTicks(ext, pos, items, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		axisMode = -1
	end

	local size = #items
	local inc = ext/size

	local i = 0
	while (i <= ext) do
		if ((pos == TOP) or (pos == BOTTOM)) then
			line(i, 0, i, -tickLen*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			line(0, i, tickLen*axisMode, i)
		end
		i = i + inc
	end
end

function DklRectCatAxisLabels(ext, pos, items, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		axisMode = -1
	end
	
	local anchorMode = CENTER
	if (pos == LEFT) then
		anchorMode = RIGHT
	elseif (pos == RIGHT) then
		anchorMode = LEFT
	end
	textAlign(anchorMode)

	local size = #items
	local inc = ext/size

	local n = 1
	local i = 0
	
	while (n <= size) do
		local label = items[n]
		if ((pos == TOP) or (pos == BOTTOM)) then
			if pos == TOP then
				pushMatrix()
				rotate(4.7)
				text(label,(tickLen*2)*axisMode,i+inc/2)
				popMatrix()
			else
				text(label,i+(inc/2), -(tickLen*2)*axisMode)
			end
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			text(label,(tickLen*2)*axisMode,i+inc/2)
		end
		i = i + inc
		n = n + 1
	end
end

function DklRectCatAxis(ext, pos, items, tickLen)
	stroke(0)
	strokeWeight(1)
	if ((pos == TOP) or (pos == BOTTOM)) then
		line(0, 0, ext, 0)
	elseif ((pos == LEFT) or (pos == RIGHT)) then
		line(0, 0, 0, ext)
	end
	DklRectCatAxisTicks(ext,pos,items,tickLen)
	fill(0)
	DklRectCatAxisLabels(ext,pos,items,tickLen)
end
