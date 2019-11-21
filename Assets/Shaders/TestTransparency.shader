Shader "Roystan/Transparent"
{
    Properties
    {
		[Header(Shading)]
        _TopColor("Top Color", Color) = (1,1,1,1)
		_BottomColor("Bottom Color", Color) = (1,1,1,1)
		_TranslucentGain("Translucent Gain", Range(0,1)) = 0.5
    }

	CGINCLUDE
	#include "UnityCG.cginc"
	#include "Autolight.cginc"

	// Simple noise function, sourced from http://answers.unity.com/answers/624136/view.html
	// Extended discussion on this function can be found at the following link:
	// https://forum.unity.com/threads/am-i-over-complicating-this-random-function.454887/#post-2949326
	// Returns a number in the 0...1 range.
	float rand(float3 co)
	{
		return frac(sin(dot(co.xyz, float3(12.9898, 78.233, 53.539))) * 43758.5453);
	}

	// Construct a rotation matrix that rotates around the provided axis, sourced from:
	// https://gist.github.com/keijiro/ee439d5e7388f3aafc5296005c8c3f33
	float3x3 AngleAxis3x3(float angle, float3 axis)
	{
		float c, s;
		sincos(angle, s, c);

		float t = 1 - c;
		float x = axis.x;
		float y = axis.y;
		float z = axis.z;

		return float3x3(
			t * x * x + c, t * x * y - s * z, t * x * z + s * y,
			t * x * y + s * z, t * y * y + c, t * y * z - s * x,
			t * x * z - s * y, t * y * z + s * x, t * z * z + c
			);
	}
	struct vertexInput{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		float4 tangent : TANGENT;
	};

	struct vertexOutput{
		float4 vertex : SV_POSITION;
		float3 normal : NORMAL;
		float4 tangent : TANGENT;
	};

	vertexOutput vert(vertexInput v)
	{
		vertexOutput o;
		float4 pos = v.vertex;
		float3 vNormal = v.normal;
		float4 vTangent = v.tangent;
		float3 vBinormal = cross(vNormal,vTangent) * vTangent.w;

		float3x3 tangentToLocal = float3x3(
			vTangent.x, vBinormal.x, vNormal.x,
			vTangent.y, vBinormal.y, vNormal.y,
			vTangent.z, vBinormal.z, vNormal.z
		);
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.normal = v.normal;
		o.tangent = v.tangent;
		return o;
	}


	ENDCG

    SubShader
    {
		Cull Off

        Pass
        {
			Tags
			{
				"RenderType"="Transparent" 
				"Queue"="Transparent"
				"LightMode" = "ForwardBase"
			}
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite off

            CGPROGRAM
            #pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
            
			#include "Lighting.cginc"
			

			float4 _TopColor;
			float4 _BottomColor;
			float _TranslucentGain;

			float4 frag (vertexOutput i, fixed facing : VFACE) : SV_Target
            {	
				float4 color = lerp(_BottomColor,_TopColor,0.5);
				return color;
			}

            ENDCG
        }
    }
}