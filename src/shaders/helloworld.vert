#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform UniformBufferObject
{
    mat4 model;
    mat4 view;
    mat4 proj;
} transform;

layout(location = 0) in vec3 in_position;
layout(location = 1) in vec3 in_color;
layout(location = 2) in vec2 in_tex_coord;
layout(location = 3) in vec3 in_normal;

layout(location = 0) out vec3 frag_color;
layout(location = 1) out vec2 frag_tex_coord;
layout(location = 2) out vec3 frag_normal;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main()
{
    //todo: calculate them in cpu...
    mat4 mvp = transform.proj * transform.view * transform.model;
    mat4 invtransmodel =  transpose(inverse(transform.model));
    //gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);

    gl_Position = mvp * vec4(in_position, 1.0);
    frag_color = in_color;
    frag_tex_coord = in_tex_coord;
    frag_normal = normalize((invtransmodel * vec4(in_normal, 0.0)).xyz);
}
