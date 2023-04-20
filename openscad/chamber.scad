include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

include <./ear-bar.scad>

// parameters
fn = 360;
nozzle = 0.4;
d = 4*nozzle;
eps = nozzle;

l = 120;
w = 60;
h = 10;

post_w = 5;
bh_h = 30;
bh_w = ceil(get_metric_nut_thickness(3))+4*d+post_w;
bh_l = ceil(get_metric_nut_size(3))+4*d;

m3_c2c = 6.35;

module chamber() {
    difference() {
        cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
        translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK, $fn=fn);
    }
    // tooth holder adjustable mounting column
    translate([-bh_l,w/2,0]) cuboid([bh_l,bh_w,h+d], align=V_UP+V_RIGHT);
    color("green") translate([-bh_l/2,w/2-bh_w/2,h+d]) adjustable_post();
    //left ear bar column
    difference() {
    color("green") translate([35,-7,0]) cuboid([7,7,h+30], align=V_UP+V_BACK);
    #translate([35,-(l_bar+l_ear)/2,d_bar-adhesion_offset+h+bh_h/2]) rotate([180,0,90]) ear_bar();
    }
    //right ear bar column
    difference() {
    translate([35,w+2*d,0]) cuboid([7,7,h+30], align=V_UP+V_BACK);
    #translate([35,(l_bar+l_ear)/2+w+2*d,d_bar-adhesion_offset+h+bh_h/2]) rotate([180,0,-90]) ear_bar();
    }
}

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

chamber();



echo("m3 thickness");
echo(get_metric_nut_thickness(3));
echo("m3 flat-to-flat");
echo(get_metric_nut_size(3));