include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/threading.scad>

// params
fn = 64;
thread_l = 100;
thread_d = 24;
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
            cuboid([50, thread_d*4, thread_d/2], align=V_RIGHT+V_UP);
            translate([5,0,3]) cuboid([45+big, thread_d*4+big, thread_d/2-3+big], align=V_RIGHT+V_UP);
        }
    }

}

module fixed() {
    align = V_RIGHT+V_UP;
    cuboid([150*cos(30), thread_d*4, 3], align=align);
    // ependorf rack
    hull() {
        translate([150*cos(30)-27*cos(30),0,0]) cuboid([27*cos(30), thread_d*4, 3], align=align);
        translate([150*cos(30)-27*cos(30),0,27*sin(30)+3]) rotate([0,30,0]) cuboid([27, thread_d*4, 14], align=align);
    }
    // rail holder

}

translate([-60*cos(30),0,(thread_l+50)*sin(30)+thread_d/4+60*sin(30)]) rotate([0,30,0]) moving();
fixed();
