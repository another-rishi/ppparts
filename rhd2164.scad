include <BOSL/constants.scad>
use <BOSL/shapes.scad>
//use <BOSL/sliders.scad>
use <BOSL/metric_screws.scad>


module v_rail(l, v_ht, v_w, wall) {
    translate([0,v_w/2,l/2]) rotate([90, 0, 0]) color("gray", 1.) right_triangle([v_ht, l, v_w], center=true);
    mirror([0, 1, 0]) translate([0,v_w/2,l/2]) rotate([90, 0, 0]) color("gray", 1.) right_triangle([v_ht, l, v_w], center=true);
    translate([-1, 0, 0]) color("gray", 1.) cuboid([wall, 2*v_w, l], align=V_UP+V_LEFT);
}

// post
translate([0, 0, 22+30]) {
color("gray", 1.) cyl(h=200, r=5, align=V_UP, $fn=18);
}

// headstage pcb
difference() {
    color("green") cuboid([14,1,22], align=V_UP);
    translate([-7+4, 0, 22-4]) color("red") ycyl(h=10, r=2.5/2, align=V_UP+V_LEFT, $fn=36);
}

// v rails
translate([-7, 0, 22-10]) v_rail(10+30, 2, 1, 0.5);
mirror([1, 0, 0]) translate([-7, 0, 22-10]) v_rail(10+30, 2, 1, 0.5);

// tab for m2 nut
difference() {
    difference() {
        translate([-7, -0.5, 22]) color("gray", 1.) cuboid([14, 2, 5.5], align=V_BOTTOM+V_FRONT+V_RIGHT);
        translate([-7+4, 0, 22-4]) color("red") ycyl(h=10, r=2.5/2, align=V_UP+V_LEFT, $fn=36);
    }
        translate([-3-2.5/2, -2+1.5, 18+2.5/2]) translate([0, -0.5, 0]) rotate([0, 90, 90]) color("red", 1.) metric_nut(2.1, hole=false, align=V_BOTTOM);
}
//echo(get_metric_nut_thickness(2));

// v rail connector
translate([0, 0, 22+30]) color("gray", 1.) cuboid([14+2*0.5+2*1, 2, 3], align=V_UP);