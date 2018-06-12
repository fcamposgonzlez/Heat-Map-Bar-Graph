--
-- DklBarGraph.lua
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

function __DklBarGraph(w,h,dataX,dataY,color,offset,size,rateX,rateY,
									mode,selected,eventCode,label)

	local n = #dataX
	local m = #dataY

	local selection = {}
	local shapeType = RECT
	local sValue = 4
	local strkWght = 1
	local gap = (w/m)*size
	local result = false

	local varColor = (type(color) =='table')
	if (not varColor) then fill(color) end

	rectMode(CORNER)
	event(eventCode)

	for i=1,n do
		if (strkWght~=1) then
			strkWght = 1
			strokeWeight(strkWght)
		end
		if (varColor) then fill(color[i]) end
		if selected[i] then 
			strkWght = 5
			strokeWeight(strkWght)
		end

		if (mode==VERTICAL) then
			result = rect(dataX[i]*rateX-gap/2+offset,h-dataY[i]*rateY,gap,dataY[i]*rateY)
		elseif (mode==HORIZONTAL) then
			result = rect(0,h-dataY[i]*rateY-gap/2,dataX[i]*rateX,gap)
		end

		if (eventCode ~= nil and label ~= nil and result) then
			selection[i] = {x=dataX[i]*rateX,y=h-dataY[i]*rateY,data=label[i]};
		end
	end
	strokeWeight(1)
	return selection
end

function _DklBarGraph(x,y,w,h,dataY,color,offset,size,mode,event,tickInc,
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
		selection = __DklBarGraph(w,h,dataX,dataY,color,offset,size,rateX,
											rateY,mode,selected,event,label)
	else
		selection = __DklBarGraph(w,0,dataY,dataX,color,offset,size,rateY,
											-rateX,mode,selected,event,label)
	end 
	DklLabel(selection,mode)
	popMatrix()
	return selection
end

function DklBarGraph(options)
	local state = options.state or {id=0,selection={}}
	state.id = state.id + 1
	local id = state.id
	state.selection[id] = _DklBarGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, options.data or {{}}, 
		options.color or "0x000000", options.offset or 0,
		options.size or 0.5, options.mode or VERTICAL, options.event or nil,
		options.tickInc or 10, options.tickLen or 10, 
		state.selection[id] or {},options.categories or {},
		options.minvalue or 0, options.maxvalue or 100,
		options.label or nil)
end
