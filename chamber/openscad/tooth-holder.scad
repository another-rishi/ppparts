include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

// parameters
fn = 360;


d_bar = 5;
l_tooth = 6.75;
l_bar = 70 - l_tooth;
r_ear = 1.28;
adhesion_offset=0.5;

module tooth_holder() {
    difference() {
            translate([0,0,-adhesion_offset]){
                cyl(l=l_bar, d=d_bar, fillet1=1, orient=ORIENT_X, align=V_UP+V_RIGHT, $fn=fn);
            }
            color("red") cuboid([l_bar,d_bar,adhesion_offset], align=V_BOTTOM+V_RIGHT);
        }


    translate([l_bar,0,0]) {
        difference() {
            translate([0,0,-adhesion_offset]) cyl(l=l_tooth, d=d_bar, orient=ORIENT_X, align=V_UP+V_RIGHT, $fn=fn);
            translate([0,0,d_bar/2-adhesion_offset]) cuboid([l_tooth, d_bar, d_bar], align=V_UP+V_RIGHT);translate([l_tooth-3/2-0.8,0,0]) scale([1,4/3,1]) cyl(r=3/2, h=d_bar, $fn=fn);
            cuboid([l_tooth,d_bar,adhesion_offset], align=V_BOTTOM+V_RIGHT);
        }
    }
}

tooth_holder();
