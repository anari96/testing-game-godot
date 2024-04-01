shader_type canvas_item;
render_mode unshaded;

uniform vec4 level1 : source_color = vec4(0,0,0,1);
uniform vec4 level2 : source_color = vec4(0.5,0.5,0.5,1);
uniform vec4 level3 : source_color = vec4(1,1,1,1);
uniform vec4 level4 : source_color = vec4(1,1,1,1);

uniform float threshold1 	: hint_range(0.0,1.0) = .1;
uniform float threshold2 	: hint_range(0.0,1.0) = .4;
uniform float threshold3	: hint_range(0.0,1.0) = .6;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment(){
	COLOR = texture(screen_texture, SCREEN_UV);
	float rgb_avg = (COLOR.r + COLOR.g + COLOR.b)/3.0;
	if(rgb_avg < threshold1){
		COLOR = level1;
	}else if(rgb_avg < threshold2){
		COLOR = level2;
	}else if(rgb_avg < threshold3){
		COLOR = level3;
	}else{
		COLOR = level4;
	}
}