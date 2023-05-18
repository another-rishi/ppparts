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
ir = 25/2;
or = 45/2; 

e = 1.51; // groove height
f = 2.90; // groove width

module o_ring_side() {
difference() {
cyl(h=2*d, r=or, align=V_UP, $fn=fn);

zrot_copies(n=3) translate([ir+d, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_nut_cut_out(size=3, depth=5, height=10, eps=0.1, fn=fn);
}

translate([0,0,2*d]) difference() {
    cyl(h=d, r=ir-nozzle, align=V_UP, $fn=fn);
    translate([0,0,d-e]) tube(h=e+big, or=10+f/2, ir=10, align=V_UP, $fn=fn);
}
}

o_ring_side();

color("purple") translate([0,0,2*d]) difference() {
    union() {
        tube(h=d, ir=ir, or=or, align=V_UP, $fn=fn);
        translate([0,0,d]) tube(h=d, ir=5, or=ir, align=V_UP, $fn=fn);
        translate([0,0,2*d]) tube(h=100, ir=5, or=5+d, align=V_UP, $fn=fn);
    }
    zrot_copies(n=3) translate([ir+d, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_thru_hole(size=3, height=10, eps=0.1, fn=fn);
}