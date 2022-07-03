
L = 1.0;
W = 0.5;
thickness = 0.1;
r = 0.035;
d = 0.1;

meshDensity = 0.01;

// POINTS

// surface
Point(1) = { 0.0, 0.0, 0.0, meshDensity };
Point(2) = { W, thickness/2, 0.0, meshDensity };
Point(3) = { W, -thickness/2, 0.0, meshDensity };
Point(4) = { W, 0.0, 0.0, meshDensity };

Point(8) = { 0.0, 0.0, L, meshDensity };
Point(9) = { W, thickness/2, L, meshDensity };
Point(10) = { W, -thickness/2, L, meshDensity };
Point(11) = { W, 0.0, L, meshDensity };

// pins
Point(5) = { W, r, -d, meshDensity };
Point(6) = { W, -r, -d, meshDensity };
Point(7) = { W, 0.0, -d, meshDensity };

Point(12) = { W, r, 0.0, meshDensity };
Point(13) = { W, -r, 0.0, meshDensity };
Point(14) = { W, 0.0, 0.0, meshDensity };

Point(15) = { W, r, L, meshDensity };
Point(16) = { W, -r, L, meshDensity };
Point(17) = { W, 0.0, L, meshDensity };

Point(18) = { W, r, L+d, meshDensity };
Point(19) = { W, -r, L+d, meshDensity };
Point(20) = { W, 0.0, L+d, meshDensity };



// CURVES

// surface
Line(1) = {1,2};
Circle(2) = { 3,4,2 };
Line(3) = { 3,1 };

Line(6) = {8,9};
Circle(7) = { 10,11,9 };
Line(8) = { 10,8 };

Line(21) = { 2,9 };
Line(22) = { 3,10 };
Line(23) = { 1,8 };


// pins
Circle(4) = { 6,7,5 };
Circle(5) = { 5,7,6 };

Circle(9) = { 13,14,12 };
Circle(10) = { 12,14,13 };

Circle(11) = { 16,17,15 };
Circle(12) = { 15,17,16 };

Circle(13) = { 19,20,18 };
Circle(14) = { 18,20,19 };

Line(24) = { 5,12 };
Line(25) = { 6,13 };
Line(26) = { 15,18 };
Line(27) = { 16,19 };


// SURFACES

// Surface
// sides
Curve Loop(1) = { 1,-2,3, 9,10 };
Plane Surface(1) = {1};
//Curve Loop(2) = { 6,-7,8, 11,12 };
Curve Loop(2) = { -6,7,-8, -11,-12 };
Plane Surface(2) = {2};

// top & bottom
Curve Loop(3) = { 23, 6, -21, -1 };
Plane Surface(3) = {3};
Curve Loop(4) = { -23, 8, 22, -3 };
Plane Surface(4) = {4};

// leading edge
Curve Loop(5) = { 21, 2, -22, -7 };
Surface(5) = {5};


// Pins
// ends
Curve Loop(6) = {-4,-5};
Plane Surface(6) = {6};
Curve Loop(7) = {13,14};
Plane Surface(7) = {7};

Curve Loop(8) = { 4, 24, -9, -25 };
Surface(8) = {8};
Curve Loop(9) = { 5, -24, -10, 25 };
Surface(9) = {9};

Curve Loop(10) = { 11, 26, -13, -27 };
Surface(10) = {10};
Curve Loop(11) = { 12, -26, -14, 27 };
Surface(11) = {11};

