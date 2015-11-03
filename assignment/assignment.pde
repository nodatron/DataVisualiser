void setup () {
	size (800, 600);
	background (255);

	ArrayList<Float> gameReviewScores = readInReviewScores ("PCGamesReview.csv");
	String[] gamesNames = readIntoStringArray ("PCGamesName.csv");
	drawReviewScoreTrendGraph (gameReviewScores, gamesNames);
}

/* NOTE: Loads a float arrayList with values from a file
*/
ArrayList<Float> readInReviewScores (String filename){
	ArrayList<Float> floatal = new ArrayList<Float> ();
	String[] arr = loadStrings (filename);

	for (String s : arr) {
		String[] vals = s.split (",");
		for (String c : vals)
			floatal.add (Float.parseFloat(c));
	}

	return floatal;
}

/* NOTE: Draws Bar Chart
*/
void drawReviewScoreBarChart (ArrayList<Float> data,
							  String[] dataNames
							  ) {
	//TODO: Create a function to draw the axis of the graph
	float border = width * 0.1f;
	float verticalRange = height - (border * 2.0f);
	float horRange = width - (border * 2.0f);
	float barWidth = verticalRange / (float) (data.size() / 2.0f);
	float x = border, y = height - border - barWidth; // - barwidth because it drwas down from the point


	for (int i = 0 ; i < data.size () ; ++i) {
		
		// TODO: Need to figure out how to make the two bars visible if the user score is bigger
		//bigger than the critic score
		if (i % 2 == 1) {
			// user review
			fill (0, 255, 0);
			rect (x, y, map((float) data.get(i), 0.0f, 100.0f, 0.0f, horRange), barWidth);	
			y -= barWidth;
		} else {
			// critic review
			fill (255, 0, 0);
			rect (x, y, map((float) data.get(i), 0.0f, 100.0f, 0.0f, horRange), barWidth);	
		}
	}
	drawBarChartAxis (data, border, horRange, verticalRange, dataNames);
}

/* NOTE: Draws axis for a graph based on x, y axis
*/
void drawBarChartAxis (ArrayList<Float> data, 
					   float border, 
					   float horRange, 
					   float verticalRange,
					   String[] dataNames
					   ) {
	//FIXME: The vert axis pints are not lining up and the text is not coming up in the boxes correct
	//FIXME: The points on y axis dont line up with the bars width
	stroke (127); //NOTE: This should change for some colour that i have a variable for
	fill(0, 0, 255);
	// Draws the x and y axis
	line (border, height - border, width - border, height - border);
	line (border, height - border, border, border);

	// Draws the points on the y axis and adds the text
	for (int i = 0; i < data.size () / 2; ++i) {
		float y = height - (border + ((verticalRange / ((data.size () - 1.0f) / 2.0f)) * (float) i));
		line(border, y, border * 0.8f, y);

		// Writes the names of the games on the bars
		textSize(10);
		text(dataNames[i] + "   " + i, border + 20.0f, y);
	}

	// Draws the points on the x axis and adds the text
	for (int i = 0; i < 10; ++i) {
		float x = border + ((horRange / 9.0f) * (float) i);
		line(x, height - border, x, height - (border * 0.8f));
	}
}

/* NOTE: Loads a string arraylist from a file
*/
String[] readIntoStringArray (String filename) {
	String[] arr = loadStrings (filename);

	return arr;
}

/* NOTE: Draws a trend graph
*/
void drawReviewScoreTrendGraph (ArrayList<Float> data) {
	//FIXME: Lines not connecting properly
	//TODO: Need to create a fucntion to draw the axis for the graph
	float border = width * 0.1f;
	float j = 1;
	//data.size() - 1
	for (int i = 2 ; i < 10; ++i) {
		stroke (255,0,0);//NOTE: This should be changes for a variable
		float x1 = map (j - 1, 0, data.size(), border, width - border);
		float x2 = map (j, 0, data.size(), border, width - border);
		float y1 = map (data.get(i - 2), 0, 100, height - border, border);
		float y2 = map (data.get(i), 0, 100, height - border, border);
		line (x1, y1, x2, y2);

		stroke (255);//NOTE: This should be changed for some variable
		float x3 = map (j - 1, 0, data.size(), border, width - border);
		float x4 = map (j, 0, data.size(), border, width - border);
		float y3 = map (data.get(i - 1), 0, 100, height - border, border);
		float y4 = map (data.get(i + 1), 0, 100, height - border, border);
		line (x3, y3, x4, y4);
		j++;
	}
}





