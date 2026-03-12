shader_type canvas_item;

uniform float intensity : hint_range(0.0, 1.0) = 0.5;
uniform float glitch_frequency : hint_range(0.1, 10.0) = 2.0;

uniform float red_displacement : hint_range(0.0, 0.1) = 0.02;
uniform float green_displacement : hint_range(0.0, 0.1) = 0.02;
uniform float blue_displacement : hint_range(0.0, 0.1) = 0.02;

uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float noise_intensity : hint_range(0.0, 1.0) = 0.2;
uniform float slice_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float ghost_intensity : hint_range(0.0, 0.5) = 0.1;
uniform float negative_intensity : hint_range(0.0, 1.0) = 0.0;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv = UV;
    float glitch_time = TIME * glitch_frequency;
    
    // Create a stepped "pulse" for the glitch so it's not constant
    float glitch_active = step(1.0 - intensity, random(vec2(floor(glitch_time * 1.5), 0.0))) * step(0.01, intensity);
    
    // --- 1. SLICING & WARPING ---
    if (glitch_active > 0.5) {
        // Horizontal Slices
        float slice_y = random(vec2(floor(glitch_time * 10.0), 0.0));
        if (abs(uv.y - slice_y) < 0.05 * slice_intensity) {
            uv.x += (random(vec2(glitch_time, 0.0)) - 0.5) * 0.2 * slice_intensity;
        }
        
        // Vertical Jitter
        uv.y += (random(vec2(glitch_time * 5.0, 1.0)) - 0.5) * 0.03 * intensity;
        
        // Sine Wave Distortion
        uv.x += sin(uv.y * 50.0 + glitch_time * 10.0) * 0.005 * intensity;
    }

    // --- 2. SAMPLING & CHROMATIC ABERRATION ---
    // We sample the texture at the new UVs
    vec4 base_tex = texture(TEXTURE, uv);
    
    float r = texture(TEXTURE, uv + vec2(red_displacement * glitch_active, 0.0)).r;
    float g = base_tex.g;
    float b = texture(TEXTURE, uv - vec2(blue_displacement * glitch_active, 0.0)).b;
    
    // Apply the original Label color (modulate) to our sampled channels
    vec3 final_rgb = vec3(r, g, b) * COLOR.rgb;
    
    // --- 3. GHOSTING ---
    if (ghost_intensity > 0.0 && glitch_active > 0.5) {
        vec4 ghost = texture(TEXTURE, uv + vec2(0.02, 0.01));
        final_rgb = mix(final_rgb, ghost.rgb * COLOR.rgb, ghost_intensity);
    }

    // --- 4. SCANLINES & NOISE ---
    float scanline = sin(uv.y * 200.0 + glitch_time * 5.0) * 0.5 + 0.5;
    final_rgb -= scanline * scanline_intensity * glitch_active;
    
    float static_noise = (random(uv + glitch_time) - 0.5) * noise_intensity * glitch_active;
    final_rgb += static_noise;

    // --- 5. NEGATIVE ---
    if (negative_intensity > 0.0) {
        vec3 neg = 1.0 - final_rgb;
        final_rgb = mix(final_rgb, neg, negative_intensity * glitch_active);
    }

    // --- 6. THE ALPHA MASK (Crucial!) ---
    // This uses the alpha of the offset UVs so the glitch doesn't "break" the text shape
    // while ensuring the background stays 100% transparent.
    float final_alpha = base_tex.a * COLOR.a;
    
    COLOR = vec4(final_rgb, final_alpha);
}