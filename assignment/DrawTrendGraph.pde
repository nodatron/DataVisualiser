class DrawTrendGraph extends Draw
{

	DrawTrendGraph () 
	{
		super();
	}

	void drawVis() 
	{
		//TODO: Put label on the xaxis and put in a key

		//TODO: Need to make the pop up like from the lab
		background(255);
		for (int i = 1; i < games.size (); ++i) 
		{
			

			float x1 = (float) map (i - 1, 0, games.size (), border, width - border);
			float y1 = (float) map (games.get (i - 1).criticReviewScore, 0, 100, height - border, border);
			float x2 = (float) map (i, 0, (float) games.size (), border, width - border);
			float y2 = (float) map (games.get (i).criticReviewScore, 0, 100, height - border, border);

			float x3 = map (i - 1, 0, games.size (), border, width - border);
			float y3 = map (games.get (i - 1).userReviewScore, 0, 100, height - border, border);
			float x4 = map (i, 0, games.size (), border, width - border);
			float y4 = map (games.get (i).userReviewScore, 0, 100, height - border, border);

			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x3, y3, x4, y4);

			//TODO: Figure out a way to make this more appealing to the eye
			fill (0);
			if(i % 2 == 0)
				text (games.get(i).gameName, x1, height - (border * 0.6f));
			else 
				text (games.get(i).gameName, x1, height - (border * 0.4f));
		}

		stroke(0);
		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);

		for (int i = 0; i <= games.size (); ++i) 
		{
			float xaxisLine = (float) map (i, 0, (float) games.size (), border, width - border);
			line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
		}

		fill(0);
		textAlign(CENTER, CENTER);
		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

		for (int i = 0; i <= 10; ++i)
		{
			float yaxisLine = height - border - ((vertRange / 10.0f) * (float) i);
			line (border, yaxisLine, border * 0.8f, yaxisLine);
			text(i * 10, border * 0.6f, yaxisLine);

		}
	}

}