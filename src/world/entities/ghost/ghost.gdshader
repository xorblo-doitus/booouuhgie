shader_type canvas_item;

//void vertex() {
	//if (AT_LIGHT_PASS) {
		//COLOR = vec4(1.0);
	//}
//}
//
//void fragment() {
	//
//}

void light() {
	float wave_offset = sin(TIME * 2.0 + UV.x * 5.0 + UV.y * 0.9) * 0.05;
	//wave_offset = 0.0;
	//LIGHT.r = LIGHT_COLOR.r;
	//LIGHT.a = 1.0;
	//COLOR.a = 1;
	//LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);
	//LIGHT = vec4(0.0, 1.0  * LIGHT_ENERGY, 1.0 * LIGHT_ENERGY, LIGHT_COLOR.a);
	//LIGHT = vec4(COLOR.b / 2.0 * LIGHT_ENERGY, COLOR.b * LIGHT_ENERGY, COLOR.b * LIGHT_ENERGY, LIGHT_COLOR.a);
	//LIGHT.r = LIGHT_COLOR.a;
	//LIGHT = vec4(LIGHT_COLOR.a) * LIGHT_ENERGY;
	//LIGHT.a = LIGHT_COLOR.a;
	//if (false) {
	if (LIGHT_COLOR.r > 0.3 + wave_offset) {
		LIGHT = vec4(1.0, 1.0, 1.0, 0.5);
	} else if (LIGHT_COLOR.r > 0.1 + wave_offset) {
		//LIGHT.r = LIGHT_COLOR.r;
		//LIGHT.a = 1.0;
		LIGHT = vec4(0.0, 1.0  * LIGHT_ENERGY, 1.0 * LIGHT_ENERGY, 1.0);
		//LIGHT = vec4(COLOR.b / 2.0 * LIGHT_ENERGY, COLOR.b * LIGHT_ENERGY, COLOR.b / 2.0 * LIGHT_ENERGY, LIGHT_COLOR.a);
	} else {
		LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);
	}
	//}
	//LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);
	
}
