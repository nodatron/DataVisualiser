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
			float stringWidth = textWidth(gameGenre.get(i).genre);
			if(i == 0)
			{
				fill(0);
				float titleWidth = textWidth("Game Genre Popularity");
				text("Game Genre Popularity" , ((width * 0.5f) - (titleWidth * 0.5f)), tempY);
			}
			else if(i % 2 == 0)
			{
				fill(0);
				text(gameGenre.get(i).genre, ((width * 0.5f) - (stringWidth * 0.5f)), tempY);
				text(gameGenre.get(i).amount, width - (border * 2.0f), tempY);
				fill(255);
				ellipse(width - (border * 2.0f), tempY, radius, radius);
				
			}
			else
			{
				fill(0);
				text(gameGenre.get(i).genre, ((width * 0.5f) - (stringWidth * 0.5f)), tempY);
				text(gameGenre.get(i).amount, border * 2.0f, tempY);
				fill(255);
				ellipse(border * 2.0f, tempY, radius, radius);
			}
		}
	}
}