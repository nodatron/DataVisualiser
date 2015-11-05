void setup () {
	size (1000, 800);
	background (255);

	ArrayList<GameData> games = new ArrayList<GameData> ();
	games = populate ();
	println (games.size());
	drawTrendGraph (games);
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
		fill(0);
		text (gameData.get(i).gameName, border + 20.0f, y + (barWidth * 0.9f));
		y -= barWidth;
	}

	for (int i = 0; i <= gameData.size (); ++i) {
		float yaxisLine = height - border - ((float)i * barWidth);
		line (border, yaxisLine, border * 0.8f, yaxisLine);
	}

	for (int i = 0; i <= 10; ++i) {
		float xaxisLine = border + ((horRange / 10.0f) * (float) i);
		line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
	}
}


void drawTrendGraph (ArrayList<GameData> gameData) {
	//TODO: Put labels on both of the axis
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
	}

	stroke(0);
	line (border, height - border, border, border);
	line (border, height - border, width - border, height - border);

	for (int i = 0; i <= gameData.size (); ++i) {
		float xaxisLine = (float) map (i, 0, (float) gameData.size (), border, width - border);
		line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
	}

	for (int i = 0; i <= 10; ++i) {
		float yaxisLine = height - border - ((verticalRange / 10.0f) * (float) i);
		line (border, yaxisLine, border * 0.8f, yaxisLine);
	}
}
/* NOTE: Draws a trend graph
*/
// void drawReviewScoreTrendGraph (ArrayList<Float> data) {
// 	//FIXME: Lines not connecting properly
// 	//TODO: Need to create a fucntion to draw the axis for the graph
// 	float border = width * 0.1f;
// 	float j = 1;
// 	//data.size() - 1
// 	for (int i = 2 ; i < 10; ++i) {
// 		stroke (255,0,0);//NOTE: This should be changes for a variable
// 		float x1 = map (j - 1, 0, data.size(), border, width - border);
// 		float x2 = map (j, 0, data.size(), border, width - border);
// 		float y1 = map (data.get(i - 2), 0, 100, height - border, border);
// 		float y2 = map (data.get(i), 0, 100, height - border, border);
// 		line (x1, y1, x2, y2);

// 		stroke (255);//NOTE: This should be changed for some variable
// 		float x3 = map (j - 1, 0, data.size(), border, width - border);
// 		float x4 = map (j, 0, data.size(), border, width - border);
// 		float y3 = map (data.get(i - 1), 0, 100, height - border, border);
// 		float y4 = map (data.get(i + 1), 0, 100, height - border, border);
// 		line (x3, y3, x4, y4);
// 		j++;
// 	}
// }





