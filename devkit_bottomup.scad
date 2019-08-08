/*
	Upside-down aproach for a devkit case: The devkit is put
	in from behind, display first. So all components
	(batteryholder, cam, ...) are freely reachable and
	sensitive parts (like TS-connector) are covered. And the
	processor heat can be taken care of as its just open - a
	fan can be mounted.

	The idea is to plug the devkit in (with the audio
	connector first) and put some hot glue to the corners to
	fix it.
*/
$fn=40;
module centered_cube(x, y, z) {
	translate([-x/2, -y/2, 0]) cube([x, y, z]);
}

inf = 200; //
border = 3; // case border width
display_height = 2; //
display_width = 70+1;
display_length = 147+1;
display_rounded = 6;
pcb_width = 90+2;
pcb_length = 180+2;
pcb_distance = 6; // from display surface

difference() {
	centered_cube(pcb_width+2*border, pcb_length+2*border, 30);
	difference() {
		union() {
			// display
			translate([0, 0, -inf/2]) union() {
				translate([0, 0, 0]) centered_cube(display_width, display_length-2*display_rounded, inf);
				translate([0, 0, 0]) centered_cube(display_width-2*display_rounded, display_length, inf);
				dx = display_width/2-display_rounded;
				dy = display_length/2-display_rounded;
				translate([dx, dy, 0]) cylinder(inf, display_rounded, display_rounded);
				translate([dx, -dy, 0]) cylinder(inf, display_rounded, display_rounded);
				translate([-dx, dy, 0]) cylinder(inf, display_rounded, display_rounded);
				translate([-dx, -dy, 0]) cylinder(inf, display_rounded, display_rounded);
			}
			// pcb
			translate([0, 0, display_height]) centered_cube(pcb_width, pcb_length, inf);
			// bottom holes
			let(dy = pcb_length / 2, dz = pcb_distance + 1) { // thickness of pcb
				// headphonejack
				translate([29.5, -dy, dz+3]) rotate([90, 0, 0]) cylinder(inf, 4, 4);
				translate([29.5, -dy, display_height]) centered_cube(10, 4, inf);
				// ethernet
				translate([14, -dy, dz]) centered_cube(15, inf, 14);
				// HDMI:
				// translate([-3, -dy, dz]) centered_cube(12, inf, 3);
				// USB-C:
				translate([-14, -dy, dz]) centered_cube(11, inf, 6);
				// SD Card:
				translate([-27, -dy, dz]) centered_cube(12, inf, 3);
				// SIM:
				translate([-inf/2, 53.5, dz]) centered_cube(inf, 15, 3);
				// Securecard:
				translate([-inf/2, -63, dz]) centered_cube(inf, 18, 3);
			}
			// side holes
			let(dx = pcb_width / 2 + 2, dz = pcb_distance-inf) {
				// Killswitch bt
				translate([dx, 6, dz]) centered_cube(border+2, 5, inf);
				translate([dx-2, 6, -inf/2]) centered_cube(2, 2, inf);
				// Killswitch wifi
				translate([dx, -5, dz]) centered_cube(border+2, 5, inf);
				translate([dx-2, -5, -inf/2]) centered_cube(2, 2, inf);
				// Killswitch mic/cam
				translate([dx, -15, dz]) centered_cube(border+2, 5, inf);
				translate([dx-2, -15, -inf/2]) centered_cube(2, 2, inf);
				// Switch bootmode:
				translate([dx, -32, dz]) centered_cube(border+2, 5, inf);
				translate([dx-2, -32, -inf/2]) centered_cube(2, 2, inf);
				// Button reset:
				translate([dx, -40, dz+3]) centered_cube(border+2, 4, inf);
				// Button power:
				translate([-dx, 29, dz+3]) centered_cube(border+2, 4, inf);
				// Button speaker up:
				translate([-dx, 7.5, dz+3]) centered_cube(border+2, 4, inf);
				// Button speaker down:
				translate([-dx, -9.5, dz+3]) centered_cube(border+2, 4, inf);
			}
			// front holes
			let(dz = -inf/2) {
				// ambient/aproximity sensors
				translate([-13, 84, dz]) cylinder(inf, 3, 3);
				translate([-22, 84, dz]) cylinder(inf, 3, 3);
				// Microphone:
				translate([0, -78, dz]) cylinder(inf, 3, 3);
			}
		}
		union() {
			// pillars
			let(dx = pcb_width / 2, dy = pcb_length / 2) {
				// corners
				for (x = [dx, -dx])
					for (y = [dy, -dy])
						translate([x, y, 0]) cylinder(pcb_distance, border, border);
				// middle
				translate([dx, 25, 0]) cylinder(pcb_distance, border, border);
				translate([-dx, -25, 0]) cylinder(pcb_distance, border, border);
			}
		}
	}
}
