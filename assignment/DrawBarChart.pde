class DrawBarChart extends Draw 
{

	DrawBarChart()
	{
		super();
	}

	//Draw a bar sideways barchart
	void drawVis() 
	{
		background(255);
		float barWidth = vertRange / games.size();
		float y = height - border - barWidth; // -barWidth because it draws down from the x, y points

		//drawing the axis
		line(border, height - border, border, border);
		line(border, height - border, width - border, height - border);

		//drawing the bars
		textSize(10);
		for(int i = 0 ; i < games.size () ; i ++) 
		{
			fill(255, 0, 0);
			rect(border, y, map (games.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
			fill(0, 255, 0);
			rect(border, y, map (games.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

			//labelling the y axis with the names of the games
			fill(0);
			text(games.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
			y -= barWidth;
		}

		//Drawing a key for the graph
		textSize(12);
		fill(255, 0, 0);
		textWidth = textWidth("Critic Review");
		rect(0, height * 0.02f, textWidth, height * 0.02f);
		fill(0);
		text("Critic Review", 0, height * 0.035f);
		fill(0, 255, 0);
		rect(0, height * 0.06f, textWidth, height * 0.02f);
		fill(0);
		text("User Review", 0, height * 0.075f);

		//title of the graph
		fill(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Review Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.6f) - textOffset, border * 0.5f);

		//labelling the xaxis
		textSize(10);
		for(int i = 0 ; i <= 10 ; i ++) 
		{
			float xaxisLine = border + ((horRange / 10.0f) * (float) i);
			line(xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
			textWidth = textWidth("" + i * 10);
			text(i * 10, xaxisLine - (textWidth * 0.5f), (height - (border * 0.6f)) + 5);
		}

	}
}