include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

module bracket() {
    union() {
        difference() {
            color("orange") cuboid([17, 10, 2], align=V_UP+V_BACK+V_RIGHT);
            translate([2+get_metric_nut_size(4.4)/2,5,0]) cyl(l=5, r=4.5/2, $fn=36);
        }
        color("orange") translate([0,0,2]) rotate([0,90,0]) cuboid([15, 10, 2], align=V_UP+V_BACK+V_RIGHT);
    }
}

bracket();
