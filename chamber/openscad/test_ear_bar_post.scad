use <BOSL/shapes.scad>
include <BOSL/constants.scad>
use <chamber.scad>

h=30;

translate([-35,0,-30]) 
difference() {
ear_bar_post();
translate([35,0,0]) cuboid([h,h,h], align=V_UP+V_FRONT);
}