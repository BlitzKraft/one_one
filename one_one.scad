// Units in mm
$fa=5;

ball_dia = 100;
radius = ball_dia/2;
wall_thickness = 2;
//width of the band
width = 20;
//angle between the eyes.
angle = 12;


module ball() {
	difference() {
		sphere(r=radius);
		sphere(r=radius - 2*wall_thickness);
	}
}

module band() {
	intersection() {
		difference() {
			sphere(r=radius + 0.2);
			sphere(r=radius - wall_thickness);
		}
		cube([width * 0.95, ball_dia *2, ball_dia *2], center=true);
	}
}

module one1_body() {
	difference() {
		//color("white")
		ball();
		//color("black")
		band();
	}
}

module one_half() {
	rotate([90, 0, 0])
	difference() {
		rotate([0, 90, 0])
		one1_body();
		translate([-50, 0, 0])
		cube([100, 200, 200], center=true);
	}
}

module eyes() {
	difference() {
		band();
		union() {
			//eye 0
			rotate([angle, 0, 0])
			translate([0, -radius, 0])
			rotate([90, 0, 0])
			cylinder(r=width/3, h = width, center=true);
			//eye 1
			rotate([-angle, 0, 0])
			translate([0, -radius, 0])
			rotate([90, 0, 0])
			cylinder(r=width/3, h = width, center=true);
			//split
			translate([0, ball_dia/2 - 2, 0])
			cube([200, 5, 1], center=true);
		}
	}
}

module leg() {
	$fn=30;
	//translate([0, 0, ball_dia/2])
	difference() {
		translate([0, 0, width/4])
		cylinder(r=ball_dia/25, h=width/2, center=true);
		union() {
			//axial hole
			cylinder(r=0.5, h= 100, center=true);
			//socket for the ball joint
			sphere(r=ball_dia/25);
			// chopping off some bottom to avoid zero thickness wall
			translate([0, 0, 0.5])
			cube([100, 100, 1], center=true);
			translate([0, ball_dia/25, 0])
			//relief for bending the joint
			rotate([90, 0, 0])
			cylinder(r=ball_dia/25, h=ball_dia*2/25,center=true);
			//hole on top to add magnet or other fixtures
			translate([0, 0, width/2])
			sphere(r=ball_dia/30);
		}
	}
}

module leg_end() {
	$fn=30;
	difference() {
		union() {
		hull() {
			translate([0, 0, -width])
			sphere(r=0.5);
			sphere(r=ball_dia/25);
		}
		}
		union() {
			cylinder(r=0.5, h= 100, center=true);
			translate([0, 0, 50])
			cube([1, 100, 100], center=true);
		}
	}
}

module posed_one1() {
	rotate([0, 0, 45]) {
		one1_body();
		rotate([-30, 0, 0])
		color("black")
		eyes();
	}
	rotate([-60, 0, 0]) {
		translate([0, 0, -ball_dia/2 - width/2]) {
			leg();
			rotate([50, 0, 0])
			leg_end();
		}
	}
	rotate([-60, 0, 90]) {
		translate([0, 0, -ball_dia/2 - width/2]) {
			leg();
			rotate([50, 0, 0])
			leg_end();
		}
	}
	rotate([-60, 0, 180]) {
		translate([0, 0, -ball_dia/2 - width/2]) {
			leg();
			rotate([50, 0, 0])
			leg_end();
		}
	}
	rotate([-60, 0, 270]) {
		translate([0, 0, -ball_dia/2 - width/2]) {
			leg();
			rotate([50, 0, 0])
			leg_end();
		}
	}
}

posed_one1();
