include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
fn = 64;
big = 5;

layer_h = 0.1;
nozzle = 0.4;

r = 50/2;
d = nozzle*6;

module arc() {
    difference() {
        difference() {
            difference() {
                sphere(r, $fn=fn);
                cuboid([2*r,2*r,2*r], align=V_BOTTOM);
            }
            translate([0,0,-d]) difference() {
                sphere(r-d, $fn=fn);
                cuboid([2*(r-d),2*(r-d),2*(r-d)], align=V_BOTTOM);
            }
        }
    }
}

module metric_nut_cut_out(size, depth, height, eps, fn) {
    translate([(1.155*get_metric_nut_size(size=size)*(1+eps))/2,0,0]) {
        scale(1+eps) metric_nut(size=size, hole=false);
        cuboid([depth, get_metric_nut_size(size=size)*(1+eps), get_metric_nut_thickness(size=size)*(1+eps)], align=V_RIGHT+V_UP);
        difference() {
            cyl(r=(size/2)*(1+eps), h=height, orient=ORIENT_Z,  $fn=fn);
            translate([0,0,get_metric_nut_thickness(size=size)*(1+eps)]) cuboid([(1.155*get_metric_nut_size(size=size)*(1+eps)),(1.155*get_metric_nut_size(size=size)*(1+eps)),layer_h], align=V_UP);
        }
    }
}

// spherical filter supprot
difference() {
difference() {
union() {
difference() {
    arc();
    cyl(r=3.5, l=r+big, align=V_UP, orient=ORIENT_Z, $fn=fn);
}

// cylindrical body
tube(h=get_metric_nut_thickness(size=6)+2, ir=r, or=r+get_metric_socket_cap_diam(size=6)+3, $fn=fn);
rotate_extrude(angle=360, convexity=10){
    translate([r-d,0,0]) square(get_metric_nut_thickness(size=6)+2);
}
}
zrot_copies(n=3) translate([r, 0, (get_metric_nut_thickness(size=6)+2-get_metric_nut_thickness(size=6)*(1+0.1))/2]) metric_nut_cut_out(6, 10, 20, 0.1, fn);
}

h_o = sqrt(r^2-20^2); // z
h_0 = [20,0,h_o]; // tangent point
e = 1.51; // groove height
f = 2.90; // groove width
// translate(h_0) color("red") sphere(r=1, $fn=fn);

h_0i = h_0 / r;
phi = [asin(h_0i[0]),asin(h_0i[1]),asin(h_0i[2])];
// echo(phi);

x1 = [-f/2,e/2,0];
x2 = [f/2,-e/2,0];

rx1 = [x1[0]*cos(-phi[0])-x1[1]*sin(-phi[0]), x1[0]*sin(-phi[0])+x1[1]*cos(-phi[0]), 0];
rx2 = [x2[0]*cos(-phi[0])-x2[1]*sin(-phi[0]), x2[0]*sin(-phi[0])+x2[1]*cos(-phi[0]), 0];

echo(rx1);
echo(rx2);

#translate([0,0,sqrt(r^2-(rx2[0]+20)^2)]) color("red") tube(h=rx1[1]*2, ir1=rx1[0]+20, or2=rx2[0]+20, wall=e, $fn=fn);
echo(sqrt(r^2-(rx2[0]+20)^2));
}
