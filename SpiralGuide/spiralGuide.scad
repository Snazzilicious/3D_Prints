$fn = 100;
	
	
/*
module line(p1, p2, th = 1, cap_round = true) {
	angle = 90 - atan((p2[1] - p1[1]) / (p2[0] - p1[0]));
	offset_x = 0.5 * th * cos(angle);
	offset_y = 0.5 * th * sin(angle);

	offset1 = [-offset_x, offset_y];
	offset2 = [offset_x, -offset_y];

	if(cap_round) {
		translate(p1) circle(d = th);
		translate(p2) circle(d = th);
	}

	polygon(points=[
		p1 + offset1, p2 + offset1,  
		p2 + offset2, p1 + offset2
	]);
}
*/

module line(point1, point2, width = 1, cap_round = true) {
	angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
	offset_x = 0.5 * width * cos(angle);
	offset_y = 0.5 * width * sin(angle);

	offset1 = [-offset_x, offset_y];
	offset2 = [offset_x, -offset_y];

	if(cap_round) {
		translate(point1) circle(d = width, $fn = 24);
		translate(point2) circle(d = width, $fn = 24);
	}

	polygon(points=[
		point1 + offset1, point2 + offset1,  
		point2 + offset2, point1 + offset2
	]);
}

module polyline(points, width = 1) {
	module polyline_inner(points, index) {
		if(index < len(points)) {
			line(points[index - 1], points[index], width);
			polyline_inner(points, index + 1);
		}
	}

	polyline_inner(points, 1);
}

PI = 3.14159;

h = 10;
thickness = 25;
radius = 12*25.0;
circles = 4; // = radius / space;

space = radius / circles;
step = 0.1;


b = space / 2 / PI;
// one radian is almost 57.2958 degrees
points = [for(theta = [0:step:2 * PI * circles])
	[b * theta * cos(theta * 57.2958), b * theta * sin(theta * 57.2958)]
];

linear_extrude(h)
difference()
{
circle(r=radius+30);
polyline(points, thickness);
}
