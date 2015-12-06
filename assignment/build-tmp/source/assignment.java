import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Assignment extends PApplet {


//FIXME: Area Graph and Trend Graph dont go the full way to the end of the graphs

ArrayList<Draw> draw = new ArrayList<Draw>();
ArrayList<GameData> games = new ArrayList<GameData> ();
ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
ArrayList<Developer> devs = new ArrayList<Developer> ();
OOPAssignmentUtils util = new OOPAssignmentUtils();
Menu menu;

boolean isMenu = true;
boolean[] vis = new boolean[4];

public void setup() 
{
	
	background(255);

	menu = new Menu(color(153, 255, 204), color(0, 204, 0), color(102, 204, 204), color(51, 204, 255), "cgicon.png");
	draw.add(menu);
	DrawBarChart barChart = new DrawBarChart();
	draw.add(barChart);
	DrawTrendGraph trendGraph = new DrawTrendGraph();
	draw.add(trendGraph);
	DrawAreaGraph areaGraph = new DrawAreaGraph();
	draw.add(areaGraph);
	GenreVis genreVis = new GenreVis();
	draw.add(genreVis);

	

	
	games = util.populate();	
	gameGenre = util.populateGenre();	
	devs = util.populateDeveloper();

	Developer dev = new Developer();
	dev.developerFrequency();
	for(int i = 0 ; i < devs.size() ; i ++)
	{
		dev.avgDevScore(devs.get(i).name, i);
	}

	draw.get(0).drawVis();

}

public void draw()
{
    //need to do it this way because it needs to update constitently
	if(keyPressed)
    {
        if(key == '0')
  		{
  			isMenu = true;
  			vis[0] = false;
  			vis[1] = false;
  			vis[2] = false;
  			vis[3] = false;
  		}
  		if(key == '1')
  		{
  			isMenu = false;
  			vis[0] = true;
  			vis[1] = false;
  			vis[2] = false;
  			vis[3] = false;
  		}
  		if(key == '2')
  		{
  			isMenu = false;
  			vis[0] = false;
  			vis[1] = true;
  			vis[2] = false;
  			vis[3] = false;
  		}
  		if(key == '3')
  		{
  			isMenu = false;
  			vis[0] = false;
  			vis[1] = false;
  			vis[2] = true;
  			vis[3] = false;
  		}
  		if(key == '4')
  		{
  			isMenu = false;
  			vis[0] = false;
  			vis[1] = false;
  			vis[2] = false;
  			vis[3] = true;
  		}
    }

    if(isMenu)
        {
            draw.get(0).drawVis();
        }
        if(vis[0])
        {
            draw.get(1).drawVis();
        }
        if(vis[1])
        {
            draw.get(2).drawVis();
        }
        if(vis[2])
        {
            draw.get(3).drawVis();
        }
        if(vis[3])
        {
            draw.get(4).drawVis();
        }
}

class Developer {

	String name;
	int freq;
	float avgCriticScore;
	float avgUserScore;

	Developer () {
		name = "";
		freq = 0;
		avgCriticScore = 0;
		avgUserScore = 0;
	}

	Developer (String line) {
		name = line;
		freq = 0;
		avgCriticScore = 0;
		avgUserScore = 0;
	}

	public void developerFrequency() 
	{
		for (int i = 0 ; i < games.size () ; i ++) 
		{
			for (int j = 0 ; j < devs.size () ; j ++) 
			{
				if (games.get(i).developerName.equals(devs.get(j).name)) 
				{
					devs.get(j).freq ++;
				}
			}
		}
	}

	public int findHighestFreq() 
	{
		int highest = 0;

		for (Developer d : devs) 
		{
			if (d.freq > highest) 
			{
				highest = d.freq;			
			}
		}

		return highest;
	}

	//gets the avg score for each developer
	public void avgDevScore(String devName, int pos)
	{
		int i = 0;
		float sumCritic = 0;
		float sumUser = 0;
		for(GameData gd : games)
		{
			if(gd.developerName.equals(devName))
			{
				i ++;
				sumCritic += gd.criticReviewScore;
				sumUser += gd.userReviewScore;
			}
		}

		devs.get(pos).avgCriticScore = sumCritic / (float) i;
		devs.get(pos).avgUserScore = sumUser / (float) i;
	}
}
//TODO: Take out all the common variables in these methods and make the class variables

class Draw 
{

	float border;
	float vertRange;
	float horRange;
	float textWidth;
	float textOffset;

	Draw() 
	{
		
		border = width * 0.1f;
		vertRange = height - (border * 2.0f);
		horRange = width - (border * 2.0f);
		textWidth = 0;
		textOffset = 0;
	}

	Draw(float border)
	{
		this.border = border;
		vertRange = height - (this.border * 2.0f);
		horRange = width - (this.border * 2.0f);
		textWidth = 0;
		textOffset = 0;
	}

	public void drawVis() {}
	
}
class DrawAreaGraph extends Draw
{

	int highest;

	DrawAreaGraph () 
	{
		super();
		highest = 0;
	}

	public void drawVis() 
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
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.5f) - textOffset, border * 0.5f);

		line(border, border, border, height - border);
		line(border, height - border, width - border, height - border);

		textSize(12);
		for (int i = 0 ; i <= highest ; i ++)
		{
			float yaxisLine = map((float) i, 0, highest, height - border, height * 0.5f);
			line(border, yaxisLine, border * 0.8f, yaxisLine);	
			textWidth = textWidth("" + i);
			text(i, (border * 0.75f) - textWidth, yaxisLine + 5);
		}

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
	public void drawLine()
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
		    if(mouseX < width * 0.5f)
		    {
			    text("Developer: " + devs.get(i).name, mouseX + 10, vertRange * 0.5f);
			    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX + 10, (vertRange * 0.5f) + 10);
			    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX + 10, (vertRange * 0.5f) + 20);
			}
			else
			{
				textWidth = textWidth("Developer: " + devs.get(i).name);
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
class DrawBarChart extends Draw 
{

	DrawBarChart()
	{
		super();
	}

	public void drawVis() 
	{

		// Draw draw = new Draw();
		background(255);
		float barWidth = vertRange / games.size();
		float y = height - border - barWidth; // -barWidth because it draws down from the x,y points

		line(border, height - border, border, border);
		line(border, height - border, width - border, height - border);

		textSize(10);
		for(int i = 0 ; i < games.size () ; i ++) 
		{
			fill(255, 0, 0);
			rect(border, y, map (games.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
			fill(0, 255, 0);
			rect(border, y, map (games.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

			//text for the y axis
			fill(0);
			text(games.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
			y -= barWidth;
		}

		//Key for the graph
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

		fill(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Review Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.6f) - textOffset, border * 0.5f);

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
// //TODO: Take out all the common variables in these methods and make the class variables

// class Draw {

// 	public Draw () {
		
// 	}

// 	void drawBarChart (ArrayList<GameData> gameData) {
	
// 		float border = width * 0.1f;
// 		float verticalRange = height - (border * 2.0f);
// 		float horRange = width - (border * 2.0f);
// 		float barWidth = verticalRange / gameData.size ();
// 		float y = height - border - barWidth; // - barwidth because it drwas down from the x,y point down



// 		line (border, height - border, border, border);
// 		line (border, height - border, width - border, height - border);

// 		for (int i = 0; i < gameData.size (); ++i) {
// 			fill (255, 0, 0);
// 			rect (border, y, map (gameData.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
// 			fill (0, 255, 0);
// 			rect (border, y, map (gameData.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

// 			//text for the y axis
// 			fill (0);
// 			text (gameData.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
// 			y -= barWidth;
// 		}

// 		// for (int i = 0; i <= gameData.size (); ++i) {
// 		// 	float yaxisLine = height - border - ((float)i * barWidth);
// 		// 	line (border, yaxisLine, border * 0.8f, yaxisLine);
// 		// }

// 		//Key for the graph
// 		fill (255, 0, 0);
// 		rect (border, height * 0.02f, border, height * 0.02f);
// 		fill(0);
// 		text ("Critic Review", border + (width * 0.02f), height * 0.035f);
// 		fill (0, 255, 0);
// 		rect (border, height * 0.06f, border, height * 0.02f);
// 		fill(0);
// 		text ("User Review", border + (width * 0.02f), height * 0.075f);

// 		fill(0);
// 		textAlign(CENTER, CENTER);
// 		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

// 		for (int i = 0; i <= 10; ++i) {
// 			float xaxisLine = border + ((horRange / 10.0f) * (float) i);
// 			line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
// 			text(i * 10, xaxisLine, height - (border * 0.6f));
// 		}
// 	}

// 	void drawGenreVisualization (ArrayList<Genre> gameGenre) {
	
// 		//TODO: Come up with icons 
// 		//TODO: Replace the ellipses with the icons that i will make later
// 		//	1.Action is a gun with the ammo count as its percentage of the games
// 		//	2.Action Adventure is a map with a knife on it 
// 		// 	3.Adventure is a map
// 		//	4. Strategy is a lighbulb in a head shape
// 		// 	5.RPG is a dice with the number as its percentage
// 		//	6.Simulation is going to be a stick man
// 		//	7.Puzzle will be a few puzzle pieces
// 		// 	8. Sport is going to be a ball
// 		//  9. MMORPG is going to be a globe thing around the dice(like the RPG one)
// 		//need to use map or make a ratio to make the circles/any shape i choose bigger
// 		//

// 		//Not want i want it to be just testing if the other functions work
// 		Genre genre = new Genre();
// 		int sum = genre.sumGenre(gameGenre);
// 	 	float horRange = width / 3.0f;
// 	 	float vertRange = height / 3.0f;
// 	 	float radius = width;
// 	 	float x = 0.0f;
// 	 	float y = vertRange / 2.0f;

// 		for (int i = 0; i < gameGenre.size (); ++i) {

// 			if (i % 3 == 0) { //FIXME: need to change the hard coding here 
// 				x = horRange / 2.0f;
// 				//only need y to increase after the first loop
// 				if (i > 0) {
// 					y += vertRange;
// 				}
// 			}
// 			float ratio = (float) gameGenre.get(i).amount / (float) sum;
// 			fill(random(0, 255), 0, 0);
// 			ellipse(x, y, radius * ratio, radius * ratio);
// 			fill(255);

// 			x += horRange; 
// 		}
// 	}

// 	void drawTrendGraph (ArrayList<GameData> gameData) {
// 		//TODO: Put label on the xaxis and put in a key
// 		float border = width * 0.1f;
// 		float verticalRange = height - (border * 2.0f);
// 		float horRange = width - (border * 2.0f);

// 		for (int i = 1; i < gameData.size (); ++i) {
			

// 			float x1 = (float) map (i - 1, 0, gameData.size (), border, width - border);
// 			float y1 = (float) map (gameData.get (i - 1).criticReviewScore, 0, 100, height - border, border);
// 			float x2 = (float) map (i, 0, (float) gameData.size (), border, width - border);
// 			float y2 = (float) map (gameData.get (i).criticReviewScore, 0, 100, height - border, border);

// 			float x3 = map (i - 1, 0, gameData.size (), border, width - border);
// 			float y3 = map (gameData.get (i - 1).userReviewScore, 0, 100, height - border, border);
// 			float x4 = map (i, 0, gameData.size (), border, width - border);
// 			float y4 = map (gameData.get (i).userReviewScore, 0, 100, height - border, border);

// 			stroke (0);
// 			line (x1, y1, x2, y2);
// 			stroke (0, 255, 0);
// 			line(x3, y3, x4, y4);

// 			//TODO: Figure out a way to make this more appealing to the eye
// 			fill (0);
// 			if(i % 2 == 0)
// 				text (gameData.get(i).gameName, x1, height - (border * 0.6f));
// 			else 
// 				text (gameData.get(i).gameName, x1, height - (border * 0.4f));
// 		}

// 		stroke(0);
// 		line (border, height - border, border, border);
// 		line (border, height - border, width - border, height - border);

// 		for (int i = 0; i <= gameData.size (); ++i) {
// 			float xaxisLine = (float) map (i, 0, (float) gameData.size (), border, width - border);
// 			line (xaxisLine, height - border, xaxisLine, height - (border * 0.8f));
// 		}

// 		fill(0);
// 		textAlign(CENTER, CENTER);
// 		text("Top 50 PC Games of All Time Critic and User Scores", width / 2.0f, border * 0.5f);

// 		for (int i = 0; i <= 10; ++i) {
// 			float yaxisLine = height - border - ((verticalRange / 10.0f) * (float) i);
// 			line (border, yaxisLine, border * 0.8f, yaxisLine);
// 			text(i * 10, border * 0.6f, yaxisLine);

// 		}
// 	}

// 	void drawFolderIcon () {
// 		float border = width * 0.05f;
// 		float vertRange = height - (border * 2.0f);
// 		float horRange = width - (border * 2.0f);

// 		stroke (245, 241, 222);
// 		fill (245, 241, 222);
// 		rect (border, border, horRange, vertRange);
// 		rect (border, border, (width * 0.2f), - (width * 0.02f));

// 		fill (0);
// 		text ("Devloper", (border * 1.05f), border);
// 	}

// 	void drawDeveloperVisualization (ArrayList<GameData> gameInfo,
// 									 ArrayList<Developer> devs) {
// 		devs = new Developer().developerFrequency (gameInfo, devs);
// 		for(Developer d : devs) {
// 			print(d.name);
// 			println(d.freq);

// 		}
// 		for(GameData g : gameInfo) {
// 			println(g.developerName);
// 		}
// 		drawFolderIcon ();

// 		int points = devs.size ();
// 		float cx = width / 2.0f;
// 		float cy = height / 2.0f;
// 		float radius = width * 0.2f;
// 		float theataInc = TWO_PI / (3.0f * (float) points);
// 		float lastX = cx;
// 		float lastY = cy - radius;

// 		ArrayList<PVector> outsidePoint = new ArrayList<PVector>();

// 		for (int i = 0; i < points; i++) {
// 			float theta = thetaInc * 3;
// 		}

// 		theataInc = TWO_PI / (2.0f * (float) points);

// 		for (int i = 0 ; i < (points * 2) - 2 ; i++) {
// 			//dont want it to draw when mod 2 == 0
// 			//NOTE: Drawing at all points for now
// 			float theta = (float) i * theataInc;
			

// 			//FIXME: The points arent changing 
// 			float x = cx + sin(theta) * radius;
// 			float y = cy - cos(theta) * radius;

// 			stroke (0);
// 			// line (x, y, lastX, lastY);
// 			// rect (x, y, 20, 20);
// 			// if (theta > 0 && theta <= TWO_PI * 0.25f) {
// 			// 	rect (x, y, 40, -40);
// 			// } else if (theta > TWO_PI * 0.25f && theta <= TWO_PI * 0.5f) {
// 			// 	rect (x, y, 40, 40);
// 			// } else if (theta > TWO_PI * 0.5f && theta <= TWO_PI * 0.75f)  {
// 			// 	rect (x, y, -40, 40);
// 			// }else if (theta > TWO_PI * 0.75f && theta <= TWO_PI) {
// 			// 	rect (x, y, -40, -40);
// 			// }

// 			//need to get another set of points that will be bigger than the points i have now
// 			//use every second point to draw the trianglw from


// 			println(x + ", " + y + ", " + i + ", " + lastX + ", " + lastY);
// 	      	lastX = x;
// 	      	lastY = y; 
// 		}

// 		ellipseMode(RADIUS);
// 		fill(155, 111, 155);
// 		ellipse (cx, cy, radius, radius);
// 		ellipseMode(CENTER);
// 		fill(255);
// 		ellipse (cx, cy, radius, radius);
// 	}
// }
class DrawTrendGraph extends Draw
{

	DrawTrendGraph () 
	{
		super();
	}

	public void drawVis() 
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

	public void drawLine()
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
class GameData {

	float criticReviewScore;
	float userReviewScore;
	String gameName;
	String developerName;
	

	GameData () 
	{
		criticReviewScore = 0;
		userReviewScore = 0;
		gameName = "";
		developerName = "";
	};

	GameData (String line) 
	{
		String[] parts = line.split(",");

		criticReviewScore = Float.parseFloat(parts[0]);
		userReviewScore = Float.parseFloat(parts[1]);
		gameName = parts[2];
		developerName = parts[3];
	}

	
}

class Genre {
	int amount;
	String genre;

	Genre () 
	{
		amount = 0;
		genre = "";
	}

	Genre (String line) 
	{
		String[] s = line.split(",");
		amount = Integer.parseInt(s[0]);
		genre = s[1];
	}

	/*
	TODO: Make some sort of visualsation for the most popular genre of game 
	TODO: Read in the values of the most popular genre in the file PCGamesGenre.csv
	TODO: Maybe make an icon for each of the genres myself, gun for action

	*/
	

	public int sumGenre (ArrayList<Genre> gameGenre) 
	{
		int sum = 0;

		for (Genre g : gameGenre) 
		{
			sum += g.amount;
		}
		
		return sum;
	}
}
class GenreVis extends Draw //implements Icon
{

	float tempX;
	float tempY;
	float radius;

	public GenreVis() 
	{	
		super();	
		tempX = 0.0f;
		tempY = 0.0f;
		radius = border;	
	}

	public void drawVis() 
	{
		background(255);
		//TODO: Fix the title not being int the center
		//TODO: Make the Writing scale with a ratio
		//TODO: Make it colourful
		Genre genre = new Genre();
		// Draw draw = new Draw();
		int sum = genre.sumGenre(gameGenre);

		
		for(int i = 0 ; i < gameGenre.size() ; i ++)
		{
			tempY = (i + 1) * border;
			float stringWidth = textWidth(gameGenre.get(i).genre);
			if(i == 0)
			{
				fill(0);
				float titleWidth = textWidth("Game Genre Popularity");
				text("Game Genre Popularity" , ((width * 0.5f) - (titleWidth * 0.5f)), tempY);
			}
			else if(i % 2 == 0)
			{
				fill(0);
				text(gameGenre.get(i).genre, ((width * 0.5f) - (stringWidth * 0.5f)), tempY);
				text(gameGenre.get(i).amount, width - (border * 2.0f), tempY);
				fill(255);
				ellipse(width - (border * 2.0f), tempY, radius, radius);
				
			}
			else
			{
				fill(0);
				text(gameGenre.get(i).genre, ((width * 0.5f) - (stringWidth * 0.5f)), tempY);
				text(gameGenre.get(i).amount, border * 2.0f, tempY);
				fill(255);
				ellipse(border * 2.0f, tempY, radius, radius);
			}
		}
	}
}
class Menu extends Draw
{

	float menuX;
	float menuY;
	float menuBorder;
	float menuBorderDown;
	float halfBorder;
	int[] menuColours;
	PImage img;

	Menu() 
	{
		super();
		menuX = border;
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = (height * 0.5f) * 0.1f;
		halfBorder = menuBorder * 0.5f;
	}

	Menu(int corners, int sides, int buttons, int background, String filename) 
	{
		super();
		menuX = border;
		println("Border =" +border);
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = (height * 0.5f) * 0.1f;
		halfBorder = menuBorderDown * 0.5f;
		menuColours = new int[4];
		menuColours[0] = corners;
		menuColours[1] = sides;
		menuColours[2] = buttons;
		menuColours[3] = background;
		img = loadImage(filename);
	}


	public void drawVis()
	{	
		// background(img);
		image(img, 0, 0, width, height);
		//Top portion
		fill(menuColours[0]);
		rect(0, 0, border, border + (border * 0.5f));
		rect(width - border, 0, border, border + (border * 0.5f));
		rect(0, height - (border + (border * 0.5f)), border, border + (border * 0.5f));
		rect(width - border, height - (border + (border * 0.5f)), border, border + (border * 0.5f));
		

		//Bottom portion
		fill(menuColours[1]);
		rect(border, 0, horRange, border);
		rect(border, height - border, horRange, border);

		//Memu Icons
		fill(255);
		stroke(0);


		//TODO: make all the boxes for the words
		//TODO: make them link to a vis when it is clicked
		//TODO: Make it link to a vis when a button is pressed
		//TODO: Deside on the colours for the menu

		
		fill(menuColours[3]);
		rect(menuX + (menuBorder * 2.0f), menuY + menuBorderDown, menuBorder * 6.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + (menuBorder * 3.0f), menuY + (menuBorderDown * 8.0f), menuBorder * 4.0f, menuBorderDown);

		fill(0);
		// textAlign(CENTER);
		textSize(18);
		textWidth = textWidth("Top 50 PC Games of all Time");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of all Time", (menuX + (menuBorder * 5.0f)) - textOffset, menuY + ((menuBorderDown * 2.0f) - (halfBorder * 0.5f)));

		
		textSize(12);
		textWidth = textWidth("1. Review Barchart");
		textOffset = textWidth * 0.5f;
		text("1 .Review Barchart", (menuX + (menuBorder * 2.5f)) - textOffset, (menuY + (menuBorderDown * 4.0f) - (halfBorder * 0.5f)));
		textWidth = textWidth("2. Review Trend Graph");
		textOffset = textWidth * 0.5f;
		text("2 .Review Trend Graph", (menuX + (menuBorder * 7.5f)) - textOffset, (menuY + (menuBorderDown * 4.0f) - (halfBorder * 0.5f)));

		textWidth = textWidth("3 .Developer Area Graph");
		textOffset = textWidth * 0.5f;
		text("3. Developer Area Graph", (menuX + (menuBorder * 2.5f)) - textOffset, (menuY + (menuBorderDown * 7.0f) - (halfBorder * 0.5f)));
		textWidth = textWidth("4. Genre Info Graphic");
		textOffset = textWidth * 0.5f;
		text("4. Genre Info Graphic", (menuX + (menuBorder * 7.5f)) - textOffset, (menuY + (menuBorderDown * 7.0f) - (halfBorder * 0.5f)));

		textWidth = textWidth("C14339246 | Niall O'Donnell");
		textOffset = textWidth * 0.5f;
		text("C14339246 | Niall O'Donnell", (menuX + (menuBorder * 5.0f)) - textOffset, (menuY + (menuBorderDown * 9.0f) - (halfBorder * 0.5f)));

	}

	

}
class OOPAssignmentUtils 
{

	public OOPAssignmentUtils() {}

	//put all the populate the functions here
	public ArrayList<Genre> populateGenre() 
	{

		ArrayList<Genre> genre = new ArrayList<Genre>();
		String[] lines = loadStrings("PCGamesGenre.csv");

		for (String s : lines) 
		{
			Genre values = new Genre(s);
			genre.add(values);
		}

		return genre;
	}

	public ArrayList<GameData> populate() 
	{
		ArrayList<GameData> gameInfo = new ArrayList<GameData>();

		String[] arr = loadStrings("PCGames.csv");

		for (String s : arr) 
		{
			GameData data = new GameData(s);
			gameInfo.add(data);
		}

		return gameInfo;
	}

	public ArrayList<Developer> populateDeveloper() 
	{
		String[] values = loadStrings("PCGameDevs.csv");
		ArrayList<Developer> devs = new ArrayList<Developer>();

		for (String s : values) 
		{
			Developer dev = new Developer(s);
			devs.add(dev);
		}

		return devs;
	}
}
  public void settings() { 	size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Assignment" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
