include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/sliders.scad>
use <BOSL/threading.scad>

// params
fn = 64;
thread_l = 70;
thread_d = 20;
thread_blank = 40;

translate([0,0,thread_d/4]) difference() {
    metric_trapezoidal_threaded_rod(d=thread_d, l=thread_l, pitch=4, orient=ORIENT_X, align=V_RIGHT+V_BACK, $fn=fn);
    translate([0,thread_d/2,0]) cuboid([thread_l, thread_d/2, thread_d], align=V_RIGHT);
    translate([0,0,thread_d/2]) cuboid([thread_l, thread_d, thread_d/2], align=V_RIGHT+V_BACK);
    translate([0,0,-thread_d/2]) cuboid([thread_l, thread_d, thread_d/2], align=V_RIGHT+V_BACK);
}

translate([thread_l, 0, 0]) difference() {
    difference() {
        cuboid([thread_blank, thread_d, thread_d/2], align=V_RIGHT+V_BACK+V_UP);
        hull() {
            translate([0, thread_d/2, 0]) cuboid([thread_d/2, thread_d/2, thread_d/2], align=V_RIGHT+V_UP);
            translate([thread_blank-thread_d/2,thread_d/2,0]) cyl(l=thread_d/2, d=thread_d/2, $fn=fn, align=V_UP);
        }
    }
    translate([0,0,thread_d/4]) cyl(d=thread_d, l=thread_blank, orient=ORIENT_X, align=V_RIGHT+V_BACK);
}