include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>

include <./ear-bar.scad>
use <./chamber.scad>

// parameters
fn = 360;

nozzle = 0.4;
big = 20*nozzle;
d = 12*nozzle;
eps = nozzle;

l = 120;
w = 75;
h = 25;

post_mount_l = 20;
post_l = 15;

eb_post_l_offset = 40;
eb_post_h = 20;

mp_h = 20;
mp_d = 20;

module mounting_post(height) {
    difference() {
        union() {
        difference() {
            cyl(r=mp_d/2, h=height, align=V_UP, $fn=fn);
            xflip() translate([0,0,height-get_metric_nut_thickness(6)*(1+0.1)-2]) metric_nut_cut_out(6, mp_d/2+big, 20, 0.1, fn);
        }

        difference() {
            hull() {
                cyl(h=4, r=mp_d/2, $fn=fn, align=V_UP);
                translate([40,0,0]) cyl(h=4, r=7/2+2, $fn=fn, align=V_UP);
            }

            hull() {
                translate([40,0,0]) cyl(h=4+big, r=7/2, $fn=fn, align=V_UP);
                translate([mp_d/2+7/2+2,0,0]) cyl(h=4+big, r=7/2, $fn=fn, align=V_UP);
            }
        }
        }
    translate([-mp_d/2+3,0,0]) cuboid([mp_d, mp_d, height+big], align=V_UP+V_LEFT);
    }
}

mounting_post(20);