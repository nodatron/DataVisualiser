class DrawAreaGraph extends Draw
{
	int highest;

	DrawAreaGraph () 
	{
		super();
		highest = 0;
	}

	void drawVis() 
	{
		background(255);
		//used to call functions
		Developer dev = new Developer();
		highest = dev.findHighestFreq();

		//Top part of vis
		//Drawing the trend lines
		for (int i = 1; i < devs.size(); ++i) 
		{
			//Critic Trend points
			float x1 = (float) map(i - 1, 0, devs.size(), border, width - border);
			float y1 = (float) map(devs.get(i - 1).avgCriticScore, 0, 100, height * 0.5f, border);
			float x2 = (float) map(i, 0, (float) devs.size (), border, width - border);
			float y2 = (float) map(devs.get(i).avgCriticScore, 0, 100, height * 0.5f, border);

			//User trend points
			float x3 = map(i - 1, 0, devs.size(), border, width - border);
			float y3 = map(devs.get (i - 1).avgUserScore, 0, 100, height * 0.5f, border);
			float x4 = map(i, 0, devs.size (), border, width - border);
			float y4 = map(devs.get(i).avgUserScore, 0, 100, height * 0.5f, border);

			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x3, y3, x4, y4);

			//draws line from mouseX to xaxis and prints which developer your on
			drawLine();
		}

		//bottom part of vis
		stroke(0);
		for (int i = 1 ; i < devs.size() ; i ++) 
		{
			//points for developer frequency 
			float y1 = map(devs.get(i).freq, 0, highest, height - border, height * 0.5f);
			float y2 = map(devs.get(i - 1).freq, 0, highest, height - border, height * 0.5f);
			float x1 = map((float) i, 0, devs.size(), border, width - border);
			float x2 = map((float) i - 1, 0, devs.size(), border, width - border);
			line(x1, y1, x2, y2);

		}
		
		//title of the vis
		fill(0);
		stroke(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.5f) - textOffset, border * 0.5f);

		//draing the axis
		line(border, border, border, height - border);
		line(border, height - border, width - border, height - border);

		//labelling the yaxis for the bottom part
		textSize(12);
		for (int i = 0 ; i <= highest ; i ++)
		{
			float yaxisLine = map((float) i, 0, highest, height - border, height * 0.5f);
			line(border, yaxisLine, border * 0.8f, yaxisLine);	
			textWidth = textWidth("" + i);
			text(i, (border * 0.75f) - textWidth, yaxisLine + 5);
		}

		//labelling the yaxis for the top part
		line(border, height * 0.5f, width - border, height * 0.5f);
		for (int i = 0; i <= 10; ++i)
		{
			float yaxisLine = (float) map(i, 0, 10, (height * 0.5f), border);
			line (border, yaxisLine, border * 0.8f, yaxisLine);
			if(i != 0)
			{
				textWidth = textWidth("" + i * 10);
				text(i * 10, (border * 0.75f) - textWidth, yaxisLine + 5);
			}

		}
	}

// FIXME: Better name than this
	//draws line from mouseX to xaxis to show what Developer your on
	void drawLine()
	{
	  	if (mouseX >= border && mouseX <= width - border)
	  	{
		    stroke(255, 0, 0);
		    fill(255, 0, 0);
		    line(mouseX, border, mouseX, height - border);
		    int i = (int) map(mouseX, border, width - border, 0, devs.size() - 1);
		    float y = map(devs.get(i).avgCriticScore, 0, 100, height * 0.5f, border);
		    float y2 = map(devs.get(i).avgUserScore, 0, 100, height * 0.5f, border);
		    ellipse(mouseX, y, 5, 5);
		    ellipse(mouseX, y2, 5, 5);
		    fill(0);
		    textSize(12);

		    //changing which side of the line the text prints on so it remains readable
		    if(mouseX < width * 0.5f)
		    {
			    text("Developer: " + devs.get(i).name, mouseX + 10, vertRange * 0.5f);
			    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX + 10, (vertRange * 0.5f) + 10);
			    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX + 10, (vertRange * 0.5f) + 20);
			}
			else
			{
				textWidth = textWidth("Developer: " + devs.get(i).name);

				//making sure the text doesn't go over the line drawn
				if(textWidth < 150.0f)
				{
					text("Developer: " + devs.get(i).name, mouseX - 150, vertRange * 0.5f);
				    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX - 150, (vertRange * 0.5f) + 10);
				    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX - 150, (vertRange * 0.5f) + 20);
				}
				else
				{
					text("Developer: " + devs.get(i).name, mouseX - (textWidth + 10), vertRange * 0.5f);
				    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX - (textWidth + 10), (vertRange * 0.5f) + 10);
				    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX - (textWidth + 10), (vertRange * 0.5f) + 20);
				}
			}
	  	}
	}

}