//TODO: Take out all the common variables in these methods and make the class variables

class Draw 
{

	float border;
	float vertRange;
	float horRange;


	Draw() 
	{
		
		border = width * 0.1f;
		vertRange = height - (border * 2.0f);
		horRange = width - (border * 2.0f);

	}

	Draw(float border)
	{
		this.border = border;
		vertRange = height - (this.border * 2.0f);
		horRange = width - (this.border * 2.0f);
	}

	void drawVis() {}
	
}