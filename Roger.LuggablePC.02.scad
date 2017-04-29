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
    translate([0, screenD*2+gap, 0])
    {
        chassis();
    }
}

// Screen fold animation
lsFoldStart = 0;
lsFoldEnd = 0.4;
function lsFold() = timeRanged(lsFoldStart, timePadded(), lsFoldEnd);

// Screen rotate animation
sRStart = 0.4;
sREnd = 0.7;
function sRotate() = timeRanged(sRStart, timePadded(), sREnd);

// Screen stowage animation
stowStart = 0.7;
stowEnd = 1.0;
function stow() = timeRanged(stowStart, timePadded(), stowEnd);

// Add two instances of screen into the space
translate([screenH/2, screenD*2, screenW]) // Translate screen assembly hinge to final location
rotate([90*stow(), 0, 0]) // Screen stowage animation
rotate([0, 90*sRotate(), 0]) // Screen rotation
rotate([0, 0, -90*lsFold()]) // Screen assembly folding
translate([0, -screenD, -screenH/2]) // Translate screen assembly hinge to origin
union() // Screen assembly
{
    rotate([0, 0, 180*lsFold()]) // Rotate relative to right screen (hinge between screens)
        translate([-screenW, 0, 0]) // Translate into position relative to right screen.
            color([0, 1, 0]) screen(); // Left screen
    color([1, 0, 0]) screen(); // Right screen
}
