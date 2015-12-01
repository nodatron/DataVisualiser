class DrawAreaGraph extends Draw
{


	DrawAreaGraph () 
	{
		super();
	}

	void drawVis() 
	{

		Developer dev = new Developer();
		dev.developerFrequency();
		int highest = dev.findHighestFreq();
		println(highest);
		for(int i = 0 ; i < devs.size() ; i ++)
		{
			dev.avgDevScore(devs.get(i).name, i);
		}

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

		//part to show of the info for the graoh when it is hovered over
		

		fill(0);
		textAlign(CENTER, CENTER);
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

}