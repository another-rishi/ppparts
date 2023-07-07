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

d = nozzle*6;  // perimeter thickness
c0 = layer_h*7;  // bottom thickness
c1 = layer_h*6;  // top thickness

// body params
r = 15/2;
cap_h = 5;
x_b = 2*sqrt(r^2-cap_h^2);
y_b = r + 5;

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
rotate([0,0,90]) difference() {  // output block
    linear_extrude(height=5*d) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
    cyl(h=10*d, r=5/2, $fn=fn);
}
translate([0,0,5*d+body_height]) rotate([0,0,90]) difference() {  // input block
    linear_extrude(height=5*d) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
    cyl(h=10*d, r=5/2, $fn=fn);
}

translate([0,0,5*d]) difference() {  // body
union() {
        rotate([0,0,90]) difference() {
            linear_extrude(height=body_height) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
            translate([0,0,-big/2]) linear_extrude(height=body_height+big) teardrop2d(r=r-d, ang=30, cap_h=cap_h-c0, $fn=fn);
        }
        translate([0,0,body_height-5/2*d]) {  // bleed socket
            difference() {
            hull() {
            translate([-cap_h,r,0]) cuboid([r+cap_h,5*d,5*d], align=V_RIGHT+V_BACK);
            translate([0,0,-5/2*d]) rotate([0,0,90]) 
            linear_extrude(height=5*d) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
            }
            translate([0,0,-5/2*d-big/2]) rotate([0,0,90]) linear_extrude(height=5*d+big) teardrop2d(r=r-d, ang=30, cap_h=cap_h-c0, $fn=fn);
            }
        }
        translate([0,0,body_height-(body_width+2*d)])  difference() {  // top connector socket
        hull() {
        translate([r,0,0]) cuboid([L/2,2*r,body_width+2*d], align=V_UP+V_RIGHT);
        rotate([0,0,90]) linear_extrude(height=body_width+2*d) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
        }
        translate([0,0,-big/2]) rotate([0,0,90]) linear_extrude(height=body_width+2*d+big) teardrop2d(r=r-d, ang=30, cap_h=cap_h-c0, $fn=fn);
        translate([r+3*L/2-hh-c1,0,(body_width+2*d)/2]) connector_cutout();
        }
    }
    translate([0,(body_width+2*d)/2+big,body_height-5/2*d]) cyl(h=10*d, r=5/2, $fn=fn, orient=ORIENT_Y);
}

// echo((hh/2+body_width/6)*2);

translate([0,0,5*d]) difference() {  // bottom connector socket
    hull() {
    translate([r,0,0]) cuboid([L/2,2*r,body_width+2*d], align=V_UP+V_RIGHT);
    rotate([0,0,90]) linear_extrude(height=body_width+2*d) teardrop2d(r=r, ang=30, cap_h=cap_h, $fn=fn);
    }
    translate([0,0,-big/2]) rotate([0,0,90]) linear_extrude(height=body_width+2*d+big) teardrop2d(r=r-d, ang=30, cap_h=cap_h-c0, $fn=fn);
    translate([r+3*L/2-hh-c1,0,(body_width+2*d)/2]) connector_cutout();
}
}


cross_section = false;

if (cross_section) {
    difference() {  // cross-section
        bubble_trap();
        cuboid([body_width,500,500], align=V_LEFT);  // cross-section
    }  // cross-section
}
else {
    bubble_trap();
}
