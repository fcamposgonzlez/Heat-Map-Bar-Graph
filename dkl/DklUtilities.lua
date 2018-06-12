--
-- DklUtilities.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

function circScale(v, b, s, r)
	local result = {};
	result.x = r/2*math.cos(((v-b)*(PI*2)/(s-b)))
	result.y = r/2*math.sin(((v-b)*(PI*2)/(s-b)))
	return result
end

function getColumn(data,name)
	local column = {}
	for i=1,#data do
		column[i] = data[i][name]
	end
	return column
end

function rangeList(s,n)
	local list = {}
	for i=s,n+s,1 do
		table.insert(list,i)
	end
	return list
end

function maxColumn(data)
	local value = 0
	for k1,v1 in pairs(data) do
		if (value<tonumber(v1)) then
			value = tonumber(v1)
		end
	end
	return value
end

function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

function tableMax(data,columns)
	local value = 0
	for k1,v1 in pairs(data) do
		for k2,v2 in pairs(v1) do
			if (v2 ~= nill and tonumber(v2) ~= nil ) then
				if (value<tonumber(v2)) then
					value = tonumber(v2)
				end
			end
		end
	end
	return value
end
