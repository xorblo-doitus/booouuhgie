shader_type canvas_item;
render_mode unshaded;

uniform sampler2D flame_shape;
uniform vec4 color_bright: source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 color_middle: source_color = vec4(1.0, 0.7, 0.0, 1.0);
uniform vec4 color_dark: source_color = vec4(1.0, 0.2, 0.0, 1.0);


//void vertex() {
	//// Called for every vertex the material is visible on.
//}


void fragment() {
	COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	
	//COLOR.r = UV.y;
	float heat = texture(
		flame_shape,
		UV + 0.04 * (1.0-UV.y) * (cos(UV.y*5.0 + TIME) + cos(UV.y*1.2 + TIME)) * vec2(
			cos(TIME*2.0) + cos(TIME*2.2),
			cos(TIME)
		)
	).r;
	
	float is_bright = float(0.7 < heat && heat <= 1.0);
	float is_middle = float(0.4 < heat && heat <= 0.7);
	float is_dark = float(0.01 < heat && heat <= 0.4);
	
	COLOR = is_bright * color_bright + is_middle * color_middle + is_dark * color_dark;
	
	//COLOR.a = texture(flame_shape, UV).r;
	//COLOR.b = sqrt(pow(UV.x, 2) + UV.y**2.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
