include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

// parameters
fn = 360;

l_bar = 45;
d_bar = 5;
l_ear = 5.9;
r_ear = 1.28;
adhesion_offset=0.5;

module ear_bar() {
    difference() {
        translate([0,0,-adhesion_offset]){
            cyl(l=l_bar, d=d_bar, fillet1=1, orient=ORIENT_X, align=V_UP+V_RIGHT, $fn=fn);
            translate([l_bar,0,0]) cyl(l=l_ear, r1=d_bar/2, r2=r_ear, fillet2=r_ear-1, orient=ORIENT_X, align=V_UP+V_RIGHT, $fn=fn);
        }

        color("red") cuboid([l_bar+l_ear,d_bar,adhesion_offset], align=V_BOTTOM+V_RIGHT);
    }
}