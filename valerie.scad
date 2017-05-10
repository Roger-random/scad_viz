// Razer Valerie
// 2017/05/10 - Roger Cheng
use <time_utility.scad>

screenW = 450;
screenH = 285;
screenD = 5;

bodyW = screenW;
bodyH = screenH;
bodyD = 20;

// Time utilities
function scrOpen() = timeRanged(0, timePadded(), 0.5);
function scrSlide() = timeRanged(0.5, timePadded(), 1.0);

// Physical construction

module screen()
{
    cube([screenW, screenH, screenD]);
}

module center()
{
    translate([0, 0, -screenD*2])
    screen();
}

module left()
{
    translate([-screenW*scrSlide(), 0, -screenD*scrSlide()])
    translate([0, 0,-screenD])
    screen();
}

module right()
{
    translate([screenW*scrSlide(), 0, -screenD*2*scrSlide()])
    screen();
}

module screenAssembly()
{
    // Translate back to position
    translate([0, screenH, 0])    
    // Screen open hinge rotation
    rotate([-120*scrOpen(), 0, 0])
    // Translate for hinge rotation
    translate([0, -screenH, 0])
    
    // The set of screens
    union()
    {
        color([0.5, 0, 0]) left();
        color([0, 0.5, 0]) center();
        color([0, 0, 0.5]) right();
    }
}

module bodyAssembly()
{
    translate([0, 0, -bodyD-screenD*2])
    cube([bodyW, bodyH, bodyD]);
}

module masterAssembly()
{
    screenAssembly();
    bodyAssembly();
}

masterAssembly();