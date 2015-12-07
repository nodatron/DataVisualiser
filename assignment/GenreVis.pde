class GenreVis extends Draw
{
	float tempX;
	float tempY;
	float radius;
	int sum;
	float ratio;
	int tsize;

	public GenreVis() 
	{	
		super();	
		tempX = 0.0f;
		tempY = 0.0f;
		radius = border;	
		sum = 0;
		ratio = 0;
		tsize = 26;
	}

	//draws the vis for the genres
	void drawVis() 
	{
		background(0, 255, 255);
		//getting the sum of all the genres
		Genre genre = new Genre();
		sum = genre.sumGenre();
		
		//need to rescale the border so everything fits
		border = height * 0.09f;

		fill(0);
		//title of the vis
		textSize(36);
		textWidth = textWidth("Game Genre Popularity");
		textOffset = textWidth * 0.5f;
		text("Game Genre Popularity" , ((width * 0.5f) - textOffset), border);

		//draws the main part of the vis
		for(int i = 0 ; i < gameGenre.size() ; i ++)
		{
			//the y value text and shapes are drawn at
			tempY = (i + 2) * border;
			
			//ratio to scale everything by
			ratio = 2.0f * ((float) gameGenre.get(i).amount / sum);

			//swap between the circle drawn on the left or the right
			//most of the code here is just to make everything center correctly
			if(i % 2 == 0)
			{
				textSize(tsize + (tsize * ratio));

				fill(255);
				ellipse(width - (border * 2.0f), tempY , radius + (radius * ratio), radius + (radius * ratio));

				fill(0);
				textWidth = textWidth(gameGenre.get(i).genre);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).genre, ((width * 0.5f) - textOffset), tempY + 10);

				textWidth = textWidth("" + gameGenre.get(i).amount);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).amount, width - (border * 2.0f) - textOffset, tempY + 10);
			}
			else
			{
				textSize(tsize + (tsize * ratio));

				fill(255);
				ellipse(border * 2.0f, tempY, radius + (radius * ratio), radius + (radius * ratio));

				fill(0);
				textWidth = textWidth(gameGenre.get(i).genre);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).genre, ((width * 0.5f) - textOffset), tempY + 10);

				textWidth = textWidth("" + gameGenre.get(i).amount);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).amount, (border * 2.0f) - textOffset, tempY + 10);
				
			}
		}
	}
}