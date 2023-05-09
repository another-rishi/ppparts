include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

top_l = 15;
side_l = 15;
w = 10;
thickness = 2;


module bracket() {
    union() {
        difference() {
            union() {
            translate([4,0,0]) color("orange") cuboid([top_l-4, w, thickness], align=V_UP+V_BACK+V_RIGHT);
            difference() {
            difference() {
            difference() {
            translate([0,0,thickness]) cyl(l=w, r=4, orient=ORIENT_Y, align=V_BOTTOM+V_BACK+V_RIGHT, $fn=36);
            translate([4,5,-4+thickness]) cyl(l=20, r=4-thickness, orient=ORIENT_Y, $fn=36);
            }
            translate([thickness+2,-2.5,0]) cuboid([top_l, w+5, side_l], align=V_BOTTOM+V_BACK+V_RIGHT);
            }
            translate([thickness,-2.5,-2]) cuboid([top_l, w+5, side_l], align=V_BOTTOM+V_BACK+V_RIGHT);
            }
            }
            translate([2+get_metric_nut_size(4.4)/2,5,0]) cyl(l=5, r=4.5/2, $fn=36);
        }
        color("orange") translate([0,0,thickness-4]) rotate([0,90,0]) cuboid([side_l-4, w, thickness], align=V_UP+V_BACK+V_RIGHT);
    }
}

bracket();

