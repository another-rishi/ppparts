include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

use <./../openflexure-microscope/openscad/libs/compact_nut_seat.scad>
use <./../openflexure-microscope/openscad/libs/main_body_structure.scad>
use <./../openflexure-microscope/openscad/libs/microscope_parameters.scad>

params = default_params();

echo(params);

////echo(params);
//
////xy_only_body(params);
//
////xy_legs_and_actuators(params);
//
//xy_actuators(params);
//xy_actuators(params, ties_only=false);

////actuator_leg(params);
////actuator_column(actuator_h, join_to_casing=ties);
//leg_frame(params, 0);
//xy_screw_seat(params, "");

// parameters
flex_t = 0.72;
flex_l = 1.5;
alpha = 6;
range = 4;
h = range/tan(alpha);
w = 100;
l = 50;

big = 5;
tiny = 0.4;



// actuator arm
right_triangle([h*0.5, flex_l*2, h*0.9]);
translate([0, w-flex_l*2, 0]) right_triangle([h*0.5, flex_l*2, h*0.9]);
cuboid([h*0.4, w, flex_l], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l, 0, 0]) cuboid([flex_l, w, h], align=V_UP+V_RIGHT+V_BACK);

// passive arm
translate([-l-flex_l*4, 0, 0]) {
mirror([1, 0, 0]) {
right_triangle([10, flex_l*2, h*0.9]);
translate([0, w-flex_l*2, 0]) right_triangle([10, flex_l*2, h*0.9]);
cuboid([8, w, flex_l], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l, 0, 0]) cuboid([flex_l, w, h], align=V_UP+V_RIGHT+V_BACK);
}
}

// actuator
translate([0, w/2, 0]) cuboid([2*h/3, w/10, flex_l*3.4], align=V_UP+V_RIGHT);
translate([2*h/3+3, w/2, 0]) rotate([0, 0, -90]) actuator_column(25, join_to_casing=true);
translate([2*h/3+3, w/2, 0]) rotate([0, 0, -90]) xy_screw_seat(params, "");


// base
difference() {
translate([-flex_l*2-l, -flex_l, 0]) color("green") cuboid([l, w+3*flex_l, flex_l*4], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l*2-l/2, -big/2, -big/2]) color("green") cuboid([l-big, w+big, flex_l*4+big], align=V_UP+V_BACK);
}
translate([-l-flex_l*2, -flex_l*3, 0]) color("red") cuboid([l+flex_l*3+h*0.5, flex_l*2, flex_l*4], align=V_UP+V_BACK+V_RIGHT);
translate([-l-flex_l*2, w+flex_l*2, 0]) color("red") cuboid([l+flex_l*3+h*0.5, flex_l*2, flex_l*4], align=V_UP+V_BACK+V_RIGHT);
translate([h*0.5+big, 0,0]) rotate([0,0,75]) color("green") cuboid([l+flex_l*3+h*0.5, flex_l*2, flex_l*4], align=V_UP+V_BACK+V_RIGHT);
//difference() {
//hull() {
//difference() {
//translate([-flex_l*2-l, -flex_l, 0]) color("green") cuboid([l, w+2*flex_l, flex_l*4], align=V_UP+V_RIGHT+V_BACK);
//translate([-flex_l*2-l/2, -big/2, -big/2]) color("green") cuboid([l-big, w+big, flex_l*4+big], align=V_UP+V_BACK);
//}
//translate([2*h/3+3, w/2, 0]) rotate([0, 0, -90]) linear_extrude(flex_l*4, center=true) { nut_seat_silhouette(); }
//cuboid([h*0.5, flex_l*2, flex_l*4], align=V_UP+V_RIGHT);
//translate([0, w, 0]) cuboid([h*0.5, flex_l*2, flex_l*4], align=V_UP+V_RIGHT+V_BACK);
//}
//scale([0.9,0.9,1.4]) {
//    hull() {
//difference() {
//translate([-flex_l*2-l, -flex_l, 0]) color("green") cuboid([l, w+2*flex_l, flex_l*4], align=V_UP+V_RIGHT+V_BACK);
//translate([-flex_l*2-l/2, -big/2, -big/2]) color("green") cuboid([l-big, w+big, flex_l*4+big], align=V_UP+V_BACK);
//}
//translate([2*h/3+3, w/2, 0]) rotate([0, 0, -90]) linear_extrude(flex_l*4, center=true) { nut_seat_silhouette(); }
//cuboid([h*0.5, flex_l*2, flex_l*4], align=V_UP+V_RIGHT);
//translate([0, w, 0]) cuboid([h*0.5, flex_l*2, flex_l*4], align=V_UP+V_RIGHT+V_BACK);
//}
//}
//}
// table
translate([-flex_l*2-l, 0, h-flex_t]) color("blue") cuboid([l, w, flex_l*3], align=V_UP+V_RIGHT+V_BACK);

// flexures
translate([-flex_l*2,0,0]) color("red") cuboid([flex_l, w, flex_t], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l*3-l,0,0]) color("red") cuboid([flex_l, w, flex_t], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l*2,0,h-flex_t]) color("red") cuboid([flex_l, w, flex_t], align=V_UP+V_RIGHT+V_BACK);
translate([-flex_l*3-l,0,h-flex_t]) color("red") cuboid([flex_l, w, flex_t], align=V_UP+V_RIGHT+V_BACK);
