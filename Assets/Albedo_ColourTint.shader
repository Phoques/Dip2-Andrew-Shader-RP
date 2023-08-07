Shader "Lesson/Tint/Albedo" //we can find the Albedo Shader in the Lesson subFolder
{
	Properties //Our variables that we can modify in the inspector
	{
		_Texture ("Texture", 2D) = "black"{}	
		//our Variable name is _Texture
		//our Display name is Texture
		//it is of type 2D and defult untextured colour is black
		_Colour("Tint", Color) = (1,0,0,0)
		//4 floats that the user can input RGBA 0-1

	}
		SubShader // you can have multiple subshaders
		//these run at different GPU levels in platforms
	{
		Tags
		{
			"RenderType" = "Opaque"
			/*
			All built-in Unity shaders have a “RenderType” tag set that can be used when rendering with replaced shaders. Tag values are the following:

			Opaque: most of the shaders (Normal, Self Illuminated, Reflective, terrain shaders).
			Transparent: most semitransparent shaders (Transparent, Particle, Font, terrain additive pass shaders).
			TransparentCutout: masked transparency shaders (Transparent Cutout, two pass vegetation shaders).
			Background: Skybox shaders.
			Overlay: GUITexture, Halo, Flare shaders.
			TreeOpaque: terrain engine tree bark.
			TreeTransparentCutout: terrain engine tree leaves.
			TreeBillboard: terrain engine billboarded trees.
			Grass: terrain engine grass.
			GrassBillboard: terrain engine billboarded grass.
			*/
		}
		CGPROGRAM //The only difference between using HLSLPROGRAM and CGPROGRAM is in the 
			//files that Unity automatically includes when it compiles the shader program.
		#pragma surface mainColour Lambert finalcolor:mycolor
		//the surface of our model is affected by the mainColour Function
		//the material type is Lambert
		//Lambert is a flat Material that has no highlights
		sampler2D _Texture;//this connects our _Texture input property to the shader to allow us to use and edit it 
		fixed4 _Colour;//this connects our _Colour input property to the shader to allow us to use and edit it 

		struct Input
		{
			float2 uv_Texture;
			//this is in reference to our UV map of our Model
			//UV maps are Vector2 hence float2 both have 2 floats in them
			//it helps map our texture map to our uv map to put the colour
			//of each pixel in the right place
		};
		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _Colour;
		}
		void mainColour(Input IN, inout SurfaceOutput o)//mainColour Function
		{
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
			//Albedo is in reference to the surface RGB of this model
			//Red Green Blue
			//we are setting the models surface to the colour of our Texture2D
			//and matching the texture to our uv Map
		}
		ENDCG 
	}
	FallBack "Diffuse"//if all else fails we are a standard Diffuse (Lambert and Texture)
}
