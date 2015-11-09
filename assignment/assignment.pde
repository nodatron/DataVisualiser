void setup () {
	size (1000, 800);
	background (255);

	ArrayList<GameData> games = new ArrayList<GameData> ();
	games = populate ();

	ArrayList<Genre> gameGenre = populateGenre ("PCGamesGenre.csv");
	
	println (games.size());
	drawVisualisationForGenre (gameGenre);
}


ArrayList populate () {
	ArrayList<GameData> gameInfo = new ArrayList<GameData> ();

	String[] arr = loadStrings ("PCGames.csv");

	for (String s : arr) {
		GameData data = new GameData (s);
		gameInfo.add (data);
	}

	return gameInfo;
}

/* NOTE: Draws Bar Chart
*/
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

/*
TODO: Make some sort of visualsation for the most popular genre of game 
TODO: Read in the values of the most popular genre in the file PCGamesGenre.csv
TODO: Maybe make an icon for each of the genres myself, gun for action

*/
ArrayList populateGenre (String filename) {

	ArrayList<Genre> genre = new ArrayList<Genre> ();
	String[] lines = loadStrings(filename);

	for (String s : lines) {
		Genre values = new Genre (s);
		genre.add (values);
	}

	return genre;
}

int sumGenre (ArrayList<Genre> gameGenre) {
	int sum = 0;

	for (Genre g : gameGenre) {
		sum += g.amount;
	}
	
	return sum;
}
void drawVisualisationForGenre (ArrayList<Genre> gameGenre) {
	
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
	int sum = sumGenre (gameGenre);
 	float horRange = width / 3.0f;
 	float vertRange = height / 3.0f;
 	float radius = width;
 	float x = 0.0f;
 	float y = vertRange / 2.0f;

	for (int i = 0; i < gameGenre.size (); ++i) {

		if (i % 3 == 0) {
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




//Find the most popular Developer
/*
	Need to get the number of times a developer has made one of the games in this list
	Store this in an arraylist of ints in which i know which developer belong to which int
	figure out what way i want to display the result that i get
*/
/*void findPopularDev (ArrayList<GameData> gameInfo) {
	ArrayList<Interger> popularDev = new ArrayList<Interger> ();
	ArrayList<String> gameDevs = findGameDevs (gameInfo);
	switch()
}

//NOTE: Takes the names of the game devs and gets the frequency
//FIXME: Need to figure out a way to add frequency values to an array list when i dont know the amount of values that need to be in the arraylist
//FIXME: function is unusable at the moment
ArrayList<String> findGameDevs (ArrayList<GameData> gameInfo) {
	ArrayList<Integer> gameDevs = new ArrayList<Integer> ();
	for (GameData g : gameInfo) {
		switch (g.developerName) {
			case "Valve Software":
				gameDev.get(0)++;
				 break;
			case "Rockstar North":
				gameDev.get(1)++;
				break;
			case "Irrational Games 2k Marin":
				gameDev.get(2)++;
				gameDev.get(3)++;
				break;
			case "BioWare":
				gameDev.get(4)++;
				break;
			case "Bethesda Games Studios":
				gameDev.get(5)++; 
				break;
			case "MPS Labs":
				gameDev.get(6)++;
				break;
			case "id Software":
				gameDev.get(7)++;
				break;
			case "CD Projekt Red":
				gameDev.get(8)++;
				break;
			case "LucasArts":
				gameDev.get(9)++;
				break;
			case "tobyfox":
				gameDev.get(10)++;
				break;
			case "Blizzard Entertainment":
				gameDev.get(11)++;
				break;
			case "Firaxis Games":
				gameDev.get(12)++;
				break;
			case "Relic":
				gameDev.get(13)++;
				break;
			case "Epic Games":
				gameDev.get(14)++;
				break;
			case "Mojang AB":
				gameDev.get(15)++;
				break;
			case "DMA Design":
				gameDev.get(16)++;
				break;
			case "Infinity Ward":
				gameDev.get(17)++;
				break;
			case "Maxis":
				gameDev.get(18)++;
				break;
			case "KCET":
				gameDev.get(19)++;
				break;
			case "Looking Glass Studios Irrational Games":
				gameDev.get(20)++;
				gameDev.get(2)++;
				break;
			case "Ubiosoft Montreal":
				gameDev.get(21)++;
				break;
			case "Creative Assembly":
				gameDev.get(22)++;
				break;
			case "Looking Glass Studios":
				gameDev.get(20)++;
				break;
			case "Ensemble Studios":
				gameDev.get(23)++;
				break;
			case "Stardock":
				gameDev.get(24)++;
				break;
			case "Headgate":
				gameDev.get(25)++;
				break;
			case "Arkane Studios":
				gameDev.get(26)++;
				break;
			case "2015 Inc":
				gameDev.get(27)++;
				break;
			case "Bungie Software":
				gameDev.get(28)++;
				break;
			case "Electronic Arts":
				gameDev.get(29)++;
				break;
			case "1C":
				gameDev.get(30)++;
				break;
			default:
				throw IllegalArumentException("Invalid game Developer " + g.developerName);
				break;
		}
		gameDevs.add( gameDev);
	}
	return gameDevs
}*/



