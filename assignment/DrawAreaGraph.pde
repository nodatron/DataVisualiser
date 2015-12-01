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
		for(int i = 0 ; i < devs.size() ; i ++)
		{
			dev.avgDevScore(devs.get(i).name, i);
		}

		//TODO: Put label on the xaxis and put in a key

		//TODO: Need to make the pop up like from the lab

		//TODO: Replace the numbers here with avergae for each dev
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

		stroke(0);
		line(border, height - border, border, border);
		line(border, height - border, width - border, height - border);

		for (int i = 0; i <= devs.size(); ++i) 
		{
			float xaxisLine = (float) map(i, 0, (float) devs.size(), border, width - border);
			line(xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
		}

		fill(0);
		textAlign(CENTER, CENTER);
		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

		for (int i = 0; i <= 10; ++i)
		{
			float h = (height * 0.5f);
			float yaxisLine = h - ((h / 10.0f) * (float) i);
			line (border, yaxisLine, border * 0.8f, yaxisLine);
			text(i * 10, border * 0.6f, yaxisLine);

		}
	}

}