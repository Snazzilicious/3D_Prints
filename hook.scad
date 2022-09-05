
e=0.1;

thickness = 5;

gap = 17;

radius = gap/2+thickness;

adtlSpace = 2*gap;

module arch(){
	difference(){
		circle( radius );
		circle( radius-thickness );
		translate([-radius,-radius])
		square([2*radius,radius]);
	}
}

linear_extrude(thickness){
	arch();

	translate([0,-gap-adtlSpace])
	rotate([0,0,180])
	arch();

	translate([radius-thickness,-gap-adtlSpace-e/2])
	square([thickness,gap+adtlSpace+e]);
	difference(){
		translate([-radius,-gap-adtlSpace-e/2])
		square([thickness,gap+adtlSpace+e]);

		translate([-radius,-gap-adtlSpace/2-thickness/2])
		square([thickness,gap+thickness]);
	}
	
	translate([-radius+thickness/2,-adtlSpace/2+thickness/2+e/2])
	circle(thickness/2);
	translate([-radius+thickness/2,-gap-adtlSpace/2-thickness/2-e/2])
	circle(thickness/2);
}





