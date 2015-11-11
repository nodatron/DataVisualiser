class Draw {

	public Draw () {
		
	}

	void drawBarChart (ArrayList<GameData> gameData) {
	
		float border = width * 0.1f;
		float verticalRange = height - (border * 2.0f);
		float horRange = width - (border * 2.0f);
		float barWidth = verticalRange / gameData.size ();
		float y = height - border - barWidth; // - barwidth because it drwas down from the x,y point down



		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);

		for (int i = 0; i < gameData.size (); ++i) {
			fill (255, 0, 0);
			rect (border, y, map (gameData.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
			fill (0, 255, 0);
			rect (border, y, map (gameData.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

			//text for the y axis
			fill (0);
			text (gameData.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
			y -= barWidth;
		}

		// for (int i = 0; i <= gameData.size (); ++i) {
		// 	float yaxisLine = height - border - ((float)i * barWidth);
		// 	line (border, yaxisLine, border * 0.8f, yaxisLine);
		// }

		//Key for the graph
		fill (255, 0, 0);
		rect (border, height * 0.02f, border, height * 0.02f);
		fill(0);
		text ("Critic Review", border + (width * 0.02f), height * 0.035f);
		fill (0, 255, 0);
		rect (border, height * 0.06f, border, height * 0.02f);
		fill(0);
		text ("User Review", border + (width * 0.02f), height * 0.075f);

		fill(0);
		textAlign(CENTER, CENTER);
		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

		for (int i = 0; i <= 10; ++i) {
			float xaxisLine = border + ((horRange / 10.0f) * (float) i);
			line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
			text(i * 10, xaxisLine, height - (border * 0.6f));
		}
	}

	void drawGenreVisualization (ArrayList<Genre> gameGenre) {
	
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
		int sum = genre.sumGenre(gameGenre);
	 	float horRange = width / 3.0f;
	 	float vertRange = height / 3.0f;
	 	float radius = width;
	 	float x = 0.0f;
	 	float y = vertRange / 2.0f;

		for (int i = 0; i < gameGenre.size (); ++i) {

			if (i % 3 == 0) { //FIXME: need to change the hard coding here 
				x = horRange / 2.0f;
				//only need y to increase after the first loop
				if (i > 0) {
					y += vertRange;
				}
			}
			float ratio = (float) gameGenre.get(i).amount / (float) sum;
			fill(random(0, 255), 0, 0);
			ellipse(x, y, radius * ratio, radius * ratio);
			fill(255);

			x += horRange; 
		}
	}

	void drawTrendGraph (ArrayList<GameData> gameData) {
		//TODO: Put label on the xaxis and put in a key
		float border = width * 0.1f;
		float verticalRange = height - (border * 2.0f);
		float horRange = width - (border * 2.0f);

		for (int i = 1; i < gameData.size (); ++i) {
			

			float x1 = (float) map (i - 1, 0, gameData.size (), border, width - border);
			float y1 = (float) map (gameData.get (i - 1).criticReviewScore, 0, 100, height - border, border);
			float x2 = (float) map (i, 0, (float) gameData.size (), border, width - border);
			float y2 = (float) map (gameData.get (i).criticReviewScore, 0, 100, height - border, border);

			float x3 = map (i - 1, 0, gameData.size (), border, width - border);
			float y3 = map (gameData.get (i - 1).userReviewScore, 0, 100, height - border, border);
			float x4 = map (i, 0, gameData.size (), border, width - border);
			float y4 = map (gameData.get (i).userReviewScore, 0, 100, height - border, border);

			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x3, y3, x4, y4);

			//TODO: Figure out a way to make this more appealing to the eye
			fill (0);
			if(i % 2 == 0)
				text (gameData.get(i).gameName, x1, height - (border * 0.6f));
			else 
				text (gameData.get(i).gameName, x1, height - (border * 0.4f));
		}

		stroke(0);
		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);

		for (int i = 0; i <= gameData.size (); ++i) {
			float xaxisLine = (float) map (i, 0, (float) gameData.size (), border, width - border);
			line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
		}

		fill(0);
		textAlign(CENTER, CENTER);
		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

		for (int i = 0; i <= 10; ++i) {
			float yaxisLine = height - border - ((verticalRange / 10.0f) * (float) i);
			line (border, yaxisLine, border * 0.8f, yaxisLine);
			text(i * 10, border * 0.6f, yaxisLine);

		}
	}

	void drawFolderIcon () {
		float border = width * 0.05f;
		float vertRange = height - (border * 2.0f);
		float horRange = width - (border * 2.0f);

		stroke (245, 241, 222);
		fill (245, 241, 222);
		rect (border, border, horRange, vertRange);
		rect (border, border, (width * 0.2f), - (width * 0.02f));

		fill (0);
		text ("Devloper", (border * 1.05f), border);
	}

	void drawDeveloperVisualization (ArrayList<GameData> gameInfo,
									 ArrayList<Developer> devs) {
		devs = new Developer().developerFrequency (gameInfo, devs);
		drawFolderIcon ();

		int points = devs.size ();
		float cx = width / 2.0f;
		float cy = height / 2.0f;
		float radius = width * 0.2f;
		float theta = 0.0f;
		float theataInc = TWO_PI / 2.0f * (float) points;
		float lastX = cx;
		float lastY = cy - radius;

		

		for (int i = 0 ; i < points * 2 ; ++i) {
			//dont want it to draw when mod 2 == 0
			//NOTE: Drawing at all points for now
			float theata = (float) i * theataInc;
			float x, y;

			//FIXME: The points arent changing 
			x = cx + sin(theta) * radius;
			y = cy - cos(theta) * radius;

			stroke (0);
			ellipse (x, y, 10, 10);
			line (x, y, lastX, lastY);
			println(x + ", " + y + ", " + i + ", " + lastX + ", " + lastY);
	      	lastX = x;
	      	lastY = y; 
		}

		ellipseMode(RADIUS);
		fill(155, 111, 155);
		ellipse (cx, cy, radius, radius);
		ellipseMode(CENTER);
		fill(255);
		ellipse (cx, cy, radius, radius);
	}
}