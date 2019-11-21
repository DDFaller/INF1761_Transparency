Shader "Custom/Transparency" {
     Properties {
          _Color ("My Color", Color) = (1,1,1,1) // The input color exposed in the Unity Editor, defined as type "Color" and set to rgba 1,1,1,1 (solid white) 
		  _MainTex ("Albedo (RGB)",2D) = "white" {} 
		  _BlendColor("Blend Texture Color",Color) = (1,1,1,1)
		  _BlendTex("Blend Texture Albedo (RGB)",2D) = "white" {}
		  _Blend("Blend Texture Amount", Range(0.0,1.0)) = 0.0
	 }
     SubShader {
          Tags {
			"Queue"="Transparent"
			"RenderType"="Transparent" 
			"IgnoreProjector"="True"
		  } 
		  ZWrite On
		  Blend SrcAlpha OneMinusSrcAlpha
		  Blend One One
		  LOD 200
		  Cull Off
          CGPROGRAM
          // Physically based Standard lighting model,
          // enable shadows on all light types
          #pragma surface surf Standard alpha
          // This Input struct is required for the "surf" function
          struct Input {
			   float2 uv_MainTex;
			   float2 uv_BlendTex;
          };
          fixed4 _Color; // A variable to store rgba color values
		  sampler2D _MainTex;
		  fixed4 _BlendColor;
		  sampler2D _BlendTex;
		  half _Blend;
          // This "surf" surface function with this signature is required
          // It is executed for each pixel of the objects with this shader
          void surf (Input IN, inout SurfaceOutputStandard o) {
               // Albedo comes is tinted by a color
               fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color; // Get the _Color value
               fixed4 b = tex2D (_BlendTex,IN.uv_BlendTex) * _BlendColor;
			   o.Albedo = (c.rgb * (1 - _Blend)) + (b.rgb * _Blend); // Set the "Albedo" or diffuse color rgb
			   o.Alpha = (c.a * (1 - _Blend)) + (b.a * _Blend);
		  }
          ENDCG
     }
     FallBack "Diffuse" // Revert to legacy shader if this shader-type not supported
}