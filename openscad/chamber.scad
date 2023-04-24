include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>

include <./ear-bar.scad>

// parameters
$fs=0.4/2;

// TODO: increase wall thickness; 1st print loses rigidity with hot water in chamber
nozzle = 0.4;
d = 6*nozzle;
eps = nozzle;

// TODO: decrease height & increase width & length
l = 120;
w = 60;
h = 30;

//adjustable post
post_w = 5;
bh_h = 30;
bh_w = ceil(get_metric_nut_thickness(3))+4*d+post_w;
bh_l = ceil(get_metric_nut_size(3))+4*d;

eb_post_w = 7;
eb_post_l_offset = 35;
eb_post_h = 25;

m3_c2c = 6.35;

module chamber() {
    difference() {
        cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
        translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK);
        // holes for cannula & grounding wire
        translate([l,(w+2*d)/2,h-2]) cyl(l=5, d=2, orient=ORIENT_X, align=V_RIGHT);
        translate([l,(w+2*d)/2-w/3,h-2]) cyl(l=5, d=2, orient=ORIENT_X, align=V_RIGHT);
        translate([l,(w+2*d)/2+w/3,h-2]) cyl(l=5, d=2, orient=ORIENT_X, align=V_RIGHT);
    }
    // tooth holder adjustable mounting post
    translate([-bh_l,w/2,0]) cuboid([bh_l,bh_w,h+d], align=V_UP+V_RIGHT);
    color("green") translate([-bh_l/2,w/2-bh_w/2,h+d]) adjustable_post();
    // ear bar posts
    ear_bar_post();
    translate([0,w+2*d,0]) mirror([0,1,0]) color("red") ear_bar_post();

    // mounting tabs
    m_tab_w = (get_metric_socket_cap_diam(6)+eps)/2;
    translate([-m_tab_w,m_tab_w,0]) mounting_tab();
    translate([-m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,m_tab_w,0]) mounting_tab();
    translate([l+2*d+m_tab_w,w+2*d-m_tab_w,0]) mounting_tab();

    // tabs to hold suction from above
    translate([l+2*d-10-5,w+d,h+d]) suction_tab();
    translate([5,w+d,h+d]) suction_tab();
}

// TODO: increase scaling of nut & bolt cutouts
module ear_bar_post() {
    //left ear bar post
    difference() {
    color("green") translate([eb_post_l_offset,-eb_post_w,0]) cuboid([eb_post_w,eb_post_w,h+eb_post_h], align=V_UP+V_BACK);
    translate([eb_post_l_offset,-(l_bar+l_ear)/2,d_bar+eps-adhesion_offset+h+bh_h/2]) rotate([180,0,90]) scale((d_bar+eps)/d_bar) ear_bar();
    union() {
        translate([eb_post_l_offset,-eb_post_w/2,h+eb_post_h-3.75]) rotate([0,0,90]) metric_nut(3, hole=false);
        translate([eb_post_l_offset,-eb_post_w/2-1-m3_c2c/2,h+eb_post_h-3.75]) cuboid([get_metric_nut_size(3),m3_c2c/2+eb_post_w/2+2,get_metric_nut_thickness(3)], align=V_UP);
        translate([eb_post_l_offset,-eb_post_w/2,h+eb_post_h-7]) cyl(l=10, d=3+eps, orient=ORIENT_Z, align=V_UP);
        }
    }
}

// TODO: increase scaling of nut cutouts; M3 bolts were fine on first print.
module adjustable_post() {
    difference() {
        difference() {
            difference() {
                cuboid([bh_l, bh_w, bh_h], align=V_UP+V_BACK);
                translate([0, bh_w/2, 3.5]) color("green") cuboid([bh_l+5, post_w+eps, bh_h-7], align=V_UP);
            }
            translate([0,bh_w/2,3.5]) color("green") cuboid([3+eps, bh_w+5, bh_h-7], align=V_UP);
        }

        translate([0,bh_w-get_metric_nut_thickness(3)/2-d,0]) union() {
            translate([0,0,m3_c2c/2]) rotate([0,90,0]) metric_nut(3, hole=false, orient=ORIENT_Y, center=true);
            translate([0,0,m3_c2c/2]) color("red") cuboid([get_metric_nut_size(3), get_metric_nut_thickness(3), bh_h], align=V_UP);
        }
        translate([0,get_metric_nut_thickness(3)/2+d,0]) union() {
            translate([0,0,m3_c2c/2]) rotate([0,90,0]) metric_nut(3, hole=false, orient=ORIENT_Y, center=true);
            translate([0,0,m3_c2c/2]) color("red") cuboid([get_metric_nut_size(3), get_metric_nut_thickness(3), bh_h], align=V_UP);
        }
    }
}

// TODO: increase bolt size from M3 to M6
module mounting_tab() {
    difference() {
        cuboid([get_metric_socket_cap_diam(6)+eps,get_metric_socket_cap_diam(6)+eps,2], align=V_UP);
        translate([0,0,2]) scale([(get_metric_socket_cap_diam(6)+2*eps)/get_metric_socket_cap_diam(6),(get_metric_socket_cap_diam(6)+2*eps)/get_metric_socket_cap_diam(6),1]) metric_bolt(6,headtype="socket",pitch=0);
    }
}

// TODO: on first print, 1 tab was broken on side--probably due to retraction issues; increase wall thickness for a better print; or increase tab width.
module suction_tab() {
    difference() {
        color("green") cuboid([10,d,10],align=V_UP+V_RIGHT+V_BACK);
        translate([5,d/2,5]) cyl(l=d+5, d=7, orient=ORIENT_Y);
    }
}

chamber();
