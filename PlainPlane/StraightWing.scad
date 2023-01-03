
$fn = 100;

// Fudge factor
e = 0.001;

// x goes from 0 to 1, t determines thickness
function naca_half_thickness(x,t) = 5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*pow(x,2) + 0.2843*pow(x,3) - 0.1015*pow(x,4));
function naca_pts(t,n,s=1) = concat([ for (x=[0:1/(n-1):1-(1/n)]) [s*x, s*naca_half_thickness(x,t)] ], [[s,0]]);
module wingCS(Length,h){

	tt = 2*h / Length;

	nPts = 100;
	
	polygon(naca_pts(tt,nPts,Length));
}


// Wing parameters
wingLength = 90.0;
wingHeight = 7;

wingSpan = 100;

wallThickness = 0.4;

// wing outer shell
linear_extrude(wingSpan){
	difference(){
		offset(delta=wallThickness)
		wingCS( wingLength, wingHeight );
		wingCS( wingLength, wingHeight );
	}
}

// internal supports
difference()
{
	intersection()
	{
		linear_extrude(wingSpan){
			offset(delta=e)
			wingCS( wingLength, wingHeight );
		}
		for(x=[-104:50:200]){
			translate([0,0,x])
			translate([0,-wingHeight,0])
			rotate([0,40,0])
			cube([1.5*wallThickness,3*wingHeight,5*wingSpan]);
			
			translate([0,0,x])
			translate([wingLength,-wingHeight,0])
			rotate([0,-40,0])
			cube([1.5*wallThickness,3*wingHeight,5*wingSpan]);
		}
	}
translate([-2*e,-2*e,-2*e])
cube([1.1*wingLength,0.1+wallThickness+2*e,1.1*wingSpan]);


translate([0.16*wingLength, 0.15*wingHeight, -e])
cylinder(r=0.55*wingHeight, h=1.1*wingSpan);

translate([0.39*wingLength, 0.15*wingHeight, -e])
cylinder(r=0.6*wingHeight, h=1.1*wingSpan);

translate([0.6*wingLength, 0.15*wingHeight, -e])
cylinder(r=0.45*wingHeight, h=1.1*wingSpan);
}






















