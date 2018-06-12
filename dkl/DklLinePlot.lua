--
-- DklLinePlot.lua
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

function __DklLinePlot(w,h,dataX,dataY,color,rateX,rateY,selected,eventCode,label)

	local n = #dataX
	local selection = {}
	local iniX,iniY
	local result = false

	if (type(color) =='table') then
		stroke(color[1])
	else
		stroke(color)
	end
	
	if selected[1] then
		strokeWeight(4)
	else
		strokeWeight(1)
	end
	event(eventCode)

	beginShape()
	for i=1,n do
		if (i==1) then
			iniX = dataX[i]*rateX
			iniY = h-dataY[i]*rateY
		end
		vertex(dataX[i]*rateX,h-dataY[i]*rateY)
	end
	result = endShape()

	if (eventCode ~= nil and label ~= nil and result) then
		selection[1] = {x=iniX,y=iniY,data=label};
	end
	strokeWeight(1)
	return selection
end

function _DklLinePlot(x,y,w,h,dataX,dataY,color,shape,size,mode,event,
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
		selection = __DklLinePlot(w,h,dataX,dataY,color,rateX,
											rateY,selected,event,label)
	else
		selection = __DklLinePlot(w,h,dataY,dataX,color,rateY,
											rateX,selected,event,label)
	end 
	DklLabel(selection,mode)
	popMatrix()
	return selection
end

function DklLinePlot(options)
	local state = options.state or {id=0,selection={}}
	state.id = state.id + 1
	local id = state.id
	if (not options.minX) then options.minX = 0 end
	if (not options.maxX) then options.maxX = 100 end
	if (not options.minY) then options.minY = 0 end
	if (not options.maxY) then options.maxY = 100 end	

	state.selection[id] = _DklLinePlot(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, options.dataX or {},
		options.dataY or {}, options.color or "0x000000", options.shape or RECT,
		options.size or 4, options.mode or VERTICAL, options.event or nil,
		options.tickXInc or (options.maxX-options.minX)/5,
		options.tickYInc or (options.maxY-options.minY)/5,
		options.tickLen or 10, 
		state.selection[id] or {}, options.minX or 0, options.maxX or 100,
		options.minY or 0, options.maxY or 100, options.label or nil)
end
