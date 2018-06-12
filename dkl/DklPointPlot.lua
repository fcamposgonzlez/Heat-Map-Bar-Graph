--
-- DklPointPlot.lua
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

function __DklPointPlot(w,h,dataX,dataY,color,shape,size,rateX,rateY,
									selected,eventCode,label)

	local n = #dataX

	local selection = {}
	local shapeType = RECT
	local sValue = 4
	local strkWght = 1
	local result = false

	local varColor = (type(color) =='table')
	if (not varColor) then fill(color) end
	local varShape = (type(shape) =='table')
	if (not varShape) then shapeType = shape end
	local varSize = (type(size) =='table')
	if (not varSize) then sValue = size end

	rectMode(CENTER)
	ellipseMode(CENTER)
	event(eventCode)

	for i=1,n do
		if (strkWght~=1) then
			strkWght = 1
			strokeWeight(strkWght)
		end
		if (varShape) then shapeType = shape[i] end
		if (varColor) then fill(color[i]) end
		if (varSize) then sValue = size[i] end
		if selected[i] then 
			strkWght = 5
			strokeWeight(strkWght)
		end

		if (shapeType == RECT) then
			result = rect(dataX[i]*rateX,h-dataY[i]*rateY,sValue,sValue)
		elseif (shapeType == CIRCLE) then
			result = ellipse(dataX[i]*rateX,h-dataY[i]*rateY,sValue,sValue)
		end
		if (eventCode ~= nil and label ~= nil and result) then
			selection[i] = {x=dataX[i]*rateX,y=h-dataY[i]*rateY,data=label[i]};
		end
	end
	strokeWeight(1)
	return selection
end

function _DklPointPlot(x,y,w,h,dataX,dataY,color,shape,size,mode,event,
				tickXInc,tickYInc,tickLen,selected,minXn,maxXn,minYn,maxYn,label)
	pushMatrix()
	translate(x,y)
	pushMatrix()
	if (mode == VERTICAL) then
		DklRectNumAxis(h,LEFT,minYn,maxYn,tickYInc,tickLen)
	elseif (mode == HORIZONTAL) then
		translate(0,h)
		DklRectNumAxis(h,BOTTOM,minYn,maxYn,tickYInc,tickLen)
	end
	popMatrix()
	pushMatrix()
	if (mode == VERTICAL) then
		translate(0,h)
		DklRectNumAxis(w,BOTTOM,minXn,maxXn,tickXInc,tickLen)
	elseif (mode == HORIZONTAL) then
		DklRectNumAxis(w,LEFT,minXn,maxXn,tickXInc,tickLen)
	end
	popMatrix()
	local rateX = w/(maxXn - minXn)
	local rateY = h/(maxYn - minYn)
	local selection
	if (mode == VERTICAL) then
		selection = __DklPointPlot(w,h,dataX,dataY,color,shape,size,rateX,
											rateY,selected,event,label)
	else
		selection = __DklPointPlot(w,h,dataY,dataX,color,shape,size,rateY,
											rateX,selected,event,label)
	end 
	DklLabel(selection,mode)
	popMatrix()
	return selection
end

function DklPointPlot(options)
	local state = options.state or {id=0,selection={}}
	state.id = state.id + 1
	local id = state.id
	if (not options.minX) then options.minX = 0 end
	if (not options.maxX) then options.maxX = 100 end
	if (not options.minY) then options.minY = 0 end
	if (not options.maxY) then options.maxY = 100 end	

	state.selection[id] = _DklPointPlot(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, options.dataX or {},
		options.dataY or {}, options.color or "0x000000", options.shape or RECT,
		options.size or 4, options.mode or VERTICAL, options.event or nil,
		options.tickXInc or (options.maxX-options.minX)/5,
		options.tickYInc or (options.maxY-options.minY)/5,
		options.tickLen or 10, 
		state.selection[id] or {}, options.minX or 0, options.maxX or 100,
		options.minY or 0, options.maxY or 100, options.label or nil)
end
