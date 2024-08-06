$fa = 1;
$fs = 0.4;

module part1()
{
    wall_thickness = 0.6;
    wall_length = 22.5;
    wall_depth = 8;
    support_length = 1.6;
    support_height = 4;
    support_overlap = 1;
    cylinder_radius = 5.6/2;
    cylinder_height = 6;
    support_side_length = 0.7;
    corner_side_length = 1.4;

    depth_stop_depth = 2;

    module corner(side_length) {
        linear_extrude(wall_depth) polygon(points=[[0,0], [0,side_length], [side_length,0]]);
    }

    translate([0,0,(wall_length-wall_thickness)/2]) {
        // wall
        cube([ wall_length, wall_depth, wall_thickness ], center = true);

        // cylinder support
        translate([ 0, 0, (support_height + wall_thickness)/2 ]) cube([ support_length, wall_depth, support_height ], center = true);

        // cut cylinder
        translate([0,0,support_height - support_overlap + wall_thickness / 2]) difference()
        {
            cylinder(h = cylinder_height, r = cylinder_radius);
            translate([ -cylinder_radius, -cylinder_radius, cylinder_height/2 ]) rotate([ 45, 0, 0 ]) cube(cylinder_height);
        }

        // depth stop
        translate([0,wall_depth/2,wall_thickness+support_height/3]) rotate([-90,0,0]) cylinder(r=support_length/2,h=depth_stop_depth);

        // corner reinforcement, on each side of support
        translate([support_length/2,-wall_depth/2,wall_thickness/2]) rotate([0,-90,-90]) corner(support_side_length);
        translate([-support_length/2,wall_depth/2,wall_thickness/2]) rotate([0,-90,90]) corner(support_side_length);

        // corner reinforcement, wall angle
        translate([-wall_length/2+corner_side_length/4,wall_depth/2,0]) rotate([0,90,-90]) corner(corner_side_length);
    }
}

rotate([ 90, 0, 0 ])
{
     part1();
     rotate([ 0, 90, 0 ]) part1();
     rotate([ 0, -90, 0 ]) part1();
     rotate([ 0, 180, 0 ]) part1();
}
