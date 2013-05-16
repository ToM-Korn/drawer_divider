/* box-generator
 * ==============
 * 
 * a open scad project that lets you create dxf files to 
 * laser cut or cnc mill dividers for any drawer  
 * 
 * Copyright (C) 2013  ToM Krickl <thomas@krickl.eu>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * The latest version can be found here:
 * http://www.thingiverse.com/thing:70338
 * https://github.com/ToM-Korn/drawer_divider
 * 
 * contibutions welcome! please send me pull requests!
 * 
 * Changelog:
 * 
 * 2013-04-06, ToM
 * generated - posted
 * 
 * ToDo:
 * Test with different materials - add a material chooser for balancing
 * inaccuracy in cutting different materials
 */

/* [Box / Divider Size] */

// The width of your drawer/box
Box_width = 300;
// The depth of your drawer/box
Box_depth = 200;
// The depth of your drawer/box
Box_Hight = 100;
// The hight of the dividers
Divider_Hight = 50;
// The thickness of the material you are cutting the dividers out
Material_Thickness = 4;

/* [Specaial Features] */

//Would you like to have a hole on one side of the Box
With_Pull_Hole = 1; // [0:Yes, 1:No]
// How big should the whole to pull be?
Pull_Hole_Diameter_Size = 20;

/* [Separation Settings] */

// Choose if you want to have fixed number of boxes with all the same size or a fixed value for a box that will be repeated as often as possible
fixed_number_b = 1; // [0:FixedSize, 1:FixedNumber]

// Choose how many horizontal boxes you want to have
boxes_horizontal_int = 2;
// Choose how many vertical boxes you want to have
boxes_vertical_int = 4;
// Choose the fixed width of a box (only works with fixed_number set to FixedSize (0))
boxes_width_int = 10;
// Choose the fixed depth of a box (only works with fixed_number set to FixedSize (0))
boxes_depth_int = 10;


/* [Output] */

// Choose if you want just the two major (horizontal and vertical) parts or all parts that will be needed to cut the box dividers
all_parts_b = 0; // [0:JustMajorParts, 1:AllParts]


// Choose distance between parts
distance_int = 5;

module comb_hor(parts_int) {
	for (multiplyer_int = [0:parts_int]){
	difference(){
		translate(v=[0,(-Divider_Hight/2-distance_int/2)-(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Box_width
		,Divider_Hight],center=true);
		if (fixed_number_b){
			for (x=[1:boxes_vertical_int-1]){
				translate(v=[-(Box_width
				/2)+(Box_width
			/boxes_vertical_int)*x,(-Divider_Hight/2-distance_int/2)+(Divider_Hight/4)-(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Material_Thickness,Divider_Hight/2+2],center=true);
			
			}
		}
		else {
			for (x=[1:round(Box_width
			/boxes_width_int)-1]){
				translate(v=[-(Box_width
				/2)+boxes_width_int*x,(-Divider_Hight/2-distance_int/2)+(Divider_Hight/4)-(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Material_Thickness,Divider_Hight/2+2],center=true);
			}
		}
	}
    }
}

module comb_ver(parts_int) {
	for (multiplyer_int = [0:parts_int]){
		difference(){
			translate(v=[0,(Divider_Hight/2+distance_int/2)+(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Box_depth	,Divider_Hight],center=true);
		if (fixed_number_b){
			for (x=[1:boxes_horizontal_int-1]){
				translate(v=[-(Box_depth/2)+(Box_depth	/boxes_horizontal_int)*x,((Divider_Hight/2+distance_int/2)-(Divider_Hight/4))+(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Material_Thickness,Divider_Hight/2+2],center=true);
			
			}
		} else {
			for (x=[1:round(Box_depth/boxes_depth_int)-1]){
				translate(v=[-(Box_depth/2)+boxes_depth_int*x,((Divider_Hight/2+distance_int/2)-(Divider_Hight/4))+(multiplyer_int*(Divider_Hight+distance_int)),0]) square(size=[Material_Thickness,Divider_Hight/2+2],center=true);
			}
		}
		}
	}	
    
}

if (all_parts_b) {
	if (fixed_number_b){
		comb_hor(boxes_horizontal_int-2);
		comb_ver(boxes_vertical_int-2);
	} else {
		comb_hor(round(Box_depth/boxes_depth_int)-2);
		comb_ver(round(Box_width
		/boxes_width_int)-2);
	}
	
} else {
	comb_hor(0);
	comb_ver(0);
}



