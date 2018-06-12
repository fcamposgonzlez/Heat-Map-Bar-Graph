--
-- DklLabel.lua
--
-- Döiköl Data Visualization Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

function DklLabel(selection,mode)
	rectMode(CORNER)
	textAlign(LEFT)
	stroke(0)
	for k,v in pairs(selection) do
		pushMatrix()
		fill(255)
		translate(v.x,v.y)
		rect(0,-25,textWidth(v.data)+10,20)
		fill(0)
		text(v.data,5,-10)
		popMatrix()
	end
end
