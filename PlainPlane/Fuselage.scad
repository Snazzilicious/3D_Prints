
$fn = 100;
// Fudge factor
e = 0.001;

width = 20;
height = 20;
length = 150;
wallThickness = 0.8;

trailLength = 50;
trailingSize = 5*wallThickness;

module mainCrossSection(w,h){

	cornerRadius = w / 4;
	
	difference(){
		translate([cornerRadius,cornerRadius])
		offset(r=cornerRadius)
		square([w-2*cornerRadius,h-cornerRadius]);
		
		translate([-e,h])
		square([w+2*e,cornerRadius+e]);
	}
}


// Main fuselage
linear_extrude(length){
	difference(){
		mainCrossSection(width,height);
	
		offset(-wallThickness)
		mainCrossSection(width, height);
	}
}

// trailing section
difference()
{
	hull()
	{
		linear_extrude(e)
		mainCrossSection(width,height);
		
		translate([0,0,-trailLength])
		linear_extrude(e){
			translate([ (width-trailingSize)/2, height-trailingSize ])
			mainCrossSection(trailingSize,trailingSize);
		}
	}

	hull()
	{
		linear_extrude(2*e){
			offset(-wallThickness)
			mainCrossSection(width,height);
		}
		
		translate([0,0,-trailLength-e])
		linear_extrude(2*e){
			translate([ (width-trailingSize)/2, height-trailingSize ])
			offset(-wallThickness)
			mainCrossSection(trailingSize,trailingSize);
		}
	}
}






