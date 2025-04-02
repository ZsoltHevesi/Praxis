shader_type canvas_item;

uniform float SPEED = 1.0;

void fragment() {
    vec2 uv_offset = UV;
    uv_offset.x += TIME * SPEED;  // Scroll horizontally
    // uv_offset.y += TIME * SPEED; // Uncomment for vertical scrolling

    COLOR = texture(TEXTURE, uv_offset);

}

