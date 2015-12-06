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
		Developer dev = new Developer();
		highest = dev.findHighestFreq();

		//TODO: Put label on the xaxis and put in a key

		//TODO: Need to make the pop up like from the lab

		for (int i = 1; i < devs.size(); ++i) 
		{
			

			float x1 = (float) map(i - 1, 0, devs.size(), border, width - border);
			float y1 = (float) map(devs.get(i - 1).avgCriticScore, 0, 100, height * 0.5f, border);
			float x2 = (float) map(i, 0, (float) devs.size (), border, width - border);
			float y2 = (float) map(devs.get(i).avgCriticScore, 0, 100, height * 0.5f, border);

			float x3 = map(i - 1, 0, devs.size(), border, width - border);
			float y3 = map(devs.get (i - 1).avgUserScore, 0, 100, height * 0.5f, border);
			float x4 = map(i, 0, devs.size (), border, width - border);
			float y4 = map(devs.get(i).avgUserScore, 0, 100, height * 0.5f, border);

			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x3, y3, x4, y4);

			//TODO: Get the names of the devs along the bottom
			drawLine();
		}

		//bottom part of area graph
		stroke(0);
		for (int i = 1 ; i < devs.size() ; i ++) 
		{
			float y1 = map(devs.get(i).freq, 0, highest, height - border, height * 0.5f);
			float y2 = map(devs.get(i - 1).freq, 0, highest, height - border, height * 0.5f);
			float x1 = map((float) i, 0, devs.size(), border, width - border);
			float x2 = map((float) i - 1, 0, devs.size(), border, width - border);
			line(x1, y1, x2, y2);

		}
		

		fill(0);
		stroke(0);
		// textAlign(CENTER, CENTER);
		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

		line(border, border, border, height - border);
		line(border, height - border, width - border, height - border);

		for (int i = 0 ; i <= highest ; i ++)
		{
			float yaxisLine = map((float) i, 0, highest, height - border, height * 0.5f);
			line(border, yaxisLine, border * 0.8f, yaxisLine);	
			text(i, border * 0.6f, yaxisLine);
		}

		line(border, height * 0.5f, width - border, height * 0.5f);
		for (int i = 0; i <= 10; ++i)
		{
			float yaxisLine = (float) map(i, 0, 10, (height * 0.5f), border);
			line (border, yaxisLine, border * 0.8f, yaxisLine);
			if(i != 0)
			{
				text(i * 10, border * 0.6f, yaxisLine);
			}

		}
	}

// FIXME: Better name than this
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
		    text("Developer: " + devs.get(i).name, mouseX + 10, y);
		    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX + 10, y + 10);
		    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX + 10, y + 20);
	  	}
	}

}