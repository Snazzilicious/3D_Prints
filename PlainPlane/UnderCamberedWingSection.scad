
$fn = 100;

// Fudge factor
e = 0.001;

module wingCS(chord,thickness){

	h = 0.04*chord;
	
	peakPt = 0.4*chord;
	
	frontRadius = ( peakPt*peakPt + (h*h) ) / (2*h);
	backRadius = ( (chord-peakPt)*(chord-peakPt) + (h*h) ) / (2*h);
	
	// front arc
	minkowski(){
		intersection(){
			square([peakPt+e,2*h]);
		
			difference(){
				offset(e)
				translate([peakPt,-frontRadius+h])
				circle(r=frontRadius);
				translate([peakPt,-frontRadius+h])
				circle(r=frontRadius);
			}
		}
		
		circle(r=thickness/2);
	}
	
	// back arc
	minkowski(){
		intersection(){
			translate([peakPt-e,0])
			square([chord,2*h]);
			
			difference(){
				offset(e)
				translate([peakPt,-backRadius+h])
				circle(r=backRadius);
				translate([peakPt,-backRadius+h])
				circle(r=backRadius);
			}
		}
		
		circle(r=thickness/2);
	}
}


// Wing parameters
chord = 90.0;
wingThickness = 0.02*chord;
wingSpan = 100;

wallThickness = 0.4;




// wing outer shell
linear_extrude(wingSpan){
	difference(){
		wingCS( chord, wingThickness );
		offset(delta=-wallThickness)
		wingCS( chord, wingThickness );
	}
}

difference()
{
	intersection()
	{
		linear_extrude(wingSpan){
			offset(delta=-e)
			wingCS( chord, wingThickness );
		}
		for(z=[-211:50:100]){
			supportHeight = 30;
			
			translate([0,0,z])
			translate([-chord,-supportHeight,0])
			rotate([0,40,0])
			cube([1.5*wallThickness,3*supportHeight,5*wingSpan]);
			
			translate([0,0,z])
			translate([2*chord,-supportHeight,0])
			rotate([0,-40,0])
			cube([1.5*wallThickness,3*supportHeight,5*wingSpan]);
		}
	}

	linear_extrude(1.1*wingSpan){
		translate([-0.005*chord,0])
		wingCS(1.01*chord,0.2);
	}
}














