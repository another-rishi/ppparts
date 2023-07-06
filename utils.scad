use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
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

module cantilever_snap(h, z, L, y, hh, alpha, beta, cross=true) {
    prismoid(size1=[h, z], size2=[h/2, z], h=L, shift=[-h/4, 0], orient=ORIENT_Y);
    if (cross) {
        translate([h/2,L-(hh-y*cos(alpha)-y*cos(beta))/2-y*cos(alpha),0]) rotate([90,0,90]) union() {
            translate([y*cos(alpha)/2+(hh-y*cos(alpha)-y*cos(beta))/2,0,0]) right_triangle([y*cos(alpha), z, y], center=false);
            translate([-y*cos(beta)/2-(hh-y*cos(alpha)-y*cos(beta))/2,0,0]) xflip() right_triangle([y*cos(beta), z, y], center=false);
            cuboid([hh-y*cos(alpha)-y*cos(beta),z,y], align=V_UP);
        }
    }
}