include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <plate.scad>
use <bracket.scad>

plate();

//translate([0, 0, 0.5]) metric_bolt(3, headtype="countersunk", l=4, $fn=36);
//translate([plate_w/2-get_metric_nut_size(4.4)/2, 0, get_metric_bolt_head_height(4)+16+plate_h]) metric_bolt(4, headtype="hex", l=16, $fn=36, align=V_BOTTOM);
//translate([plate_w/2-get_metric_nut_size(4.4)/2,0,plate_h+8-1]) metric_nut(4, align=V_BOTTOM);
