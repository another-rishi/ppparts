use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <BOSL/constants.scad>
use <filter-holder.scad>

// params
layer_h = 0.1;
nozzle = 0.4;
// fn = 360/nozzle;
fn = 60;
big = 5;

r = 25/2;
d = nozzle*6;
e = 1.51; // groove height
f = 2.90; // groove width

module metric_nut_cut_out(size, depth, height, eps, fn) {
    translate([(1.155*get_metric_nut_size(size=size)*(1+eps))/2,0,0]) {
        scale(1+eps) metric_nut(size=size, hole=false);
        cuboid([depth, get_metric_nut_size(size=size)*(1+eps), get_metric_nut_thickness(size=size)*(1+eps)], align=V_RIGHT+V_UP);
        cyl(r=(size/2)*(1+eps), h=height, orient=ORIENT_Z,  $fn=fn);
    }
}

module inlet() {
    difference() {
        union() {
            difference() {
                cyl(h=d+big, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                cyl(h=d+big, r=5/2, $fn=fn);
                translate([0,0,2.5]) cyl(h=big, r=r-f-nozzle*4, $fn=fn, align=V_UP);
            }
            // cone for pre-filter dead-space
            translate([0,0,d]) tube(h=5, ir1=5/2, ir2=r-f-nozzle*4, or=r-f-nozzle*4, $fn=fn, align=V_UP);
            // o-ring gland
            translate([0,0,d+5]) difference() {
                tube(h=e, ir=r-f-nozzle*4, or=r, $fn=fn, align=V_UP);
                tube(h=e+big, ir=r-f-2*nozzle, or=r-2*nozzle, $fn=fn, align=V_UP);
            }
        }
        // nut cut-outs
        zrot_copies(n=3) translate([r, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
    }
}

module outlet() {
    difference() {
        union() {
            difference() {
                cyl(h=d+big, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                cyl(h=d+3*big, r=5/2, $fn=fn);
            }

            difference() {
                translate([0,0,d+big]) cyl(h=e+nozzle, r=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn, align=V_UP);
                translate([0,0,d+big+e+nozzle]) cyl(h=e+nozzle, r=r, align=V_DOWN, $fn=fn);
            }
        }
        translate([0,0,d+big]) cyl(h=e+nozzle, r=r-5, $fn=fn, align=V_DOWN); 
        // nut cut-outs
        zrot_copies(n=3) translate([r, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
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

// outlet();

filter_support();