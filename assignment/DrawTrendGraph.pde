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

			//TODO: The same thing done in the lab test make the line appear on the graph
			drawLine();
		}

		stroke(0);
		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);


		fill(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.5f) - textOffset, border * 0.5f);

		textSize(12);
		for (int i = 0; i <= 10; ++i)
		{
			float yaxisLine = height - border - ((vertRange / 10.0f) * (float) i);
			line(border, yaxisLine, border * 0.8f, yaxisLine);
			textWidth = textWidth("" + i * 10);
			text(i * 10, (border * 0.75f) - textWidth, yaxisLine + 5);

		}
	}

	void drawLine()
	{
	  	if (mouseX >= border && mouseX <= width - border)
	  	{
		    stroke(255, 0, 0);
		    fill(255, 0, 0);
		    line(mouseX, border, mouseX, height - border);
		    int i = (int) map(mouseX, border, width - border, 0, games.size() - 1);
		    float y = map(games.get(i).criticReviewScore, 0, 100, height - border, border);
		    float y2 = map(games.get(i).userReviewScore, 0, 100, height - border, border);
		    ellipse(mouseX, y, 5, 5);
		    ellipse(mouseX, y2, 5, 5);
		    fill(0);
		    textSize(10);
		    if(mouseX < width * 0.5f)
		    {
			    text("Game: " + games.get(i).gameName, mouseX + 10, height * 0.5f);
			    text("Critic Score: " + games.get(i).criticReviewScore, mouseX + 10, (height * 0.5f) + 10);
			    text("User Score: " + games.get(i).userReviewScore, mouseX + 10, (height * 0.5f) + 20);
			}
			else
			{
				textWidth = textWidth("Game: " + games.get(i).gameName);
				text("Game: " + games.get(i).gameName, (mouseX - textWidth) - 10, height * 0.5f);
		    	text("Critic Score: " + games.get(i).criticReviewScore, (mouseX - textWidth) - 10, (height * 0.5f) + 10);
		    	text("User Score: " + games.get(i).userReviewScore, (mouseX - textWidth) - 10, (height * 0.5f) + 20);
			}
	  	}
	}
}