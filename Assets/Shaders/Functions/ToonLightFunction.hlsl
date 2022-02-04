//UNITY_SHADER_NO_UPGRADE
#ifndef TOON_LIGHT_INCLUDE
#define TOON_LIGHT_INCLUDE

float ToonLightFunction_float(float light, float3 thresholds, out float value)
{
	if (light <= thresholds[0]) {
		value = thresholds[0];
	} else if (light <= thresholds[1]) {
		value = thresholds[1];
	} else {
		value = thresholds[2];
	}

	return value;
}

#endif