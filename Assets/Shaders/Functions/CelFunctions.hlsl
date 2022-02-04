void OneCel_half(half3 LightValue, half Threshold, half3 LitColor, half3 ShadowColor, out half3 Out)
{
	Out = LitColor;
	half light = length(LightValue);
	if (light <= Threshold) {
		Out = ShadowColor;
	}
}


void SmoothCel_half(half3 LightValue, half HighThreshold, half LowThreshold, half3 LitColor, half3 ShadowColor, out half3 Out)
{
	Out = LitColor;
	half light = length(LightValue);

	if (light <= LowThreshold) {	// Below low threshold, return shadow color
		Out = ShadowColor;

	} else if (light <= HighThreshold) {	// Between low and high thresholds, smooth transition
		half step = (light - LowThreshold) / (HighThreshold - LowThreshold);
		Out = lerp(ShadowColor, LitColor, step);
	}
}