use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <BOSL/constants.scad>
use <./../utils.scad>

// params
layer_h = 0.1;
nozzle = 0.4;
// fn = 360/nozzle;
fn = 72;
big = 5;

d = nozzle*6;

module bubble_trap() {
difference() {
    cuboid([15+2*d,15+2*d,5*d], align=V_UP);
    translate([0,0,2.5*d]) cyl(h=10*d, r=5/2, $fn=fn);
}

translate([0,0,5*d+100]) difference() {
    cuboid([15+2*d,15+2*d,5*d], align=V_UP);
    translate([0,0,2.5*d]) cyl(h=10*d, r=5/2, $fn=fn);
}

translate([0,0,5*d]) difference() {
union() {
        difference() {
            cuboid([15+2*d,15+2*d,100], align=V_UP);
            cuboid([15,15,100+big], align=V_UP);
            // #translate([0,-(15+2*d)/2,100]) cyl(h=5*d, r=5/2, $fn=fn, orient=ORIENT_Y);
        }
        translate([0,-(15+2*d)/2,100-(15+2*d)]) cuboid([15+2*d,5*d,15+2*d], align=V_UP+V_FRONT);
    }
    translate([0,-(15+2*d)/2-big,100-(15+2*d)/2]) cyl(h=10*d, r=5/2, $fn=fn, orient=ORIENT_Y);
}
}

h=3;
prismoid(size1=[3, 2], size2=[3/2, 2], h=10, shift=[-3/4, 0], orient=ORIENT_Y);
!prismoid(size1=[5, 2], size2=[5/4, 2], h=2, shift=[-h/8, 0], orient=ORIENT_X);
// difference() {  // cross section
// union() {  // cross section
// bubble_trap();
// }  // cross section
// cuboid([200,200,200], align=V_UP+V_RIGHT);  //cross section
// }  //cross section
