Shader "Roystan/QueueTransparency"
{
    Properties
    {
        _MainTex("Texture to blend", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
    }
    SubShader
    {
       Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	    //https://docs.unity3d.com/Manual/SL-Blend.html?_ga=2.46790183.1495117683.1574358438-600925270.1562083123
		ZWrite Off
		ZTest Always
		Blend  SrcAlpha OneMinusSrcAlpha
        Pass
        {
            
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
 
                fixed4 _Color;
                sampler2D _MainTex;
                struct appdata_t {
                    float4 vertex : POSITION;
                    float2 texcoord: TEXCOORD0;
                    float4 color : COLOR;
                };
 
                struct v2f {
                    float4 vertex : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    float4 color : COLOR;
                };
 
                float4 _MainTex_ST;
                v2f vert(appdata_t v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.color = v.color;
                    return o;
                }
 
                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 texcol =  _Color;
					texcol.rgb = texcol.rgb * texcol.a;
					return texcol;
                }
            ENDCG
        }
    }
}