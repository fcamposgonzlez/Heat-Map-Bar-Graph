--
-- DklCircCatAxis.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.

require "dkl/DklUtilities"

function DklCircCatAxisTicks(ext, items, tickLen)
	local n = #items
	local posA,posB
	for i=1,n do
		posA = circScale(i-n/4,0,n,ext)
		posB = circScale(i-n/4,0,n,ext+tickLen)
		line(posA.x, posA.y, posB.x, posB.y)
	end
end

function DklCircCatAxisLabels(ext, items, tickLen)
	local n = #items
	local label,coord
	textAlign(CENTER)
	for i=1,n do
		label = items[i]
		coord = circScale(i+0.5-n/4,0,n,ext+tickLen*4)
		text(label, coord.x, coord.y)
	end
end

function DklCircCatAxis(ext, items, tickLen)
	stroke(0)
	noFill()
	ellipse(0,0,ext,ext)
	DklCircCatAxisTicks(ext,items,tickLen)
	fill(0)
	DklCircCatAxisLabels(ext,items,tickLen)
end
