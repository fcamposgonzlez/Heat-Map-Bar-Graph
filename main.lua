require "dkl/DklRectNumAxis"
require "dkl/DklRectCatAxis"

function setup() 
	size(1280,720)
	background(255)
	stroke(0);
	fill(0);
	fila = {}
	datos = {}
	x = {}
	y = {}
	local f = loadFont("data/Vera.ttf",14)
	textFont(f)
	
	local file = io.open("data/matrimonios.csv")
	
	while true do
		local line = file:read("*line")
		if line == nil then
			break
		end
		
		fila = {}
		--line = string.sub(line,2,#(line)-1)
		for word in string.gmatch(line, '([^,]+)') do
			table.insert(fila,word)
		end
		table.insert(datos,fila)
		if member(x, fila[1]) == false then
			table.insert(x,fila[1])
		end
		
		if member(y, fila[2]) == false then
			table.insert(y,fila[2])
		end	
	end
	table.remove(x, 1)
	table.remove(y, 1)
	table.remove(datos, 1)
	for i= 1, #(y) do
		print(y[i])
	end
	
end

function member(lista, palabra)
	miembro = false
	for i = 1, #(lista) do
		if lista[i] == palabra then
			miembro = true
			break
		end
	end
	return miembro		
end

function pos(dato, lista)
	for i = 1, #(lista) do
		if lista[i] == dato then
			return i
		end
	end
	return nil
end


function barchart(filename, yf1,  xf1,  yscale,  xscale,  r1,  g1,  b1,  a1,tags) 
   --Declare a  variabe for the max y axis value.
   
   --Declare a  variable for the minimum y axis value.
    local ymin = 0;
   
   --Set the stroke color to a medium gray for the axis lines.
   stroke(175);
   
   --draw the axis lines.
   line(xf1-3,yf1+2,xf1+xscale,yf1+2);
   line(xf1-3,yf1+2,xf1-3,yf1-yscale);
   
   --turn off strokes for the bar charts.
   noStroke();
   
   --loop the chart drawing once.
   for c1 = 0, 1, 1 do
   
   --Set the start x po value.
    xfstart = xf1;  
   
   --Load the file.
   --String[] lines = loadStrings(filename);
	local lines1 = filename
   --Count the number of rows in the file.
   --for  i = 1, #lines1  do
     
     --For each line split values separated by columns o pieces.
     --pieces = split(lines[i], ',');
     local pieces = lines1
     --Set the max Y axis value to be 10 greater than the max value in the pieces array.
     ymax = math.max(unpack(pieces)) + 10;
     
     --Count the number of pieces in the array.
      xcount = #pieces;
     
     --Draw the minimum and maximum Y Axis labels. 
     fill (100);
     textAlign(RIGHT, CENTER);
     text((ymax), xf1-8, yf1-yscale);
     text((ymin), xf1-8, yf1);
     
     --Draw each column in the data series.
     for i2 = 1, xcount do
       
       --Get the column value and set it has the height.
        yheight = (pieces[i2]);
       
       --Declare the variables to hold column height as scaled to the y axis.     

       --calculate the scale of given the height of the chart.
       ypct = yheight / ymax;
       
       --Calculate the scale height of the column given the height of the chart.
       ysclhght = yscale * ypct;
       
       --If the column height exceeds the chart height than truncate it to the max value possible.
       if(ysclhght > yscale) then
         ysclhght = yscale;
       end
       
       --Determine the width of the column placeholders on the X axis.
        xcolumns = xscale / xcount;
       
       --Set the width of the columns to 5 pixels less than the column placeholders.
        xwidth = xcolumns - 5;
       
       --Set the fill color of the columns.
       fill (r1,g1,b1,a1);
       
       --Draw the columns to scale.
       quad(xf1, yf1, xf1, yf1-ysclhght, xf1 + xwidth, yf1-ysclhght, xf1 + xwidth, yf1);
       
       --Draw the labels.
       --textFont(l1);
       textAlign(CENTER, CENTER);
       fill (100);
       
       --Above the columns.
       text(pieces[i2], xf1 + (xwidth / 2), yf1 - (ysclhght + 8));
         --Below the columns.
       text(tags[i2], xf1 + (xwidth / 2), yf1 + 8);
       --increment the x po at which to draw a column.
       xf1 = xf1 + xcolumns;
       end
    --end
  --Reset the draw po the original X value to prevent infinite redrawing to the right of the chart.  
  xf1 = xfstart;
  end
end



function draw()
	
	background(255)
	
	
	
	
	local ycol = 150
	
	local etiqueta = datos[1][1]

	pushMatrix()
	translate(190,150)
	DklRectCatAxis(#(x)*40, LEFT, x, 20)
	popMatrix()
	pushMatrix()
	translate(190,150)
	DklRectCatAxis(#(y)*40, TOP, y, 20)
	popMatrix()
	
	local j = 1
	
	for i = 1, #(datos) do
		if datos[i][1] ~= etiqueta then
			ycol = ycol + 40
			etiqueta = datos[i][1]
			j = 1
		end
		xfila = 190 + (pos(datos[i][2], y)-1)*40
		if datos[i][3] ~= nil then
			if tonumber(datos[i][3])>0.60 then
				fill(255,0,0)
			elseif tonumber(datos[i][3])>0.40 then
				fill(251,239,0)
			elseif tonumber(datos[i][3])>0.20 then
				fill(77,251,0)
			else
				fill(0,66,251)
			end	
		else
			fill(0,66,251)
		end
		event(MOVED)
		local e = rect(xfila, ycol, 40, 40)
		if e then
			fill(171,178,185)
			rect(xfila, ycol, 40, 40)
			text("Valor:",95,650)
			if datos[i][3] ~= nil then
				text(datos[i][3],100,660)
				local auxilisnum = {}
				local auxilistag = {}
				for k=4, #(datos[i]) do
					if (k % 2 == 0) then
						table.insert(auxilistag,datos[i][k])
					else
						table.insert(auxilisnum,datos[i][k])
					end	
				end
				barchart(auxilisnum, 500, 500, 300, 700, 10, 110, 75, 255,auxilistag);

			else 
				text("0",100,660)
			end
			
		end		
		j = j + 1
	end
end


	