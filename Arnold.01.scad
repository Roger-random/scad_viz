// Baseline triple-panel design as per Arnold Garcia
//
// This is an OpenSCAD project that visualizes the movement of Arnold
// Garcia's triple-panel design.
//
// 2017/05/01 - Roger Cheng

use <time_utility.scad>

// Time ranges for animation

function scrRotate() = timeRanged(0, timePadded(), 0.5);

function scrFlip() = timeRanged(0.5, timePadded(), 1.0);


// Physical construction

screenW = 450;
screenH = 285;
screenD = 5;

module screen()
{
    cube([screenW, screenH, screenD]);
}

module center()
{
    // Center screen sits at default location.
    screen();
}

module left()
{
    // Rotate on hinge between center/left
    rotate([0, -180*scrRotate(), 0])
    
    // Translate for hinge between center/left
    translate([-screenW, 0, 0])
    
    // One instance of screen
    screen();
}

module right()
{
    // Translate back to intended position relative to center
    translate([screenW,0, screenD])
    
    // Rotate on hinge between center/right
    rotate([0, -180*scrRotate(), 0])
    
    // Translate for hinge between center/right
    translate([0, 0, -screenD])
    
    // One instance of screen
    screen();
}

module screenAssembly()
{
    // Translate+Rotate back to proper world location
    rotate([-120, 0, 0])
    translate([screenW/2, screenH, screenD])
    
    // Rotate for screen closing
    rotate([120*scrFlip(), 0, 0])
    
    // Translate for screen assembly hinge
    translate([-screenW/2, -screenH, screenD])
    {
        left();
        center();
        right();
    }
}


screenAssembly();