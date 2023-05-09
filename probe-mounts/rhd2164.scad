include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

post_r = 5;
post_l = 200;
pcb_ht = 22;
pcb_w = 13.5;
pcb_thick = 1;
post_offset = 30;

rail_l = 10;
v_ht = 2;
v_w = 1;
rail_wall = 1;


module v_rail(l, v_ht, v_w, wall, post_r) {
    translate([0,v_w/2,l/2]) rotate([90, 0, 0]) color("gray", 1.) right_triangle([v_ht, l, v_w], center=true);
    mirror([0, 1, 0]) translate([0,v_w/2,l/2]) rotate([90, 0, 0]) color("gray", 1.) right_triangle([v_ht, l, v_w], center=true);
    translate([-1, 0, 0]) color("gray", 1.) cuboid([wall, 2*v_w, l], align=V_UP+V_LEFT);
    translate([wall, -v_w-(post_r-v_w)/2, 0]) color("gray", 1.) cuboid([wall+v_ht, post_r-v_w, l], align=V_UP+V_LEFT);
}

// post
translate([0, 0, pcb_ht+post_offset]) {
color("gray", 1.) cyl(h=post_l, r=post_r, align=V_UP, $fn=36);
}



// v rail connector
translate([0, v_w, pcb_ht+post_offset]) color("gray", 1.) cuboid([pcb_w+2*rail_wall+2*v_w, post_r+v_w, 3], align=V_UP+V_FRONT);


//// cross-section
//difference() {
//union() {

// v rail 2
mirror([1, 0, 0]) translate([-(pcb_w/2), 0, pcb_ht-rail_l]) v_rail(rail_l+post_offset, v_ht, v_w, rail_wall, post_r);
// tab for m2 nut
    difference() {
difference() {
    difference() {
        union() {
            translate([-pcb_w/2, -pcb_thick/2, pcb_ht]) color("gray", 1.) cuboid([pcb_w, post_r-pcb_thick/2, 5.5], align=V_BOTTOM+V_FRONT+V_RIGHT);
            // v_rail 1
            translate([-(pcb_w/2), 0, pcb_ht-rail_l]) v_rail(rail_l+post_offset, v_ht, v_w, rail_wall, post_r);
        }
        translate([-pcb_w/2+4, 0, pcb_ht-4]) color("red") ycyl(h=12, r=2.4/2, align=V_UP+V_LEFT, $fn=36);
    }
    translate([-pcb_w/2+4-2.4/2, -1.6, pcb_ht-4+2.4/2]) rotate([0, 90, 90]) color("red", 1.) metric_nut(2.2, hole=false, align=V_BOTTOM);
}
translate([-pcb_w/2+4-2.4/2, -1.6, pcb_ht-2]) color("red") cuboid([get_metric_nut_size(2.2), get_metric_nut_thickness(2.2), 10], align=V_BOTTOM+V_FRONT);
}

//} // cross-section
//cuboid([20, 10, 30], align=V_UP+V_FRONT);
//} 




module dummy() {
    // headstage pcb
    difference() {
        color("green") cuboid([pcb_w,pcb_thick,pcb_ht], align=V_UP);
        translate([-pcb_w/2+4, 0, pcb_ht-4]) color("green") ycyl(h=10, r=2.4/2, align=V_UP+V_LEFT, $fn=36);
    }

    translate([-pcb_w/2+4-2.4/2, pcb_thick/2, pcb_ht-4+2.4/2]) rotate([-90, 0, 0]) metric_bolt(headtype="button", size=2, l=4, details=true, phillips="#1");
    translate([-pcb_w/2+4-2.4/2, -1.6-get_metric_nut_thickness(2)/2-pcb_thick, pcb_ht-4+2.4/2]) rotate([0, 90, 90]) metric_nut(size=2, hole=true, pitch=0.4, details=true);
}

//dummy();
