// Triangular wedge tri-screen PC visualization
// Inspired by Star Trek (TOS) briefing room screen
// 2017/05/15 - Roger Cheng
use <time_utility.scad>

screenW = 450;
screenH = 285;
screenD = 5;

bodyW = screenW;
bodyH = screenH;

// Time utilities
function scrRise() = timeRanged(0, timePadded(), 0.25);
function scrMove() = timeRanged(0.25, timePadded(), 0.5);
function scrUnfold() = timeRanged(0.5, timePadded(), 1.0);
function screenDistance() = sqrt(3)*bodyW/6 + screenD;

// Physical construction
module screen()
{
  cube([screenW, screenH, screenD]);
}

module screenCenter()
{
  translate([-screenW/2, screenDistance(), -screenH/2])
  rotate([90, 0, 0])
  screen();
}

module screenLeft()
{
  // Screen hinge rotation
  translate([-screenW/2, screenDistance()-screenD, 0])
  rotate([0, 0, -100*scrUnfold()])
  translate([screenW/2, -screenDistance()+screenD, 0])
  
  // Final position rotation
  rotate([0, 0, 120])
  screenCenter();
}

module screenRight()
{
  // Screen hinge rotation
  translate([screenW/2, screenDistance()-screenD, 0])
  rotate([0, 0, 100*scrUnfold()])
  translate([-screenW/2, -screenDistance()+screenD, 0])
  
  rotate([0, 0, -120])
  screenCenter();
}

module screenAssembly()
{
  translate([0, -screenDistance*scrMove(), 0])
  translate([0, 0, screenH*scrRise()])
  union()
  {
    color([0.5, 0, 0]) screenLeft();
    color([0, 0.5, 0]) screenCenter();
    color([0, 0, 0.5]) screenRight();
  }
}

module bodyWedge()
{
  translate([0, sqrt(3)*bodyW/7, 0])
  cube([bodyW, bodyW, bodyH], center=true);
}

module bodyAssembly()
{
  intersection()
  {
    rotate([0, 0,   60]) bodyWedge();
    rotate([0, 0,  -60]) bodyWedge();
    rotate([0, 0,  180]) bodyWedge();
  }
}

module mainAssembly()
{
  screenAssembly();
  bodyAssembly();
}

mainAssembly();