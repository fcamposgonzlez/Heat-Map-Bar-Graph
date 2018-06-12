--
-- DklLineGraph.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "dkl/DklRectCatAxis"
require "dkl/DklRectNumAxis"
require "dkl/DklLegend"
require "dkl/DklLabel"
require "dkl/DklUtilities"
require "dkl/DklLinePlot"

function _DklLineGraph(x,y,w,h,dataY,color,mode,eventType,tickInc,
						tickLen,selected,categories,minYn,maxYn,label)
	pushMatrix()
	translate(x,y)
	pushMatrix()
	if (mode == VERTICAL) then
		DklRectNumAxis(h,LEFT,minYn,maxYn,tickInc,tickLen)
	elseif (mode == HORIZONTAL) then
		translate(0,h)
		DklRectNumAxis(h,BOTTOM,minYn,maxYn,tickInc,tickLen)
	end
	popMatrix()
	pushMatrix()
	if (mode == VERTICAL) then
		translate(0,h)
		DklRectCatAxis(w,BOTTOM,categories,tickLen)
	elseif (mode == HORIZONTAL) then
		DklRectCatAxis(w,LEFT,categories,tickLen)
	end
	popMatrix()
	minXn = 0
	maxXn = #categories
	dataX = rangeList(0.5,maxXn-1)
	local rateX = w/(maxXn - minXn)
	local rateY = h/(maxYn - minYn)
	local selection
	if (mode == VERTICAL) then
		selection = __DklLinePlot(w,h,dataX,dataY,color,rateX,
											rateY,selected,eventType,label)
	else
		selection = __DklLinePlot(w,0,dataY,dataX,color,rateY,
											-rateX,selected,eventType,label)
	end 
	DklLabel(selection,mode)
	popMatrix()
	return selection
end

function DklLineGraph(options)
	local state = options.state or {id=0,selection={}}
	state.id = state.id + 1
	local id = state.id
	state.selection[id] = _DklLineGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, options.data or {{}}, 
		options.color or "0x000000", options.mode or VERTICAL, options.event or nil,
		options.tickInc or 10, options.tickLen or 10, 
		state.selection[id] or {},options.categories or {},
		options.minvalue or 0, options.maxvalue or 100,
		options.label or nil)
end
