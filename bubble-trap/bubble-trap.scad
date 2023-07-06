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

// body params
body_width = 15;
body_height = 100;

// snap params
h=4;
z=4;
L=10;
y=2;
hh=4;
alpha=30;
beta=70;

module connector_cutout() {
    union() {
        hull() {
            translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta, cross=false);
            yflip() translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta, cross=false);
        }
        translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
        yflip() translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
    }
}

module bubble_trap() {
difference() {
    cuboid([body_width+2*d,body_width+2*d,5*d], align=V_UP);
    translate([0,0,2.5*d]) cyl(h=10*d, r=5/2, $fn=fn);
}

translate([0,0,5*d+body_height]) difference() {
    cuboid([body_width+2*d,body_width+2*d,5*d], align=V_UP);
    translate([0,0,2.5*d]) cyl(h=10*d, r=5/2, $fn=fn);
}

translate([0,0,5*d]) difference() {
union() {
        difference() {
            cuboid([body_width+2*d,body_width+2*d,body_height], align=V_UP);
            cyl(r=body_width/2, h=body_height+big, align=V_UP, $fn=fn);
        }
        translate([0,-(body_width+2*d)/2,body_height-(body_width+2*d)]) cuboid([body_width+2*d,5*d,body_width+2*d], align=V_UP+V_FRONT);
    }
    translate([0,-(body_width+2*d)/2-big,body_height-(body_width+2*d)/2]) cyl(h=10*d, r=5/2, $fn=fn, orient=ORIENT_Y);
}

translate([0,0,5*d]) translate([(body_width+2*d)/2,0,0]) difference() {
difference() {
    cuboid([5*d,body_width+2*d,body_width+2*d], align=V_UP+V_RIGHT);
    translate([5*d+L-hh,0,(body_width+2*d)/2]) connector_cutout();
}
}


translate([0,0,5*d]) translate([(body_width+2*d)/2,0,body_height-(body_width+2*d)]) difference() {
    cuboid([5*d,body_width+2*d,body_width+2*d], align=V_UP+V_RIGHT);
    translate([5*d+L-hh,0,(body_width+2*d)/2]) connector_cutout();
}
}


cross_section = false;

if (cross_section) {
    difference() {  // cross-section
        bubble_trap();
        cuboid([500,body_width,500], align=V_BACK);  // cross-section
    }  // cross-section
}
else {
    bubble_trap();
}
