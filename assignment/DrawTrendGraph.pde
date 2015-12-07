class DrawTrendGraph extends Draw
{

	DrawTrendGraph () 
	{
		super();
	}

	void drawVis() 
	{
		background(255);

		//Calculates the points and draws the trend lines
		for (int i = 1; i < games.size(); ++i) 
		{

			float x1 = (float) map (i - 1, 0, games.size() - 1, border, width - border);
			float y1 = (float) map (games.get (i - 1).criticReviewScore, 0, 100, height - border, border);
			float x2 = (float) map (i, 0, (float) games.size() - 1, border, width - border);
			float y2 = (float) map (games.get (i).criticReviewScore, 0, 100, height - border, border);

			float y3 = map (games.get (i - 1).userReviewScore, 0, 100, height - border, border);
			float y4 = map (games.get (i).userReviewScore, 0, 100, height - border, border);

			//both have the same x points so no need to calculate them again
			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x1, y3, x2, y4);

			//draws a line down the graph to show what piece of data you are on
			drawLine();
		}

		//axis of the graph
		stroke(0);
		line (border, height - border, border, border);
		line (border, height - border, width - border, height - border);

		//key for the graph
		textSize(12);
		fill(0);
		text("Critic Review", 0, height * 0.035f);
		fill(0, 255, 0);
		fill(0, 255, 0);
		text("User Review", 0, height * 0.075f);

		//title of the graph
		fill(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.5f) - textOffset, border * 0.5f);

		//labelling the yaxis
		textSize(12);
		for (int i = 0; i <= 10; ++i)
		{
			float yaxisLine = height - border - ((vertRange / 10.0f) * (float) i);
			line(border, yaxisLine, border * 0.8f, yaxisLine);
			textWidth = textWidth("" + i * 10);
			text(i * 10, (border * 0.75f) - textWidth, yaxisLine + 5);

		}
	}

	//draws the line down the middle of the graph
	void drawLine()
	{
		//checks if it is within the borders of the graph
	  	if (mouseX >= border && mouseX <= width - border)
	  	{
		    stroke(255, 0, 0);
		    fill(255, 0, 0);
		    line(mouseX, border, mouseX, height - border);
		    //calculates i based on the position of the mouse
		    int i = (int) map(mouseX, border, width - border, 0, games.size() - 1);

		    float y = map(games.get(i).criticReviewScore, 0, 100, height - border, border);
		    float y2 = map(games.get(i).userReviewScore, 0, 100, height - border, border);

		    ellipse(mouseX, y, 5, 5);
		    ellipse(mouseX, y2, 5, 5);
		    
		    fill(0);
		    textSize(10);
		    // swaps the text over so it doesnt go off the screen
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