use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <BOSL/constants.scad>
use <filter-holder.scad>

// params
layer_h = 0.1;
nozzle = 0.4;
fn = 360/nozzle;
big = 5;


r = 25/2;
d = nozzle*6;

module metric_nut_cut_out(size, depth, height, eps, fn) {
    translate([(1.155*get_metric_nut_size(size=size)*(1+eps))/2,0,0]) {
        scale(1+eps) metric_nut(size=size, hole=false);
        cuboid([depth, get_metric_nut_size(size=size)*(1+eps), get_metric_nut_thickness(size=size)*(1+eps)], align=V_RIGHT+V_UP);
        // difference() {
            cyl(r=(size/2)*(1+eps), h=height, orient=ORIENT_Z,  $fn=fn);
        //     #translate([0,0,get_metric_nut_thickness(size=size)*(1+eps)]) cuboid([(1.155*get_metric_nut_size(size=size)*(1+eps)),(1.155*get_metric_nut_size(size=size)*(1+eps)),layer_h], align=V_UP);
        // }
    }
}
// cylindrical body
difference() {
    tube(h=get_metric_nut_thickness(size=6)+2, ir=r, or=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn);
    zrot_copies(n=3) translate([r, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
}


// tube(h=2, ir=r, or=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn);
// translate([0,0,2]) cyl(h=d, r=r+get_metric_socket_cap_diam(size=6)+3, align=V_UP, $fn=fn);


