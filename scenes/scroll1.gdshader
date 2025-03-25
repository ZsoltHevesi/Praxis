shader_type canvas_item;

void fragment() {
    vec2 uv = UV;
    uv.x += TIME * 0.1; // Adjust speed if needed
    COLOR = texture(TEXTURE, uv);
}
