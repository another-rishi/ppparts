include <BOSL/constants.scad>
use <BOSL/shapes.scad>

// parameters
$fs=0.4/2;

nozzle = 0.4;
d = 12*nozzle;
eps = nozzle;

l = 10;
w = 10;
h = 10;


difference() {
    cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
    translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK);
}