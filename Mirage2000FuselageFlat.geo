
oaLength = 7.0;
H = 1.0;
thickness = 0.1;

meshDensity = 0.2;



// Nose
Point(1) = { 0.0, 0.35*H, 0.0, meshDensity };
Point(2) = { 0.12*oaLength, 0.0, 0.0, meshDensity };
Point(3) = { 0.12*oaLength, 0.7*H, 0.0, meshDensity };

// Canopy
Point(4) = { 0.2*oaLength, 1.1*H, 0.0, meshDensity };
Point(5) = { 0.3*oaLength, H, 0.0, meshDensity };

// Tail
Point(6) = { 0.68*oaLength, H, 0.0, meshDensity };
Point(7) = { 0.74*oaLength, 2.5*H, 0.0, meshDensity };
Point(8) = { 0.87*oaLength, 2.5*H, 0.0, meshDensity };
Point(9) = { 0.89*oaLength, H, 0.0, meshDensity };

// Nozzle
Point(12) = { oaLength, 0.1*H, 0.0, meshDensity };
Point(11) = { oaLength, 0.9*H, 0.0, meshDensity };

Point(13) = { 0.9*oaLength, 0.0, 0.0, meshDensity };
Point(10) = { 0.9*oaLength, H, 0.0, meshDensity };

// starting with bottom
Line(1) = { 2, 13 };
Line(2) = { 13, 12 };
Line(3) = { 12, 11 };
Line(4) = { 11, 10 };
Line(5) = { 10, 9 };
Line(6) = { 9, 8 };
Line(7) = { 8, 7 };
Line(8) = { 7, 6 };
Line(9) = { 6, 5 };

Spline(10) = { 3,4,5 };

Line(11) = { 3,1 };
Line(12) = { 1,2 };

Curve Loop(1) = { 1,2,3,4,5,6,7,8,9,-10,11,12 };
Plane Surface(1) = {1};

Extrude { 0.0, 0.0, thickness } { Surface{1}; }




