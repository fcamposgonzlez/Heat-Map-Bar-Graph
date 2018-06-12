--
-- DklCircNumAxis.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.

require "dkl/DklUtilities"

function DklCircNumAxisTicks(ext, minn, maxn, tickInc, tickLen)
	for v=minn,maxn-tickInc,tickInc do
		local posA = circScale(v-maxn/4,minn,maxn,ext)
		local posB = circScale(v-maxn/4,minn,maxn,ext+tickLen)
		line(posA.x,posA.y,posB.x,posB.y)
	end
end

function DklCircNumAxisLabel(ext, minn, maxn, tickInc, tickLen)
	textAlign(CENTER)
	for v=minn,maxn-tickInc,tickInc do
		local coord = circScale(v-maxn/4,minn,maxn,ext+tickLen*4)
		text(tostring(v),coord.x,coord.y)
	end
end

function DklCircNumAxis(ext, minn, maxn, tickInc, tickLen)
	stroke(0)
	noFill()
	ellipse(0,0,ext,ext)
	DklCircNumAxisTicks(ext,minn,maxn,tickInc,tickLen)
	fill(0)
	DklCircNumAxisLabel(ext,minn,maxn,tickInc,tickLen)
end
