include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>

include <./ear-bar.scad>

// parameters
$fs=0.4/2;

nozzle = 0.4;
d = 12*nozzle;
eps = nozzle;

l = 150;
w = 100;
h = 20;

//adjustable post
post_w = 5;
bh_h = 30;
bh_w = ceil(get_metric_nut_thickness(3))+4*6*nozzle+post_w;
bh_l = ceil(get_metric_nut_size(3))+4*6*nozzle;

eb_post_w = 15;
eb_post_l_offset = 35;
eb_post_h = 25;

m3_c2c = 6.35;

module chamber() {
    difference() {
        cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
        translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK);
        // holes for cannula & grounding wire
        place_copies([[l,(w+2*d)/2,h-1], [l,(w+2*d)/2-w/3,h-1], [l,(w+2*d)/2+w/3,h-1]]) cyl(l=d*5, d=3, orient=ORIENT_X, align=V_RIGHT);
    }
    // tooth holder adjustable mounting post
    translate([-bh_l,w/2,0]) cuboid([bh_l,bh_w,h+d], align=V_UP+V_RIGHT);
    color("green") translate([-bh_l/2,w/2-bh_w/2,h+d]) adjustable_post();
    // ear bar posts
    ear_bar_post();
    translate([0,w+2*d,0]) mirror([0,1,0]) color("red") ear_bar_post();

    // mounting tabs
    m_tab_w = (get_metric_socket_cap_diam(size=6)+eps)/2;
    translate([-m_tab_w,m_tab_w,0]) mounting_tab();
    translate([-m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();

    // tabs to hold suction from above
    translate([l+2*d-10-5,w+d,h+d]) suction_tab();
    translate([5,w+d,h+d]) suction_tab();
}

module ear_bar_post() {
    //left ear bar post
    difference() {
    color("green") translate([eb_post_l_offset,-eb_post_w,0]) cuboid([eb_post_w,eb_post_w,h+eb_post_h], align=V_UP+V_BACK);
    translate([eb_post_l_offset,-(l_bar+l_ear)/2,d_bar+2*eps-adhesion_offset+h+bh_h/2]) rotate([180,0,90]) scale((d_bar+2*eps)/d_bar) ear_bar();
    union() {
        translate([eb_post_l_offset,-eb_post_w/2,h+eb_post_h-3.75]) rotate([0,0,90]) scale((get_metric_nut_size(size=3)+2*eps)/get_metric_nut_size(size=3)) metric_nut(size=3, hole=false);
        translate([eb_post_l_offset,-eb_post_w/2-1-(m3_c2c+2*eps)/2,h+eb_post_h-3.75]) cuboid([get_metric_nut_size(size=3)+2*eps,(m3_c2c+2*eps)/2+eb_post_w/2+2,get_metric_nut_thickness(size=3)+eps], align=V_UP);
        translate([eb_post_l_offset,-eb_post_w/2,h+eb_post_h-7]) cyl(l=10, d=3+2*eps, orient=ORIENT_Z, align=V_UP);
        }
    }
}

module adjustable_post() {
    difference() {
        difference() {
            difference() {
                cuboid([bh_l, bh_w, bh_h], align=V_UP+V_BACK);
                translate([0, bh_w/2, 3.5]) color("green") cuboid([bh_l+5, post_w+2*eps, bh_h-7], align=V_UP);
            }
            translate([0,bh_w/2,3.5]) color("green") cuboid([3+eps, bh_w+5, bh_h-7], align=V_UP);
        }
        s = (get_metric_nut_size(size=3)+2*eps)/get_metric_nut_size(size=3);
        translate([0,bh_w-get_metric_nut_thickness(size=3)/2-1.5,0]) union() {
            translate([0,0,m3_c2c/2]) rotate([0,90,0]) scale(s) metric_nut(size=3, hole=false, orient=ORIENT_Y, center=true);
            translate([0,0,m3_c2c/2]) color("red") cuboid([get_metric_nut_size(size=3), get_metric_nut_thickness(size=3)+2*eps, bh_h], align=V_UP);
        }
        translate([0,get_metric_nut_thickness(size=3)/2+1.5,0]) union() {
            translate([0,0,m3_c2c/2]) rotate([0,90,0]) scale(s) metric_nut(size=3, hole=false, orient=ORIENT_Y, center=true);
            translate([0,0,m3_c2c/2]) color("red") cuboid([get_metric_nut_size(size=3), get_metric_nut_thickness(size=3)+2*eps, bh_h], align=V_UP);
        }
    }
}

module mounting_tab() {
    difference() {
        cuboid([get_metric_socket_cap_diam(size=6)+eps,get_metric_socket_cap_diam(size=6)+eps,2], align=V_UP);
        translate([0,0,2]) scale([(get_metric_socket_cap_diam(size=6)+2*eps)/get_metric_socket_cap_diam(size=6),(get_metric_socket_cap_diam(size=6)+2*eps)/get_metric_socket_cap_diam(size=6),1]) metric_bolt(size=6,headtype="socket",pitch=0);
    }
}

module suction_tab() {
    x = 15;
    y = d;
    z = 10;
    difference() {
        color("green") cuboid([x, y, z],align=V_UP+V_RIGHT+V_BACK);
        translate([x/2,y/2,z/2]) cyl(l=y+5, d=6, orient=ORIENT_Y);
    }
}

// difference() {
chamber();
// translate([-bh_l/2, -20, 0]) cuboid([bh_l/2+5, w*2, h*4], align=V_UP+V_LEFT+V_BACK);}
