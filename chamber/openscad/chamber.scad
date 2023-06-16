include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>

// use <./../../utils.scad>
include <./ear-bar.scad>

// parameters
fn = 120;

nozzle = 0.4;
big = 20*nozzle;
d = 12*nozzle;
eps = nozzle;

l = 120;
w = 75;
h = 25;

post_mount_l = 20;
post_l = 15;

eb_post_l_offset = 40;
eb_post_h = 20;




m3_c2c = 6.35;

module metric_nut_cut_out(size, depth, height, eps, fn) {
    scale(1+eps) metric_nut(size=size, hole=false);
    cuboid([depth, get_metric_nut_size(size=size)*(1+eps), get_metric_nut_thickness(size=size)*(1+eps)], align=V_RIGHT+V_UP);
    cyl(r=(size/2)*(1+2*eps), h=height, orient=ORIENT_Z, $fn=fn);
}


module metric_thru_hole(size, height, eps, fn) {
    cyl(r=((size/2)*(1+2*eps)), h=height, orient=ORIENT_Z, $fn=fn);
}

module chamber() {
    difference() {
        cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
        translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK, $fn=fn);
        // holes for cannula & grounding wire
        place_copies([[l,(w+2*d)/2,h-1], [l,(w+2*d)/2-w/3,h-1], [l,(w+2*d)/2+w/3,h-1]]) cyl(l=d*5, d=3, orient=ORIENT_X, align=V_RIGHT, $fn=fn);
    }
    translate([-post_mount_l/2,w/2+d,0]) post_mount();
        translate([eb_post_l_offset,-post_mount_l/2,0]) post_mount();
    translate([eb_post_l_offset,w+2*d+post_mount_l/2,0]) post_mount();
    // mounting tabs
    m_tab_w = (get_metric_socket_cap_diam(size=6)+eps)/2;
    translate([-m_tab_w,m_tab_w,0]) mounting_tab();
    translate([-m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();

    // tabs to hold suction from above
    translate([l-10-d,w+d,h+d]) suction_tab();
    translate([2*d,w+d,h+d]) suction_tab();
}

module post_mount() {
    difference() {
        cuboid([post_mount_l,post_mount_l,2*d], align=V_UP);
        translate([0,0,d]) cuboid([post_l,post_l,d+big], align=V_UP);
        cyl(h=2*big, r=4/2, $fn=fn);
        }
    }

module ear_bar_post(h_offset) {
    translate([0,0,d]) difference() {
        color("green") cuboid([post_l-nozzle,post_l-nozzle,h+eb_post_h], align=V_UP);
        eb_scale = (d_bar+2*eps)/d_bar;
        
        translate([0,-l_bar/2,h+eb_post_h-h_offset]) rotate([180,0,90]) scale(eb_scale) ear_bar();
        translate([0,0,h+eb_post_h-h_offset/2-get_metric_nut_thickness(3)/2]) rotate([0,0,-90]) metric_nut_cut_out(3, (post_l-nozzle)/2+big, 15, 0.1, fn);
        translate([0,0,get_metric_nut_thickness(3)/2]) rotate([0,0,-90]) metric_nut_cut_out(3, (post_l-nozzle)/2+big, 15, 0.1, fn);
        
    }
}

module mounting_tab() {
    difference() {
        cuboid([get_metric_socket_cap_diam(size=6)+eps,get_metric_socket_cap_diam(size=6)+eps,2], align=V_UP);
        translate([0,0,2]) cyl(r=7/2, h=5, $fn=fn); 
    }
}

module suction_tab() {
    x = 15;
    y = d;
    z = 10;
    difference() {
        color("green") cuboid([x, y, z],align=V_UP+V_RIGHT+V_BACK);
        translate([x/2,y/2,z/2]) cyl(l=y+5, d=6, orient=ORIENT_Y, $fn=fn);
    }
}

module all_posts() {
    // tooth holder post
    translate([-post_mount_l/2,w/2+d,0]) rotate([0,0,-90]) ear_bar_post(h_offset=8+2.3);
    // ear bar posts
    translate([eb_post_l_offset,-post_mount_l/2,0]) ear_bar_post(h_offset=8);
    translate([eb_post_l_offset,w+2*d+post_mount_l/2,0]) rotate([0,0,180]) ear_bar_post(h_offset=8);
}

chamber();
all_posts();
// ear_bar_post(h_offset=8);
// ear_bar_post(h_offset=8+2.3);
// ear_bar();