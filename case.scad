// wall thickness
th = 2;

// board size
bx = 85.5;
by = 54.2;

// gap around board 
g = 0.4;
thg = th + g;

// outter dimensions
ox = bx + (thg * 2);
oy = by + (thg * 2);

// board z offset
bzo = 7 + th;

module basicBox()
{
    difference()
    {
        cube([ox, oy, 20]);
        translate([th, th, th])
            cube([bx + g * 2, by + g * 2, 20]);
    }
}

module stand( x, y )
{
    translate([x, y, 0])
    {
        cylinder( bzo, d = 7, $fn = 30 );
    }
}

module BottomScrewHole( x, y )
{
    translate([x, y, -1])
    {
        cylinder( bzo + 2, d = 3, $fn = 30 );
        cylinder( (1 + bzo) - th, d = 5, $fn = 6 );
    }
}

module TopScrewHole( x, y )
{
    translate([x, y, -1])
    {
        cylinder( 9.6 + 2 + th, d = 3, $fn = 30 );
        cylinder( (9.6 + th + 1) - 1.8, d = 5.4, $fn = 30 );
    }
}
module TopScrewMount( x, y )
{
    translate([x, y, 0])
    {
        cylinder( th + 9.6, d = 6.4, $fn = 60 );
    }
}

module frontHole(x, z, w, h)
{
    translate([x, -10, z + 1.25])
        cube([w, 13, h + (g * 2)]);
}

module bottom() 
{
    difference()
    {
        union()
        {
            basicBox();
            translate([thg, thg, 0])
            {
                stand( 4, 18.7 );
                stand( bx - 4, 18.7 );
                stand( 4, 50.2 );
                stand( bx - 4, 50.2 );
            }
            // more supports
            translate([65, th + 5, 0])
            {
                cylinder( bzo, d = 5, $fn = 30 );
            }
            translate([26, th + 5, 0])
            {
                cylinder( bzo, d = 5, $fn = 30 );
            }
            translate([44, 53.5, 0])
            {
                cylinder( bzo, d = 5, $fn = 30 );
            }
            
        }
        union()
        {
            // SD card
            frontHole( 2.63, bzo - g, 12.45, 1.75 );
            
            // HDMI
            frontHole( 18.71, bzo - g, 16.45, 7.27 );
            
            // otg
            frontHole( 39.24, (bzo - 0.5) - g, 9.1, 4 );
            
            // USB1
            frontHole( 50.2, bzo - g, 16.7, 8.4 );
            
            // USB2
            frontHole( 70.5, bzo - g, 15.9, 8.4 );
            
            // power 
            translate([thg+67, oy - 10, bzo + 1.25])
                cube([10, 20, 7]);
            
            // switches
            translate([thg+18 - g, 47 - g, -1])
                cube([6.66 + (2 * g), 7.25 + (2 * g), bzo + 2]);
            
            // screw holes with captured nuts
            translate([thg, thg, 0])
            {
                BottomScrewHole( 4, 18.7 );
                BottomScrewHole( bx - 4, 18.7 );
                BottomScrewHole( 4, 50.2 );
                BottomScrewHole( bx - 4, 50.2 );
            }
            // SoC Vent #1
            translate([thg+80, thg+25, -1])
                cube([2, 11, th + 2]);
            // SoC Vent #2
            translate([thg+77, thg+25, -1])
                cube([2, 11, th + 2]);
            // SoC Vent #3
            translate([thg+74, thg+25, -1])
                cube([2, 11, th + 2]);
        }
    }
}

module topSupport(x, y, type)
{
    translate([x, y, th])
    {
        if( type == "a" )
            cube([th, 6, 5]);
        if( type == "b" )
            cube([6, th, 5]);
    }
}


module top()
{
    difference()
    {
        union()
        {
            cube([ox, oy, th]);
            topSupport( thg, thg, "a" );
            topSupport( ox - (thg + th), thg, "a" );
            topSupport( ox - (thg + th), oy - (thg + 6 + 17), "a" );
            topSupport( thg, oy - (thg + 6), "a" );
            
            topSupport( 55, thg, "b");
            topSupport( 40, oy - (thg + th), "b");
            
            
            TopScrewMount( thg + 4, oy - (18.7 + thg) );
            TopScrewMount( thg + (bx - 4), oy - (18.7 + thg) );
            TopScrewMount( thg + 4, oy - (50.2 + thg) );
            TopScrewMount( thg + (bx - 4), oy - (50.2 + thg) );
            
        }
        union()
        {
            // GPIO access
            translate([10.5, thg, -1])
                cube([42, 6.75, th + 2]);
            
            // SoC Vent #1
            translate([thg+22, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent #2
            translate([thg+25, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent #3
            translate([thg+28, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent 4
            translate([thg+31, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent #5
            translate([thg+34, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent #6
            translate([thg+37, thg+15, -1])
                cube([2, 20, th + 2]);
            // SoC Vent #7
            translate([thg+40, thg+15, -1])
                cube([2, 20, th + 2]);
                // Switch hole
            translate([thg+71, thg+33, -1])
                cube([4, 5, th + 2]);
            
            TopScrewHole( thg + 4, oy - (18.7 + thg) );
            TopScrewHole( thg + (bx - 4), oy - (18.7 + thg) );
            TopScrewHole( thg + 4, oy - (50.2 + thg) );
            TopScrewHole( thg + (bx - 4), oy - (50.2 + thg) );
            
            
        }
    }
}

module switch()
{
    
    difference()
    {
        translate([th,th,0])
            cube([4,5,th]);
    }
    translate([4,4.5,0])
    cylinder( th + 9.6, d = 3, $fn = 60 );
}

union()
{
    bottom();
    translate([0, oy + 5, 0])top();
    translate([oy + 40,0, 0])switch();
}
