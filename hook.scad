
e=0.1;

thickness = 10;

gap = 20;

radius = gap/2+thickness;

adtlSpace = gap;

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

		translate([-radius,-gap-adtlSpace/2])
		square([thickness,gap]);
	}
}





