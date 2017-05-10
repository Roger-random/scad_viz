// Tri-screen concept "Swiss Army Knife"
// 2017/05/10 - Roger Cheng
use <time_utility.scad>

screenW = 450;
screenH = 285;
screenD = 5;

bodyW = screenW;
bodyH = screenH;
bodyD = 50;

// Time utilities
function scrOpen() = timeRanged(0, timePadded(), 1);
function scrUnfold() = timeRanged(0.2, timePadded(), 1.0);

// Physical construction

module screen()
{
    cube([screenW, screenH, screenD]);
}

module center()
{
    screen();
}

module left()
{
    translate([0, screenH/2, screenD*scrUnfold()])
    rotate([0, 0, 180*scrUnfold()])
    translate([0, -screenH/2, -screenD])
    screen();
}

module right()
{
    translate([screenW, screenH/2, 0])
    translate([0, 0, screenD*2*scrUnfold()])
    rotate([0, 0, -180*scrUnfold()])
    translate([-screenW, -screenH/2, -screenD*2])
    screen();
}

module screenAssembly()
{
    translate([0, screenH/2, screenH*0.75*scrOpen()])
    rotate([75*scrOpen(), 0, 0])
    translate([0, -screenH/2, 0])
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