use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <BOSL/constants.scad>
use <./../utils.scad>
use <./../bubble-trap/bubble-trap.scad>
use <./../filter-holder/filter-holder.scad>

// params
layer_h = 0.1;
nozzle = 0.4;
fn = 72;
big = 5;
d = nozzle*6;

wall_thickness=3;
mounting_plate_height=135;
mounting_plate_width=150;
base_width=50;

bubble_trap_height = 125;
bubble_trap_y = 60;
filter_height = 80;

// bubble-trap params
body_width = 15;
body_height = 100;
r = 15/2;

// filter-holder params
ro = 30/2;  // o-ring id
e = 1.51; // groove height
f = 2.90; // groove width

// snap params
h=4;
z=4;
L=30;
y=2;
hh=4;
alpha=30;
beta=70;


// cantilever_snap(h, z, L, y, hh, alpha, beta);

module bubble_trap_connector() {
union() {
        translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
        yflip() translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
    }
cuboid([h,h,h]);
xflip() union() {
        translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
        yflip() translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
}
}

// bubble_trap_connector();

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

// connector_cutout();

module filter_holder_connector() {
    r = ro+f+nozzle*4+get_metric_socket_cap_diam(6)+2*nozzle;
    translate([r+big,0,0]) difference() {
        union() {
            difference() {
                union() {
                    zrot_copies(n=4) rotate([0,0,45]) translate([(r+3)/2,0,z/2]) cuboid([r+3, 2*big, 2*z], fillet=z, edges=EDGE_TOP_RT+EDGE_BOT_RT, $fn=fn);
            }
            translate([0,0,z/2]) color("green") cyl(h=d+big, r=r, $fn=fn, align=V_UP);  // filter-body size
            }
            cyl(r=2*r/3, h=z, $fn=fn);
        }
        cyl(r=r/3, h=z+big, $fn=fn);
    }

    union() {
        translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
        yflip() translate([0,body_width/6,0]) rotate([0,0,90]) cantilever_snap(h, z, L, y, hh, alpha, beta);
    }
    cuboid([4*big,body_width/3+h,z], align=V_RIGHT);
}

// filter_holder_connector();

module mounting_plate(wall_thickness=3) {
    difference() {
        rotate([0,0,90]) union() {
        translate([0,-wall_thickness/2,0]) cuboid([mounting_plate_width, base_width, wall_thickness], fillet=10, edges=EDGES_Z_BK, align=V_UP+V_BACK); // base
        translate([0,0,wall_thickness]) cuboid([mounting_plate_width, wall_thickness, mounting_plate_height], fillet=10, edges=EDGES_Y_TOP, align=V_UP); // mounting plate
        // translate([0,-wall_thickness/2,wall_thickness]) interior_fillet(l=200, r=10, orient=ORIENT_XNEG, $fn=fn);
        yflip() translate([0,-wall_thickness/2,wall_thickness]) interior_fillet(l=mounting_plate_width, r=10, orient=ORIENT_XNEG, $fn=fn);
        }
        translate([L-hh-wall_thickness/2, bubble_trap_y, bubble_trap_height]) connector_cutout();
        translate([L-hh-wall_thickness/2, bubble_trap_y, bubble_trap_height-(body_height-(body_width+2*d))]) connector_cutout();
        translate([L-hh-wall_thickness/2, -bubble_trap_y, bubble_trap_height]) connector_cutout();
        translate([L-hh-wall_thickness/2, -bubble_trap_y, bubble_trap_height-(body_height-(body_width+2*d))]) connector_cutout();
        translate([L-hh-wall_thickness/2, 0, filter_height]) connector_cutout();
        // slots
        translate([-base_width/2,0,0]) cyl(h=4+big, r=7/2, $fn=fn);
    }
}

// mounting_plate();

assembly = true;

if (assembly) {
    mounting_plate();
    translate([L-hh-wall_thickness/2,0,bubble_trap_height]) union() {
        translate([0, bubble_trap_y, 0]) bubble_trap_connector();
        translate([0, bubble_trap_y, -(body_height-(body_width+2*d))]) bubble_trap_connector();
        translate([0, -bubble_trap_y, 0]) bubble_trap_connector();
        translate([0, -bubble_trap_y, -(body_height-(body_width+2*d))]) bubble_trap_connector();
    }
    translate([r+5+wall_thickness/2+(2*L-2*hh-3),bubble_trap_y,bubble_trap_height-(5*d+(body_width+2*d)/2)-(body_height-(body_width+2*d))]) xflip() color("orange") bubble_trap();
    translate([r+5+wall_thickness/2+(2*L-2*hh-3),-bubble_trap_y,bubble_trap_height-(5*d+(body_width+2*d)/2)-(body_height-(body_width+2*d))]) xflip() color("orange") bubble_trap();

    translate([L-hh-wall_thickness/2,0,filter_height]) filter_holder_connector();
    translate([L-hh-wall_thickness/2+big+(ro+f+nozzle*4+get_metric_socket_cap_diam(6)+2*nozzle),0,filter_height+4+z/2]) color("orange") union() {
        outlet();
        translate([0,0,d+big-e]) filter_support();
        translate([0,0,2*(d+big)+e]) zflip() inlet();
    }

}
else {
    mounting_plate();
    // translate([base_width, base_width, 0]) bubble_trap_connector();
    // translate([base_width, -base_width, 0]) filter_holder_connector();
}
