use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
include <BOSL/constants.scad>

module metric_nut_cut_out(size, depth, height, eps, fn) {
    translate([(1.155*get_metric_nut_size(size=size)*(1+eps))/2,0,0]) {
        scale(1+eps) metric_nut(size=size, hole=false);
        cuboid([depth, get_metric_nut_size(size=size)*(1+eps), get_metric_nut_thickness(size=size)*(1+eps)], align=V_RIGHT+V_UP);
        cyl(r=(size/2)*(1+2*eps), h=height, orient=ORIENT_Z,  $fn=fn);
    }
}


module metric_thru_hole(size, height, eps, fn) {
    translate([(1.155*get_metric_nut_size(size=size)*(1+eps))/2,0,0]) cyl(r=((size/2)*(1+2*eps)), h=height, orient=ORIENT_Z,  $fn=fn);
}