use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <BOSL/constants.scad>
use <./../utils.scad>

// params
layer_h = 0.1;
nozzle = 0.4;
// fn = 360/nozzle;
fn = 120;
big = 5;

r = 25/2; // filter radius
ro = 20/2;  // o-ring id
d = nozzle*6;
e = 1.51; // groove height
// f = 2.90; // groove width
f = 2.;

module inlet() {
    difference() {
        union() {
            difference() {
                cyl(h=d+big, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                cyl(h=20, r=5/2, $fn=fn);
                translate([0,0,2.5]) cyl(h=big, r=ro-nozzle*2, $fn=fn, align=V_UP);
            }
            difference() {
                cyl(h=d+big, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_DOWN);
                cyl(h=20, r=5/2, $fn=fn);
            }
            // cone for pre-filter dead-space
            translate([0,0,d]) tube(h=big, ir1=5/2, ir2=ro-nozzle*2, or=ro-nozzle*2, $fn=fn, align=V_UP);
            // o-ring gland
            translate([0,0,d+big]) difference() {
                tube(h=e, ir=ro-nozzle*2, or=r, $fn=fn, align=V_UP);
                #tube(h=e+big, ir=ro, or=ro+f, $fn=fn, align=V_UP);
            }
        }
        // nut cut-outs
        zrot_copies(n=4) translate([r+nozzle, 0, get_metric_nut_thickness(size=6)/2]) metric_thru_hole(6, 20, 0.1, fn);
    }
}

// TODO: decrease nut cut out scaling slightly for tight fit
module outlet() {
    difference() {
        union() {
            #difference() {
                cyl(h=d+big, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                cyl(h=d+3*big, r=5/2, $fn=fn);
            }
            #difference() {
                cyl(h=4, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_DOWN);
                cyl(h=d+3*big, r=5/2, $fn=fn);
            }
            difference() {
                translate([0,0,d+big]) cyl(h=e, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                translate([0,0,d+big+e]) cyl(h=e+0.1, r=r+nozzle, align=V_DOWN, $fn=fn);
            }
        }
        translate([0,0,d+big]) cyl(h=e, r=r-5+nozzle, $fn=fn, align=V_DOWN); 
        // nut cut-outs
        zrot_copies(n=4) translate([r+nozzle, 0, (get_metric_nut_thickness(size=6)+4-get_metric_nut_thickness(size=6)*(1+0.2))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
    }
}


module filter_support() {
    difference() {
    union() {
        xspread(8*nozzle, n=5) cuboid([2*nozzle, 2*(r-5), e], align=V_UP);
        yspread(8*nozzle, n=5) cuboid([2*(r-5), 2*nozzle, e], align=V_UP);
        tube(h=e, or=r-5, wall=2*nozzle, $fn=fn);
    }
    tube(h=3, ir=r-5, wall=big, $fn=fn);
    }
}

// inlet();

outlet();

// filter_support();