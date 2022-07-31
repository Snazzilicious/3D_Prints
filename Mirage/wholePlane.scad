


module motorCutOut( length, width, rad, spac ) {
	translate([0,0,length+spac/2.0 - e])
	cylinder(h=spac, r=rad, center=true);
	translate([0,0,length/2.0])
	cube(size=[width,width,length], center=true);
}

// x goes from 0 to 1, t determines thickness
function naca_half_thickness(x,t) = 5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*pow(x,2) + 0.2843*pow(x,3) - 0.1015*pow(x,4));
function naca_pts(t,n,s=1) = concat([ for (x=[0:1/(n-1):1-(1/n)]) [s*x, s*naca_half_thickness(x,t)] ], [[s,0]]);
module wing(rootLength,root_h, tipLength,tip_h, span){

	root_t = 2*root_h / rootLength;
	tip_t = 2*tip_h / tipLength;

	nPtsRoot = 100;
	nPtsTip = 100;
	
	hull(){
		// Root cross section
		linear_extrude(height=e){
			polygon(naca_pts(root_t,nPtsRoot,rootLength));
		}

		// Tip cross section
		translate([rootLength-tipLength,0,span])
		linear_extrude(height=e){
			polygon(naca_pts(tip_t,nPtsTip,tipLength));
		}
	}
}



//module Mirage2000_body(s,l,thickness) {
//	
//	pts = [];
//	
//	linear_extrude(thickness){
//		polygon(pts);
//	}
//}




module Mirage2000_body(s,l,thickness) {
	
	th = 80;
	tw = 90;
	
	linear_extrude(thickness){
		// Nose
		translate([0.35*s,.99*l,0])
		intersection(){
			translate([0.35*s,0,0])
			scale([1,1.7,1])
			circle(r=.70*s);
			translate([-0.35*s,0,0])
			scale([1,1.7,1])
			circle(r=.70*s);
		}
		
		// fuselage
		square([s,0.98*l]);
		
		// canopy
		translate([0.75*s,0.95*l,0])
		rotate([0,0,18])
		intersection(){
			translate([0.35*s,0,0])
			scale([1,1.25,1])
			circle(r=0.70*s);
			translate([-0.35*s,0,0])
			scale([1.1,1.25,1])
			circle(r=0.70*s);
		}
		
		// Exhaust
		difference(){
			translate([s/2,0,0])
			scale([1,2,1])
			circle(r=s/2);
			
			translate([0,-(s+s/1.5),0])
			square([s,s]);
		}
		
		// Tail
		translate([s,0,0])
		difference(){
			square([th,tw]);
			translate([1.2*th,0,0])
			rotate([0,0,45])
			square([th,2*th]);
		}
	}
}


module controlSurface(l,th,d){
	pts = [[0,0],[th,th],[d/2,th],[d,th/2],[d/2,0]];
	
	linear_extrude(l){
		polygon(pts);
	}

	translate([th,th-e,l/10])
	cube(size=[10,10,2]);
}

module controlSurfaceCutout(l,th,d,h=50){
	pts = [[-th,th],[0,0],[0,-h/2],[d,-h/2],[d,h/2],[-th,h/2]];
	
	linear_extrude(l){
		polygon(pts);
	}
}


// Fudge factor
e = 0.001;

// Wing parameters
wingLength = 292.0;
wingRootHeight = 7;

wingTipLength = 20.0;
wingTipHeight = 2.5;

wingSpan = wingLength / 2.0;

// Motor cutout specifications
motor_rad = 4;
motor_length = 23.0;
prop_rad = 35.0;
prop_thick = 10.0;

motor1_pos = wingLength - prop_thick - motor_length - 2*(prop_rad + 5);
motor2_pos = motor1_pos - (prop_thick+1.5*motor_length);

// Aileron and aileron cut out specifications
aileronStart = 15;
aileronLength = 100;
aileronDepth = 30;
aileronThickness = 3;

// rudder and cut out specs
rudderStart = 7;
rudderLength = 40;
rudderDepth = 30;
rudderThickness = 3;

// control surface wiggle room
wiggleRoom = 2;

// Body specifications
fuselageLength = 344.0;
fuselageH = motor_rad + prop_rad + 10;
fuselageThickness = 3.0;

wingPos = 5.0;




difference() {

	union(){
		translate([-fuselageThickness/2,wingLength + wingPos,0])
		rotate([90,0,-90])
		wing( wingLength, wingRootHeight, wingTipLength, wingTipHeight, wingSpan );

		translate([fuselageThickness/2,0,0])
		rotate([0,-90,0])
		Mirage2000_body(fuselageH,fuselageLength,fuselageThickness);

	}

	translate([0,motor1_pos+wingPos,motor_rad-e])
	rotate([-90,0,0])
	motorCutOut( motor_length, 2*motor_rad, prop_rad, prop_thick );

	translate([0,motor2_pos+wingPos,motor_rad-e])
	rotate([-90,0,0])
	motorCutOut( motor_length, 2*motor_rad, prop_rad, prop_thick );
	
	// aileron cut out
	translate([-aileronStart+wiggleRoom,wingPos+aileronDepth,0])
	rotate([90,0,-90])
	controlSurfaceCutout( aileronLength+2*wiggleRoom, 2*aileronThickness, 1.25*aileronDepth );
	
	// rudder cut out
	translate([-fuselageThickness/2,rudderDepth,rudderStart+fuselageH -wiggleRoom])
	rotate([0,0,-90])
	controlSurfaceCutout( rudderLength+2*wiggleRoom, 2*rudderThickness, 1.25*rudderDepth );

}

translate([-aileronStart,wingPos+aileronDepth -3,0])
rotate([90,0,-90])
controlSurface( aileronLength, aileronThickness, aileronDepth );

translate([-fuselageThickness/2, rudderDepth -3, rudderStart+fuselageH])
rotate([0,0,-90])
controlSurface( rudderLength, rudderThickness, rudderDepth );






