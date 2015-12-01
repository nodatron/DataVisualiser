//TODO: Take out all the common variables in these methods and make the class variables

class Draw 
{

	float border;
	float vertRange;
	float horRange;


	Draw() 
	{
		
		border = width * 0.1f;
		vertRange = height - (border * 2.0f);
		horRange = width - (border * 2.0f);

	}

	Draw(float border)
	{
		this.border = border;
		vertRange = height - (this.border * 2.0f);
		horRange = width - (this.border * 2.0f);
	}

	void drawVis() {}

	

	

	void drawFolderIcon () 
	{
		Draw draw = new Draw();
		draw.border = width * 0.05f;

		stroke (245, 241, 222);
		fill (245, 241, 222);
		rect (draw.border, draw.border, draw.horRange, draw.vertRange);
		rect (draw.border, draw.border, (width * 0.2f), - (width * 0.02f));

		fill (0);
		text ("Devloper", (draw.border * 1.05f), draw.border);
	}

	//TODO: Need to fix this function to work drawing a gear visualisation

	// void drawDeveloperVisualization (ArrayList<GameData> gameInfo,
	// 								 ArrayList<Developer> devs) 
	// {
	// 	devs = new Developer().developerFrequency (gameInfo, devs);
	// 	for(Developer d : devs) 
	// 	{
	// 		print(d.name);
	// 		println(d.freq);

	// 	}
	// 	for(GameData g : gameInfo) 
	//  {
	// 		println(g.developerName);
	// 	}

	// 	drawFolderIcon();

	// 	int points = devs.size ();
	// 	float cx = width / 2.0f;
	// 	float cy = height / 2.0f;
	// 	float radius = width * 0.2f;
	// 	float theataInc = TWO_PI / (3.0f * (float) points);
	// 	float lastX = cx;
	// 	float lastY = cy - radius;

	// 	ArrayList<PVector> outsidePoint = new ArrayList<PVector>();

	// 	for (int i = 0; i < points; i++) 
	//  {
	// 		float theta = thetaInc * 3;
	// 	}

	// 	theataInc = TWO_PI / (2.0f * (float) points);

	// 	for (int i = 0 ; i < (points * 2) - 2 ; i++) 
	//  {
	// 		//dont want it to draw when mod 2 == 0
	// 		//NOTE: Drawing at all points for now
	// 		float theta = (float) i * theataInc;
			

	// 		//FIXME: The points arent changing 
	// 		float x = cx + sin(theta) * radius;
	// 		float y = cy - cos(theta) * radius;

			// stroke (0);
			// line (x, y, lastX, lastY);
			// rect (x, y, 20, 20);
			// if (theta > 0 && theta <= TWO_PI * 0.25f) 
			// {
			// 	rect (x, y, 40, -40);
			// } 
			// else if (theta > TWO_PI * 0.25f && theta <= TWO_PI * 0.5f) 
			// {
			// 	rect (x, y, 40, 40);
			// } 
			// else if (theta > TWO_PI * 0.5f && theta <= TWO_PI * 0.75f)  
			// {
			// 	rect (x, y, -40, 40);
			// }
			// else if (theta > TWO_PI * 0.75f && theta <= TWO_PI) 
			// {
			// 	rect (x, y, -40, -40);
			// }

	// 		//need to get another set of points that will be bigger than the points i have now
	// 		//use every second point to draw the trianglw from


	// 		println(x + ", " + y + ", " + i + ", " + lastX + ", " + lastY);
	//       	lastX = x;
	//       	lastY = y; 
	// 	}

	// 	ellipseMode(RADIUS);
	// 	fill(155, 111, 155);
	// 	ellipse (cx, cy, radius, radius);
	// 	ellipseMode(CENTER);
	// 	fill(255);
	// 	ellipse (cx, cy, radius, radius);
	// }
}