// Thumb screw cap

/*
Created by Maurits Gustavsson

This is just a cap to slip over a nut or bolt head giving a knurled knob to finger tighten a thread.

You will require the Knurled Surface Library v2 by aubenc on Thingiverse
Knurled Surface Library v2 by aubenc - Thingiverse
https://www.thingiverse.com › thing:32122

Also credit to Chris Bate from YouTube for the code to create the simple hexagons


*/


$fn = 64;

use <knurledFinishLib_v2.scad>
use <BOSL/metric_screws.scad>


// +++ Definable Variables: +++
// default values creates cap for 1/4-20 nut that is 16mm in diameter and 10mm long. there is a 2mm thick boss at the bottom of the cap

// TODO: thru-hole too small
// TODO: bolt head cut-out too small

knob_od = 12; // overall diameter of knob
knob_lg = 12; // overall length of knob
nut_wd = get_metric_bolt_head_size(3)+0.1; // width of nut flat to flat (add 0.1 to measured)
bolt_dia = 3+0.1; // bolt thread outer diameter (add 0.1 to measured)
nut_land = 1; // width between nut and outside (boss meat at the bottom of the cap)

// +++ End Definable Variables +++


difference () {
    knurl(	k_cyl_hg	= knob_lg,
            k_cyl_od	= knob_od,
            knurl_wd =  1.2,
            knurl_hg =  1.2,
            knurl_dp =  1.4,
            e_smooth =  2.5,
            s_smooth =  1);     
    cylinder( h=knob_lg, r=bolt_dia/2);
    translate([0,0,nut_land])fhex(nut_wd,knob_lg-nut_land);
}


// +++ Creating hexigons for nut relief +++
/*
Credit to Chris Bate from YouTube for the code to create the simple hexagons.
https://youtu.be/KAKEk1falNg
*/
//phex(10,0.1,10); // point to point hex
//fhex(10,10); // Flat to flat hex

module phex(wid,rad,height){
    hull(){
    translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    rotate([0,0,60])translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    rotate([0,0,120])translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    rotate([0,0,180])translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    rotate([0,0,240])translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    rotate([0,0,300])translate([wid/2-rad,0,0])cylinder(r=rad,h=height);
    }
}

module fhex(wid,height){
    translate([0,0,height/2]){ // shifted module up to sit fluch on the XY plane
        hull(){
        // cube([wid/1.7,wid,height],center = true);
        cube([wid/tan(60),wid,height],center = true); // replaced line with tan calc to be more accurate
        rotate([0,0,120])cube([wid/1.7,wid,height],center = true);
        rotate([0,0,240])cube([wid/1.7,wid,height],center = true);
        }
    }
}

// +++ End Hexagon +++

