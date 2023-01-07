
$fn = 100;

// Fudge factor
e = 0.001;

module crossSec( h, thickness ){
	translate([e,0])
	rotate([0,0,90])
	square([h,thickness]);
	square([h,thickness]);
}


height = 15;
secLength = 80;
wallThickness =0.7;

tailHeight = 35;
tailDepth = 20;

translate([0,0,-tailDepth])
linear_extrude(tailDepth+e)
crossSec( tailHeight, wallThickness );

linear_extrude(secLength+e)
crossSec( height, wallThickness );

translate([0,0,secLength])
linear_extrude(secLength+e)
crossSec( height, wallThickness );

