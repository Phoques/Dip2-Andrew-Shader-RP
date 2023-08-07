Shader "Unlit/NewUnlitShader"
{
    Properties // These show up in the inspector. So variables / other textures etc would be here.
    {
        // _number("My Number", int) = 4;
        //e.g _number is the declaration ("My Number") is the name in the inspector. , int is the type, and the 4 is the default.
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader // You can have multiple subshaders per shader. Also what kind of shader it is, in this case its Opaque.
        //Sub Shaders can also have multiple passes.
        //Subshaders can be used to target different hardware as well.
    {
        //Unity wants to do things differently depending on what Tags are used.
        Tags { "RenderType"="Opaque" }

        Pass // Each pass will build a shader over the top. So one pass might be red, the next pass might be like... Shiny or some shit.
        {
            CGPROGRAM // Start of the HLSL code


            // Vertex is the 'type / function' and 'vert' is the variable name same with Fragment frag.
            #pragma vertex vert //Runs once for every vert (On a normal map)
            #pragma fragment frag //Runs for each texel

            //This is kind of like 'Using' in like 'Using UnityEngine;'
            #include "UnityCG.cginc"

            struct appdata // This is the input for our vert
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f // this is the output (Vertex to Fragment)
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            int _Number;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = v.vertex; //UnityObjectToClipPos();    <-- Getting rid of this, means the material wont be on the mesh, its literally just. flat on the screen and follows the screen.
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {

                float4 colour = {1,0,0,1}; // THis is red, not transparent.
            return colour.xxxw; // x is red, y is green, z is blue and w is transparent. This makes it white tho so... Unsure.
            }


            ENDCG // End of HLSL code.
        }
    }
}
