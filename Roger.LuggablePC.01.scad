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
screenD = 20;


// Chassis bounding box - cutout box
module chassis()
{
    difference() {
        cube([chassisW, chassisD, chassisH]);
        translate([-gap/2, chassisD-cutoutD, chassisH-cutoutH]) 
            cube([chassisW+gap, chassisD-cutoutD+gap, cutoutH+gap]);
    }
}

// Screen bounding box
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

// Add an instance of screen into the space, including animation for hinge operation
color([0, 1, 0])
{
    centerD = screenD/2;

    // Translate the screen to its position relative to chassis.
    translate([chassisW-screenW, 0, chassisH-screenH])
    
    // Translate the screen back to the originally-constructed location.
    translate([screenW-centerD, centerD, screenH-centerD])
    // The two axis of hinge movement
    rotate([0, 90*timeRanged(0, timePadded(), 0.9), 0])
    rotate([0, 0, 180*timeRanged(0.1, timePadded(), 1)])
    {
        // Translate screen to align center of rotation with origin.
        translate([centerD-screenW, -centerD, centerD-screenH])
        {
            screen();
        }
    }
}