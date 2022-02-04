
void GetMainLight_float(float3 WorldPos, out half3 Direction, out half3 Color, out half Atten, out half ShadowAtten) {
#ifdef SHADERGRAPH_PREVIEW
	Direction = half3(0.5, 0.5, 0);
	Color = 1;
	Atten = 1;
	ShadowAtten = 1;
#else
	#ifdef SHADOWS_SCREEN
		half4 clipPos = TransformWorldToHClip(WorldPos);
		half4 shadowCoord = ComputeScreenPos(clipPos);
	#else
		half4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
	#endif

	Light light = GetMainLight();
	Direction = light.direction;
	Color = light.color;
	Atten = light.distanceAttenuation;
	ShadowAtten = light.shadowAttenuation;
#endif
}
//https://es.slideshare.net/unity3d/learn-how-to-do-stylized-shading-with-shader-graph-unite-copenhagen-2019

void GetAdditionalLights_float(half3 SpecularColor, half Smoothness, half3 WorldPosition, half3 WorldNormal, half3 WorldView,
							  out half3 Diffuse, out half3 Specular, out half3 Color) {

	half3 diffuseColor = 0;
	half3 specularColor = 0;
	half3 color = 0;

#ifndef SHADERGRAPH_PREVIEW
	Smoothness = exp2(10 * Smoothness + 1);
	WorldNormal = normalize(WorldNormal);
	WorldView = SafeNormalize(WorldView);
	int pixelLightCount = GetAdditionalLightsCount();
	for (int i = 0; i < pixelLightCount; ++i) {
		Light light = GetAdditionalLight(i, WorldPosition);
		half3 attenLightColor = light.color * (light.distanceAttenuation * light.shadowAttenuation);
		color += attenLightColor;
		diffuseColor += LightingLambert(attenLightColor, light.direction, WorldNormal);
		specularColor += LightingSpecular(attenLightColor, light.direction, WorldNormal, WorldView, half4(SpecularColor, 0), Smoothness);
	}
#endif

	Color = color;
	Diffuse = diffuseColor;
	Specular = specularColor;
}

