//$fn = 50;
$fa = 1;
$fs = 0.4;
module part1()
{
    translate([ -12, -4, 11.5 ])
    {
        cube([ 24, 8, 0.5 ]);
    }
    translate([ 0, 0, 14 ])
    {
        cube([ 2, 8, 4 ], center = true);
    }
    difference()
    {
        translate([ 0, 0, 15 ]) cylinder(h = 6, r = 3);
        translate([ -3, -3, 18 ]) rotate([ 45, 0, 0 ]) cube(6);
    }
}

rotate([ -90, 0, 0 ])
{
    part1();
    rotate([ 0, 90, 0 ]) part1();
    rotate([ 0, -90, 0 ]) part1();
    rotate([ 0, 180, 0 ]) part1();
}
