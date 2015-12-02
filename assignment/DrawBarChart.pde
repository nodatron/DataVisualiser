class DrawBarChart extends Draw 
{

	DrawBarChart()
	{
		super();
	}

	void drawVis() 
	{

		// Draw draw = new Draw();
		background(255);
		float barWidth = vertRange / games.size();
		float y = height - border - barWidth; // -barWidth because it draws down from the x,y points

		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);

		for (int i = 0; i < games.size (); ++i) 
		{
			fill (255, 0, 0);
			rect (border, y, map (games.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
			fill (0, 255, 0);
			rect (border, y, map (games.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

			//text for the y axis
			fill (0);
			text (games.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
			y -= barWidth;
		}

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
}