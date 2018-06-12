--
-- DklRectNumAxis.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

function DklRectNumAxisTicks(ext, pos, minn, maxn, tickInc, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		 axisMode = -1
	end

	local coord
	for v=minn,maxn,tickInc do
		coord = map(v, minn, maxn, 0, ext)
		if ((pos == TOP) or (pos == BOTTOM)) then
			line(coord, 0, coord, -tickLen*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			line(0, coord, tickLen*axisMode, coord)
		end
	end
end

function DklRectNumAxisLabel(ext, pos, minn, maxn, tickInc, tickLen)
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

	for v=minn,maxn,tickInc do
		if ((pos == LEFT) or (pos == RIGHT)) then
			coord = map(v, maxn, minn, 0, ext)
		else
			coord = map(v, minn, maxn, 0, ext)
		end
		if ((pos == TOP) or (pos == BOTTOM)) then
			text(v, coord,5-(tickLen*2)*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			text(v, (tickLen*2)*axisMode, 5+coord)
		end
	end
end

function DklRectNumAxis(ext, pos, minn, maxn, tickInc, tickLen)
	stroke(0)
	strokeWeight(1)
	if ((pos == TOP) or (pos == BOTTOM)) then
		line(0, 0, ext, 0)
	elseif ((pos == LEFT) or (pos == RIGHT)) then
		line(0, 0, 0, ext)
	end
	DklRectNumAxisTicks(ext, pos, minn, maxn, tickInc, tickLen)
	fill(0)
	DklRectNumAxisLabel(ext, pos, minn, maxn, tickInc, tickLen)
end
