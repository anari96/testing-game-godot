shader_type canvas_item;
render_mode unshaded;

const int pixel_size = 120; //resolution must be divisible by pixel_size

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;



void fragment() {
	vec2 pixelated_uv = round(SCREEN_UV * float(pixel_size)) / float(pixel_size);
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);

	x = FRAGCOORD.x + floor(float(pixel_size) / 2.0) - x;
	y = FRAGCOORD.y + floor(float(pixel_size) / 2.0) - y;

	COLOR = texture(screen_texture, pixelated_uv);
}