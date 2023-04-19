include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

// parameters
fn = 360;

l = 120;
w = 60;
h = 10;
nozzle = 0.4;
d = 4*nozzle;

bh_h = 35;
bh_w = 3+7;
bh_l = 

difference() {
    cuboid([l+2*d, w+2*d, h+d], align=V_UP+V_RIGHT+V_BACK);
    translate([d,d,d]) color("red") cuboid([l, w, h+5], fillet=5, align=V_UP+V_RIGHT+V_BACK, $fn=fn);
}

translate([-10,w/2,0]) cuboid([10,10,h+30], align=V_UP+V_RIGHT);

translate([35,-10,0]) cuboid([10,10,h+30], align=V_UP+V_BACK);
translate([35,w+2*d,0]) cuboid([10,10,h+30], align=V_UP+V_BACK);

metric_nut(3, hole=false, orient=ORIENT_Y);

echo("m3 thickness");
echo(get_metric_nut_thickness(3));
echo("m3 flat-to-flat");
echo(get_metric_nut_size(3));