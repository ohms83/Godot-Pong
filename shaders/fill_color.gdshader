shader_type canvas_item;

uniform vec3 fill_color;

void fragment() {
	// Place fragment code here.
	COLOR.rgb = fill_color;
}
