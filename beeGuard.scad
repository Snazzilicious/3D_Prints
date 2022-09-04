
thickness = 1.0;
space = 1.9;
radius = 15;

gapSize = (radius-3*space) / 2;

spoutRadius = 3.6;

holeRadius = 2;

dths=[60, 45, 30, 45, 60];

intersection(){
//difference(){

	difference(){
		sphere(radius);
		sphere(radius-thickness);
		
		for(ph=[-60:30:60]){
			dth = dths[ (ph/30)+2 ];
			for(th=[0:dth:180]){
				rotate([0,th,0])
				rotate([0,0,ph])
				cube([2*radius+1,gapSize,gapSize],center=true);
			}
		}
		
		translate([0,radius-thickness,0])
		rotate([90,0,0])
		cylinder(3*thickness,r=holeRadius,center=true);

		translate([0,-(radius-thickness),0])
		rotate([90,0,0])
		cylinder(3*thickness,r=spoutRadius,center=true);
	}

	translate([0,.75*radius,0])
	cube([3*radius,1.5*radius,3*radius],center=true);
}


