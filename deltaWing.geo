
length = 3.0;
h_root = .15;
rootPeak = 2.0/3.0;

span = length / 2.0;

tipLength = 0.2;
h_tip = 0.05;
tipPeak = 2.0/3.0;

meshDensity = 0.2;

// Wing root
Point(1) = { 0.0, 0.0, 0.0, meshDensity };
Point(2) = { 0.0, length, 0.0, meshDensity };
Point(3) = { 0.0, rootPeak*length, h_root, meshDensity };

// wing tip
Point(4) = { span, 0.0, 0.0, meshDensity };
Point(5) = { span, tipLength, 0.0, meshDensity };
Point(6) = { span, tipPeak*tipLength, h_tip, meshDensity };


// Bottom surface
Line(1) = { 1, 2 };
Line(2) = { 2, 5 };
Line(3) = { 5, 4 };
Line(4) = { 4, 1 };

Curve Loop(1) = { 1,2,3,4 };
Plane Surface(1) = { 1 };

// Root cross section
Spline(5) = { 1,3,2 };

Curve Loop(2) = { -1, 5 };
Plane Surface(2) = { 2 };

// Tip cross section
Spline(7) = { 4,6,5 };

Curve Loop(3) = { -3, -7 };
Plane Surface(3) = { 3 };

// Top Surface
Curve Loop(4) = { -2,-5, -4,7 };
Surface(4) = { 4 };

// Crest
//Line(9) = { 3, 6 };






