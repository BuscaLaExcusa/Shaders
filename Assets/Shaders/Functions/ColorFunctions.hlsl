void MatchColors_half(half3 A, half3 B, half Value, half Threshold, half Offset, out half3 Out)
{
	Out = B;
	if (Value <= Threshold - Offset) {
		Out = A;
	}
	else if (Value <= Threshold + Offset) {
		float low = Threshold - Offset;
		float high = Threshold + Offset;
		float step = (Value - low) / (high - low);
		Out = lerp(A, B, step);
	}
}