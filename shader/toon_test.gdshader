shader_type spatial;

render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform float point_size : hint_range(0,128);
uniform float roughness : hint_range(0,1);
uniform sampler2D texture_metallic : hint_default_white,filter_linear_mipmap,repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r,filter_linear_mipmap,repeat_enable;
uniform float specular;
uniform float metallic;


uniform vec3 light_direction = vec3(1.0, 1.0, 1.0);
uniform sampler2D gradient_texture;
uniform sampler2D hatching_texture;
uniform float hatching_threshold = 0.3;
uniform float attenuation_factor = 0.5;

void light() {
	float dot_product = clamp(dot(NORMAL,LIGHT), 0.0,1.0);
	
    // Calculate the dot product between the normal vector and the light direction
    float intensity = clamp((dot_product + 1.0) * ATTENUATION, 0.05, 0.95);
	float hatching_visibility = 1.0 - smoothstep(hatching_threshold - 0.1, hatching_threshold + 0.1, intensity);
    // Sample the gradient texture to determine the color based on intensity
    vec4 gradient_color = texture(gradient_texture, vec2(intensity, 0.0));
	
	vec2 hatching_uv = FRAGCOORD.xy / 1024.0 * 15.0;
	vec2 scaled_uv = hatching_uv * (1.0 - attenuation_factor * (1.0 - intensity));
	vec4 hatching = texture(hatching_texture, hatching_uv);
	
    // Output the final color
    DIFFUSE_LIGHT += mix(gradient_color.rgb * LIGHT_COLOR,clamp(((gradient_color.rgb * hatching.rgb) * LIGHT_COLOR),0.0,1.0), hatching_visibility);
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	float metallic_tex = dot(texture(texture_metallic,base_uv),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	vec4 roughness_texture_channel = vec4(1.0,0.0,0.0,0.0);
	float roughness_tex = dot(texture(texture_roughness,base_uv),roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	SPECULAR = specular;
}