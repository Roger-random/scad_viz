// Learning exercise to put the Luggable PC hinge visualization into OpenSCAD
// 2017/04/28 - Roger Cheng
use <time_utility.scad>

// Gap in between pieces for 3D printer tolerance. Also useful for CSG difference()
gap = 0.25;

// Main chassis dimensions

// The width, depth, and height of the bounding box
chassisW = 285;
chassisD = 140;
chassisH = 440;

// The depth and height of the cutout
cutoutD = 65;
cutoutH = 170;

// Screen dimensions, as measured when open (so 90 degrees off from chassis)
screenW = chassisH;
screenH = chassisW;
screenD = 10;


// Chassis bounding box - cutout box
module chassis()
{
    difference() {
        cube([chassisW, chassisD, chassisH]);
        translate([-gap/2, chassisD-cutoutD, chassisH-cutoutH]) 
            cube([chassisW+gap, chassisD-cutoutD+gap, cutoutH+gap]);
    }
}

// Single screen bounding box
module screen()
{
    cube([screenW, screenD, screenH]);
}

// Put an instance of chassis in the space, translated a bit to make room for screen.
color([0, 0, 1])
{
    translate([0, screenD+gap, 0])
    {
        chassis();
    }
}

// Add two instances of screen into the space

// Left screen
translate([chassisW-screenW-(chassisW/2), 0, chassisH-(screenH/2)])
    color([0, 1, 0]) screen();

// Right screen
translate([chassisW-(chassisW/2), 0, chassisH-(screenH/2)])
    color([0, 1, 1]) screen();
