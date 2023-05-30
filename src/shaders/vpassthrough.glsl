#version 330

in vec3 vertex;


uniform mat4 modelViewProjMat;
uniform vec3 color;
uniform vec3 direction; // dirección
uniform float steepness; // pendiente
uniform float waveLength; // separación entre olas
uniform float delta_time; // tiempo transcurrido desde la última llamada al shader

out vec4 vertColor;

void main()
{
    // Cálculo de la dirección de la ola en el plano xz
    vec3 directionXZ = normalize(vec3(direction.x, 0.0, direction.z));

    // Cálculo de la constante k
    float k = 2.0 * 3.14159265358979323846 / waveLength;

    // Cálculo de la variable f
    float f = k * (dot(directionXZ, vertex) - delta_time * sqrt(9.8 / k));

    // Cálculo del vector de transformación
    vec3 transformVector = vec3(directionXZ.x * cos(f), sin(f), directionXZ.z * cos(f));
    transformVector = transformVector * (steepness / k);

    // Aplicación de la transformación al vértice
    vec3 transformedVertex = vertex + transformVector;

    // Asignación de los valores de salida
    vertColor = vec4(color, 1.0);
    gl_Position = modelViewProjMat * vec4(transformedVertex, 1.0);
}
