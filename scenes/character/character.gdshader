shader_type canvas_item;

uniform vec4 shirt_mask: hint_color = vec4(0.34, 0.5, 0.62, 1.0);
uniform vec4 shirt_color: hint_color = vec4(0.34, 0.5, 0.62, 1.0);

uniform vec4 hair_axe_mask: hint_color = vec4(0.99, 0.93, 0.82, 1.0);
uniform vec4 hair_axe_color: hint_color = vec4(0.99, 0.93, 0.82, 1.0);

uniform vec4 pants_mask: hint_color = vec4(0.76, 0.65, 0.61, 1.0);
uniform vec4 pants_color: hint_color = vec4(0.76, 0.65, 0.61, 1.0);

uniform vec4 boots_eyes_mask: hint_color = vec4(0.63, 0.87, 0.83, 1.0);
uniform vec4 boots_eyes_color: hint_color = vec4(0.63, 0.87, 0.83, 1.0);

uniform vec4 skin_mask: hint_color = vec4(0.97, 0.81, 0.57, 1.0);
uniform vec4 skin_color: hint_color = vec4(0.97, 0.81, 0.57, 1.0);


void fragment() {
	vec4 color_alpha = texture(TEXTURE, UV);
	vec3 color = color_alpha.rgb;
	float alpha = color_alpha.a;
	
	float shirt_dist = distance(shirt_mask.rgb, color);
	float hair_dist = distance(hair_axe_mask.rgb, color);
	float pants_dist = distance(pants_mask.rgb, color);
	float boots_dist = distance(boots_eyes_mask.rgb, color);
	float skin_dist = distance(skin_mask.rgb, color);
	
	color = mix(shirt_color.rgb, color, step(0.1, shirt_dist));
	color = mix(hair_axe_color.rgb, color, step(0.1, hair_dist));
	color = mix(pants_color.rgb, color, step(0.1, pants_dist));
	color = mix(boots_eyes_color.rgb, color, step(0.1, boots_dist));
	color = mix(skin_color.rgb, color, step(0.1, skin_dist));
		
	COLOR = vec4(color, alpha);
}