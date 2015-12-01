class GenreVis extends Draw
{

	float tempX;
	float tempY;
	float radius;

	public GenreVis() 
	{	
		super();	
		tempX = 0.0f;
		tempY = 0.0f;
		radius = width;	
	}

	void drawVis() 
	{
	
		//TODO: Come up with icons 
		//TODO: Replace the ellipses with the icons that i will make later
		//	1.Action is a gun with the ammo count as its percentage of the games
		//	2.Action Adventure is a map with a knife on it 
		// 	3.Adventure is a map
		//	4. Strategy is a lighbulb in a head shape
		// 	5.RPG is a dice with the number as its percentage
		//	6.Simulation is going to be a stick man
		//	7.Puzzle will be a few puzzle pieces
		// 	8. Sport is going to be a ball
		//  9. MMORPG is going to be a globe thing around the dice(like the RPG one)
		//need to use map or make a ratio to make the circles/any shape i choose bigger
		//

		//Not want i want it to be just testing if the other functions work
		Genre genre = new Genre();
		Draw draw = new Draw();
		int sum = genre.sumGenre(gameGenre);
		horRange = width / 3.0f;
	 	vertRange = height / 3.0f;
	 	float radius = width;
	 	tempX = 0.0f;
	 	tempY = vertRange / 2.0f;

		for (int i = 0; i < gameGenre.size (); ++i) {

			if (i % 3 == 0) 
			{ //FIXME: need to change the hard coding here 
				tempX = horRange / 2.0f;
				//only need y to increase after the first loop
				if (i > 0) 
				{
					tempY += vertRange;
				}
			}
			float ratio = (float) gameGenre.get(i).amount / (float) sum;
			fill(random(0, 255), 0, 0);
			ellipse(tempX, tempY, radius * ratio, radius * ratio);
			fill(255);

			tempX += horRange; 
		}
	}
}