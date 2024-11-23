
$fn = 100;

thickness = 3.0;
width = 1.5*(25.4);
length = 235.0;//10.25*(25.4);

hole_spacing = 25.4;
hole_radius = 3.0;

n_holes = floor(length / hole_spacing)-1;

holes_start = (length - n_holes*hole_spacing)/2;


corner_radius = 3;


difference(){

	linear_extrude(height=thickness){
		hull(){
			translate([corner_radius, width/2 - corner_radius])
			circle(r = corner_radius, $fn = 24);
			translate([corner_radius, -width/2 + corner_radius])
			circle(r = corner_radius, $fn = 24);
			translate([length - corner_radius, width/2 - corner_radius])
			circle(r = corner_radius, $fn = 24);
			translate([length - corner_radius, -width/2 + corner_radius])
			circle(r = corner_radius, $fn = 24);
		}
	}

	for(i=[0:1:n_holes]){
		translate([i*hole_spacing + holes_start, 0, 0])
		cylinder(3*thickness,r=hole_radius,center=true);
	}

}
