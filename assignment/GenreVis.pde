class GenreVis extends Draw //implements Icon
{

	float tempX;
	float tempY;
	float radius;

	public GenreVis() 
	{	
		super();	
		tempX = 0.0f;
		tempY = 0.0f;
		radius = border;	
	}

	void drawVis() 
	{
		background(255);
		//TODO: Fix the title not being int the center
		//TODO: Make the Writing scale with a ratio
		//TODO: Make it colourful
		Genre genre = new Genre();
		// Draw draw = new Draw();
		int sum = genre.sumGenre(gameGenre);

		
		for(int i = 0 ; i < gameGenre.size() ; i ++)
		{
			tempY = (i + 1) * border;
			if(i == 0)
			{
				fill(0);
				text("Game Genre Popularity" , width * 0.5f, tempY);
			}
			else if(i % 2 == 0)
			{
				fill(0);
				text(gameGenre.get(i).genre, ((width * 0.5f) - (border * 2.0f)), tempY);
				text(gameGenre.get(i).amount, width - (border * 2.0f), tempY);
				fill(255);
				ellipse(width - (border * 2.0f), tempY, radius, radius);
				
			}
			else
			{
				fill(0);
				text(gameGenre.get(i).genre, width * 0.5f, tempY);
				text(gameGenre.get(i).amount, border * 2.0f, tempY);
				fill(255);
				ellipse(border * 2.0f, tempY, radius, radius);
			}
		}




		// horRange = width / 3.0f;
	 // 	vertRange = height / 3.0f;
	 // 	float radius = width;
	 // 	tempX = 0.0f;
	 // 	tempY = vertRange / 2.0f;

		// for (int i = 0; i < gameGenre.size (); ++i) {

		// 	if (i % 3 == 0) 
		// 	{ //FIXME: need to change the hard coding here 
		// 		tempX = horRange / 2.0f;
		// 		//only need y to increase after the first loop
		// 		if (i > 0) 
		// 		{
		// 			tempY += vertRange;
		// 		}
		// 	}
		// 	float ratio = (float) gameGenre.get(i).amount / (float) sum;
		// 	fill(random(0, 255), 0, 0);
		// 	ellipse(tempX, tempY, radius * ratio, radius * ratio);
		// 	fill(255);

		// 	tempX += horRange; 
		// }
	}
}