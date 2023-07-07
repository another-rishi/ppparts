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

r = 25/2; // filter radius
ro = 30/2;  // o-ring id
d = nozzle*6;
e = 1.51; // groove height
f = 2.90; // groove width
// f = 2.;

module inlet() {
    difference() {
        union() {
            difference() {
                cyl(h=d+big, r=ro+f+nozzle*4+get_metric_socket_cap_diam(6), $fn=fn, align=V_UP);
                cyl(h=20, r=5/2, $fn=fn);
                translate([0,0,2.5]) cyl(h=big, r=r-nozzle*2, $fn=fn, align=V_UP);
            }
            difference() {
                cyl(h=d+big, r=ro+f+nozzle*4+get_metric_socket_cap_diam(6), $fn=fn, align=V_DOWN);
                cyl(h=20, r=5/2, $fn=fn);
            }
            // cone for pre-filter dead-space
            translate([0,0,d]) tube(h=big, ir1=5/2, ir2=r-nozzle*2, or=r-nozzle*2, $fn=fn, align=V_UP);
            // o-ring gland
            translate([0,0,d+big]) union() {
                tube(h=e, ir=r-nozzle*2, or=ro+nozzle, $fn=fn, align=V_UP);
                tube(h=e, ir=ro+f, or=ro+f+nozzle, $fn=fn, align=V_UP);
            }
        }
        // nut cut-outs
        zrot_copies(n=3) translate([ro+f+nozzle, 0, get_metric_nut_thickness(size=6)/2]) metric_thru_hole(6, 20, 0.1, fn);
    }
}

// TODO: decrease nut cut out scaling slightly for tight fit
module outlet() {
    difference() {
        union() {
            difference() {
                cyl(h=d+big, r=ro+f+nozzle*4+get_metric_socket_cap_diam(6), $fn=fn, align=V_UP);
                cyl(h=d+3*big, r=5/2, $fn=fn);
            }
            difference() {
                cyl(h=4, r=ro+f+nozzle*4+get_metric_socket_cap_diam(6), $fn=fn, align=V_DOWN);
                cyl(h=d+3*big, r=5/2, $fn=fn);
            }
            difference() {
                translate([0,0,d+big]) cyl(h=e, r=ro+f+nozzle*4+get_metric_socket_cap_diam(6), $fn=fn, align=V_UP);
                translate([0,0,d+big+e]) cyl(h=e+0.1, r=ro+f+nozzle*2, align=V_DOWN, $fn=fn);
            }
        }
        translate([0,0,d+big]) cyl(h=e, r=r-2*nozzle, $fn=fn, align=V_DOWN); 
        translate([0,0,d+big]) cyl(h=layer_h, r=r+nozzle/2, $fn=fn, align=V_DOWN); 
        // nut cut-outs
        zrot_copies(n=3) translate([ro+f+nozzle, 0, (get_metric_nut_thickness(size=6)+4-get_metric_nut_thickness(size=6)*(1+0.2))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
    }
}


module filter_support() {
    difference() {
    union() {
        xspread(8*nozzle, n=6) cuboid([2*nozzle, 2*(r-2*nozzle), e-2*layer_h], align=V_UP);
        yspread(8*nozzle, n=6) cuboid([2*(r-2*nozzle), 2*nozzle, e-2*layer_h], align=V_UP);
        tube(h=e-2*layer_h, or=r-3*nozzle, wall=2*nozzle, $fn=fn);
    }
    tube(h=3, ir=r-3*nozzle, wall=big, $fn=fn);
    }
}

assembly = true;

if (assembly) {
    difference() {
        union() {
            outlet();
            translate([0,0,d+big-e]) filter_support();
            translate([0,0,2*(d+big)+e]) zflip() inlet();
        }
        cuboid([100,100,100], align=V_BACK);
    }
}
else {
    // translate([2*(ro+f+nozzle*4+get_metric_socket_cap_diam(6))+5, 0,0]) inlet();

    // outlet();

    translate([-2*(ro+f+nozzle*4+get_metric_socket_cap_diam(6)), 0,0]) filter_support();
}