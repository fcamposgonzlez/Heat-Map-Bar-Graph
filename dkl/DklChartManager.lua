--
-- DklChartManager.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

DklChartManager = {id=0,selection={}}

function DklChartManager:new()
	d = {}
   setmetatable(d, self)
   self.__index = self
   return d
end

function DklChartManager:Begin(options)
	self.id = 0
end

function DklChartManager:End(options)
end
