Shader "Lesson/Normal/Albedo" //we can find the Albedo Shader in the Lesson and Normal subFolders
{
	Properties //Our variables that we can modify in the inspector
	{
		_Texture ("Texture", 2D) = "black"{}//defult colour can be black, grey, white
		//our Variable name is _Texture
		//our Display name is Texture
		//it is of type 2D and defult untextured colour is black
		_NormalMap("Normal", 2D) = "bump"{} //always bump
		//normal map also known as bump map
		//uses rgb colour value to creat x,y,z depth to the material
		//A normal map tells the normals (faces of an object) how light will be bouncing off and at what angles
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
		#pragma surface mainColour Lambert
		//the surface of our model is affected by the mainColour Function
		//the material type is Lambert
		//Lambert is a flat Material that has no highlights

		sampler2D _Texture;//this connects our _Texture input property to the shader to allow us to use and edit it 
		sampler2D _NormalMap;//this connects our _NormalMap input property to the shader to allow us to use and edit it 
		
		struct Input
		{
			float2 uv_Texture;
			//this is in reference to our UV map of our Model
			//UV maps are Vector2 hence float2 both have 2 floats in them
			//it helps map our texture map to our uv map to put the colour
			//of each pixel in the right place
			float2 uv_NormalMap;//UV map linking to NormalMap vector2
		};
		void mainColour(Input IN, inout SurfaceOutput o)//mainColour Function
		{
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
			//Albedo is in reference to the surface RGB of this model
			//Red Green Blue
			//we are setting the models surface to the colour of our Texture2D
			//and matching the texture to our uv Map
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			//Normal is in reference to the bump map
			//UnpackNormal is required because Game engines compress files
			//we need to decompress the normal to get a true value
			//Bump maps are visible when light is reflected off
			//the light is bounced at the angle of the RGB XYZ values
			//creating depth
		}
		ENDCG 
	}
	FallBack "Diffuse"//if all else fails we are a standard Diffuse (Lambert and Texture)
}
