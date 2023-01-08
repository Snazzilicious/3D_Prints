
$fn = 100;

// Fudge factor
e = 0.001;

module crossSec( h, w ){
	translate([e,0])
	rotate([0,0,90])
	square([h,w]);
	square([h,w]);
}


height = 15;
width = 2.0;
secLength = 80;
wallThickness =0.4;

tailHeight = 35;
tailDepth = 20;

// Outer shell
translate([0,0,-tailDepth])
linear_extrude(tailDepth+e)
difference(){
	crossSec( tailHeight, width );
	offset(-wallThickness)
	crossSec( tailHeight, width );
}

linear_extrude(secLength-tailDepth+e)
difference(){
	crossSec( height, width );
	offset(-wallThickness)
	crossSec( height, width );
}

translate([0,0,secLength-tailDepth])
linear_extrude(secLength+e)
difference(){
	crossSec( height, width );
	offset(-wallThickness)
	crossSec( height, width );
}

//union(){
//	translate([0,0,-tailDepth])
//	linear_extrude(tailDepth+e)
//	crossSec( tailHeight, width );

//	linear_extrude(secLength-tailDepth+e)
//	crossSec( height, width );

//	translate([0,0,secLength-tailDepth])
//	linear_extrude(secLength+e)
//	crossSec( height, width );
//}
