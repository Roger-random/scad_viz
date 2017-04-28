// Utility functions to help manage time steps $t
// 2017/04/28 - Roger Cheng

// Returns 0-1 for the portion of time between start/end.
function timeRanged(start, current, end) = 
    current<=start? 0 : 
        (current>=end ? 1 : 
            ((current-start)/(end-start)));

// Symmetric animation 0 to 1 to 0 while $t goes 0 to 1
function timeSymmetric() = abs($t-0.5)*2;

// A little padding on either end of timeSymmetric()
padStart=0.1;
padEnd=0.9;
function timePadded() = timeRanged(padStart, timeSymmetric(), padEnd);