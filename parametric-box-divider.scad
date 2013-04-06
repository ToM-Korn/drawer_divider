/* drawer_divider
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

// The width of your drawer
drawer_width_int = 200;
// The depth of your drawer
drawer_depth_int = 200;
// The hight of the diveders
divider_hight_int = 50;

// The thickness of the material you are cutting the dividers out
material_thickness_int = 4;

// Choose if you want to have fixed number of boxes with all the same size or a fixed value for a box that will be repeaded as often as possible
fixed_number_b = 1; // [0:FixedSize, 1:FixedNumber]

// Choose if you want just the two major (horizontal and vertical) parts or all parts that will be needed to cut the box divider
all_parts_b = 1; // [0:JustMajorParts, 1:AllParts]

// Choose how many horizontal boxes you want to have
boxes_horizontal_int = 4;
// Choose how many vertical boxes you want to have
boxes_vertical_int = 4;
// Choose the fixed lenght of a box (only works with fixed_number set to zero)
boxes_width_int = 0;
// Choose the fixed depth of a box (only works with fixed_number set to zero)
boxes_depth_int = 0;

// Choose distance between parts
distance_int = 5;

module comb_hor(parts_int) {
	for (multiplyer_int = [0:parts_int]){
	difference(){
		translate(v=[0,(-divider_hight_int/2-distance_int/2)-(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[drawer_width_int,divider_hight_int],center=true);
		if (fixed_number_b){
			for (x=[1:boxes_horizontal_int-1]){
				translate(v=[-(drawer_width_int/2)+(drawer_width_int/boxes_horizontal_int)*x,(-divider_hight_int/2-distance_int/2)+(divider_hight_int/4)-(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[material_thickness_int,divider_hight_int/2+2],center=true);
			
			}
		}
		else {
			for (x=[1:round(drawer_width_int/boxes_width_int)-1]){
				translate(v=[-(drawer_width_int/2)+boxes_width_int*x,(-divider_hight_int/2-distance_int/2)+(divider_hight_int/4)-(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[material_thickness_int,divider_hight_int/2+2],center=true);
			}
		}
	}
    }
}

module comb_ver(parts_int) {
	for (multiplyer_int = [0:parts_int]){
		difference(){
			translate(v=[0,(divider_hight_int/2+distance_int/2)+(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[drawer_depth_int,divider_hight_int],center=true);
		if (fixed_number_b){
			for (x=[1:boxes_vertical_int-1]){
				translate(v=[-(drawer_depth_int/2)+(drawer_depth_int/boxes_vertical_int)*x,((divider_hight_int/2+distance_int/2)-(divider_hight_int/4))+(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[material_thickness_int,divider_hight_int/2+2],center=true);
			
			}
		} else {
			for (x=[1:round(drawer_depth_int/boxes_depth_int)-1]){
				translate(v=[-(drawer_depth_int/2)+boxes_depth_int*x,((divider_hight_int/2+distance_int/2)-(divider_hight_int/4))+(multiplyer_int*(divider_hight_int+distance_int)),0]) square(size=[material_thickness_int,divider_hight_int/2+2],center=true);
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
		comb_hor(round(drawer_width_int/boxes_width_int)-2);
		comb_ver(round(drawer_depth_int/boxes_depth_int)-2);
	}
	
} else {
	comb_hor(0);
	comb_ver(0);
}



