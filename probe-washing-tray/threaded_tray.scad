include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/threading.scad>

// params
fn = 64;
thread_l = 75;
thread_d = 24;
mea_holder_l = 50;
translation_gap_l = 50;
total_l = thread_l+mea_holder_l+translation_gap_l+27*cos(30);
big=10;

module rail(l) {
    rail_l = l;
    ang = 30;
    align=V_RIGHT;

    cuboid([rail_l,4*cos(ang)*2+1,4*cos(ang)*2+1], align=align);
    echo((4*cos(ang)*2+1)*1.1);
    translate([0,(4*cos(ang)*2+1)/2+1,0]) rotate([-90,0,0]) prismoid(size1=[rail_l, 4*cos(ang)*2+1], size2=[rail_l, 1], h=2, align=align);
    translate([0,-(4*cos(ang)*2+1)/2-1,0]) rotate([90,0,0]) prismoid(size1=[rail_l, 4*cos(ang)*2+1], size2=[rail_l, 1], h=2, align=align);
}

module moving() {
    // threaded rod
    difference() {
        metric_trapezoidal_threaded_rod(d=thread_d, l=thread_l, pitch=4, orient=ORIENT_X, align=V_RIGHT, $fn=fn);
        translate([0,0,thread_d/2]) cuboid([thread_l, thread_d, thread_d/2], align=V_RIGHT);
        translate([0,0,-thread_d/2]) cuboid([thread_l, thread_d, thread_d/2], align=V_RIGHT);
        cuboid([thread_l, (4*cos(30)*2+1)*1.1, (4*cos(30)*2+1)*1.1+big], align=V_RIGHT);
        scale(1.1) rail(thread_l);
    }
    // MEA holder
    translate([thread_l,0,-thread_d/4]) {
        difference() {
            cuboid([mea_holder_l, thread_d*4, thread_d/2], align=V_RIGHT+V_UP);
            translate([5,0,3]) cuboid([(mea_holder_l-5)+big, thread_d*4+big, thread_d/2-3+big], align=V_RIGHT+V_UP);
        }
    }

}

module fixed() {
    align = V_RIGHT+V_UP;
    cuboid([total_l*cos(30), thread_d*4, 3], align=align);
    // ependorf rack
    hull() {
        translate([(thread_l*2+translation_gap_l)*cos(30)-27*cos(30),0,0]) cuboid([27*cos(30), thread_d*4, 3], align=align);
        translate([(thread_l*2+translation_gap_l)*cos(30)-27*cos(30),0,27*sin(30)]) rotate([0,30,0]) cuboid([27, thread_d*4, 14], align=align);
    }
    // rail holder

}

module insertion_plane() {
    
    translate([0,0,total_l*sin(30)]) rotate([0,30,0]) cuboid([total_l,thread_d*4,1], align=V_UP+V_RIGHT);
}

translate([0,0,(thread_l+mea_holder_l+translation_gap_l+14)*sin(30)]) rotate([0,30,0]) moving();

#insertion_plane();
fixed();
