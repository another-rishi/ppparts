include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

plate_h = 2;
plate_w = 40;
plate_l =46;

//// cross-section
//difference() {
//union() {
    
module plate() {
difference() {
    color("green") cuboid([plate_w, plate_l, plate_h], align=V_UP);
    translate([0, 0, 0.5]) {
        union() {
            cyl(l=1.9, r1=3.4/2, r2=6.4/2, align=V_UP, $fn=36);
            cyl(l=4, r=3.4/2, align=V_BOTTOM, $fn=36);
            translate([0,0,1.9]) cyl(l=10, r=6.4/2, align=V_UP, $fn=36);
        }
    }
}

difference() {
difference() {
translate([plate_w/2,0,plate_h]) color("green") cuboid([15,15,8], align=V_UP+V_LEFT);

// cut-out for rod
translate([plate_w/2-sqrt(50)/2-get_metric_nut_size(4.4),0,plate_h+8]) rotate([0,45,0]) cuboid([5, 16, 5]);
}

// cut-out for nut
union() {
translate([plate_w/2-get_metric_nut_size(4.4)/2,0,plate_h+8-1]) rotate([0,0,90]) metric_nut(4.4, hole=false, align=V_BOTTOM);
translate([plate_w/2-get_metric_nut_size(4.4)/2, 0, plate_h+8-1]) cuboid([10, get_metric_nut_size(4.4)/cos(30), get_metric_nut_thickness(4.4)], align=V_BOTTOM+V_RIGHT);
translate([plate_w/2-get_metric_nut_size(4.4)/2,0,plate_h]) cyl(l=15, r=4.5/2, align=V_UP, $fn=36);
//echo((get_metric_nut_size(4.4))/cos(30));
//echo(get_metric_nut_size(4.4));
}
}

////cross-section
//}
//cuboid([100, 100, 100], align=V_BACK);
//}
}

plate();


//translate([0, 0, 0.5]) metric_bolt(3, headtype="countersunk", l=4, $fn=36);
//translate([plate_w/2-get_metric_nut_size(4.4)/2, 0, get_metric_bolt_head_height(4)+16+plate_h]) metric_bolt(4, headtype="hex", l=16, $fn=36, align=V_BOTTOM);
//translate([plate_w/2-get_metric_nut_size(4.4)/2,0,plate_h+8-1]) metric_nut(4, align=V_BOTTOM);
