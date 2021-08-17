shader_type spatial;
render_mode unshaded, cull_disabled ;
uniform float     u_angle;
uniform sampler2D texture_albedo : hint_albedo;
void vertex() {
  UV = UV;
}
void fragment()
{
    vec2 ndcPos = UV * 2.0 - 1.0;
    ivec2 size = textureSize(texture_albedo, 0);
    float aspect = float(size.x)/float(size.y);
    
    float eye_angle = abs(u_angle);
    float half_angle = eye_angle/2.0;
    float half_dist = tan(half_angle);
    vec2  vp_scale = vec2(aspect, 1.0);
    vec2  P = ndcPos * vp_scale; 
    
    float vp_dia   = length(vp_scale);
    float rel_dist = length(P) / vp_dia;  
    vec2  rel_P = normalize(P) / normalize(vp_scale);
    vec2 pos_prj = ndcPos;
    if (u_angle > 0.0)
    {
        float beta = rel_dist * half_angle;
        pos_prj = rel_P * tan(beta) / half_dist;  
    }
    else if (u_angle < 0.0)
    {
        float beta = atan(rel_dist * half_dist);
        pos_prj = rel_P * beta / half_angle;
    }
    vec2 uv_prj = pos_prj * 0.5 + 0.5;
    vec2 rangeCheck = step(vec2(0.0), uv_prj) * step(uv_prj, vec2(1.0));   
    if (rangeCheck.x * rangeCheck.y < 0.5)
        discard;
    ALBEDO = texture(texture_albedo, uv_prj.st);
}