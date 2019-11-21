Shader "geo"
{
	SubShader{
		Pass{
			CGPROGRAM
			struct geometryOutput{
				float4 pos : SV_POSITION;
			};

			[maxvertexcount(3)]
			void geo(triangle float4 IN[3] : SV_POSITION, inout TriangleStream<geometryOutput> triStream){
				geometryOutput o;

				o.pos = float4(0.5, 0, 0, 1);
				triStream.Append(o);

				o.pos = float4(-0.5, 0, 0, 1);
				triStream.Append(o);

				o.pos = float4(0, 1, 0, 1);
				triStream.Append(o);
			}
			ENDCG
		}
		
	}
}
