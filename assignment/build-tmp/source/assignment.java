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

// Data from http://www.metacritic.com/browse/games/score/metascore/all/pc/filtered?sort=desc
// Only taking the top 50 games from the list as of 25/10/2015

//Holds list of visualisations
ArrayList<Draw> draw = new ArrayList<Draw>();
//Hold the data from the files
ArrayList<GameData> games = new ArrayList<GameData> ();
ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
ArrayList<Developer> devs = new ArrayList<Developer> ();

//using these to call functions
OOPAssignmentUtils util = new OOPAssignmentUtils();
Menu menu;

boolean isMenu = true;
boolean[] vis = new boolean[4];

public void setup() 
{
	
	background(255);

    //adding the visualisations to the arraylist
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

	//populating the arraylists with data from the files
	games = util.populate();	
	gameGenre = util.populateGenre();	
	devs = util.populateDeveloper();

	Developer dev = new Developer();
	dev.developerFrequency();
	for(int i = 0 ; i < devs.size() ; i ++)
	{
		dev.avgDevScore(devs.get(i).name, i);
	}

    //initially drawing the menu
	draw.get(0).drawVis();

}

public void draw()
{
    //Controls for the menu

    //need to do it this way because it needs to update all the time
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

	//adds the freq to the dev arraylist
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

	//finds the highest frequency
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

	//gets the average critic/user review score for each developer
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
//Base class for all the drawing
abstract class Draw 
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

	public abstract void drawVis();
	
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
		//used to call functions
		Developer dev = new Developer();
		highest = dev.findHighestFreq();

		//key for the graph
		textSize(12);
		fill(0);
		text("Critic Review", 0, height * 0.035f);
		fill(0, 255, 0);
		fill(0, 255, 0);
		text("User Review", 0, height * 0.075f);
		
		//Top part of vis
		//Drawing the trend lines
		for (int i = 1; i < devs.size(); ++i) 
		{
			//Critic Trend points
			float x1 = (float) map(i - 1, 0, devs.size() - 1, border, width - border);
			float y1 = (float) map(devs.get(i - 1).avgCriticScore, 0, 100, height * 0.5f, border);
			float x2 = (float) map(i, 0, (float) devs.size() - 1, border, width - border);
			float y2 = (float) map(devs.get(i).avgCriticScore, 0, 100, height * 0.5f, border);

			//User trend points
			float y3 = map(devs.get (i - 1).avgUserScore, 0, 100, height * 0.5f, border);
			float y4 = map(devs.get(i).avgUserScore, 0, 100, height * 0.5f, border);

			stroke (0);
			line (x1, y1, x2, y2);
			stroke (0, 255, 0);
			line(x1, y3, x2, y4);

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
			float x1 = map((float) i, 0, devs.size() - 1, border, width - border);
			float x2 = map((float) i - 1, 0, devs.size() - 1, border, width - border);
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

		    //changing which side of the line the text prints on so it remains readable
		    if(mouseX < width * 0.5f)
		    {
			    text("Developer: " + devs.get(i).name, mouseX + 10, vertRange * 0.5f);
			    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX + 10, (vertRange * 0.5f) + 10);
			    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX + 10, (vertRange * 0.5f) + 20);
			    text("Number of Games: " + devs.get(i).freq, mouseX + 10, (vertRange * 0.5f) + 30);
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
				    text("Number of Games: " + devs.get(i).freq, mouseX - 150, (vertRange * 0.5f) + 30);
				}
				else
				{
					text("Developer: " + devs.get(i).name, mouseX - (textWidth + 10), vertRange * 0.5f);
				    text("Avg Critic Score: " + devs.get(i).avgCriticScore, mouseX - (textWidth + 10), (vertRange * 0.5f) + 10);
				    text("Avg User Score: " + devs.get(i).avgUserScore, mouseX - (textWidth + 10), (vertRange * 0.5f) + 20);
				    text("Number of Games: " + devs.get(i).freq, mouseX - (textWidth + 10), (vertRange * 0.5f) + 30);
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

	//Draw a bar sideways barchart
	public void drawVis() 
	{
		background(255);
		float barWidth = vertRange / games.size();
		float y = height - border - barWidth; // -barWidth because it draws down from the x, y points

		//drawing the axis
		line(border, height - border, border, border);
		line(border, height - border, width - border, height - border);

		//drawing the bars
		textSize(10);
		for(int i = 0 ; i < games.size() ; i ++) 
		{
			fill(255, 0, 0);
			rect(border, y, map (games.get(i).criticReviewScore, 0, 100, border, horRange), barWidth);
			fill(0, 255, 0);
			rect(border, y, map (games.get(i).userReviewScore, 0, 100, border, horRange), barWidth);

			//labelling the y axis with the names of the games
			fill(0);
			text(games.get(i).gameName, border * 1.2f, y + (barWidth * 0.9f));
			y -= barWidth;
		}

		//Drawing a key for the graph
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

		//title of the graph
		fill(0);
		textSize(16);
		textWidth = textWidth("Top 50 PC Games of All Time Critic and User Review Scores");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of All Time Critic and User Scores", (width * 0.6f) - textOffset, border * 0.5f);

		//labelling the xaxis
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
class DrawTrendGraph extends Draw
{

	DrawTrendGraph () 
	{
		super();
	}

	public void drawVis() 
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
// Class to hold the data for each game
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
	}

	GameData (String line) 
	{
		String[] parts = line.split(",");

		criticReviewScore = Float.parseFloat(parts[0]);
		userReviewScore = Float.parseFloat(parts[1]);
		gameName = parts[2];
		developerName = parts[3];
	}

	
}

// Class to hold data about the Genres
class Genre 
{
	int amount;
	String genre;

	Genre() 
	{
		amount = 0;
		genre = "";
	}

	Genre(String line) 
	{
		String[] s = line.split(",");
		amount = Integer.parseInt(s[0]);
		genre = s[1];
	}

	// Calculates the sum of all genres
	public int sumGenre() 
	{
		int sum = 0;

		for(Genre g : gameGenre) 
		{
			sum += g.amount;
		}
		
		return sum;
	}
}
class GenreVis extends Draw
{
	float tempX;
	float tempY;
	float radius;
	int sum;
	float ratio;
	int tsize;

	public GenreVis() 
	{	
		super();	
		tempX = 0.0f;
		tempY = 0.0f;
		radius = border;	
		sum = 0;
		ratio = 0;
		tsize = 26;
	}

	//draws the vis for the genres
	public void drawVis() 
	{
		background(0, 255, 255);
		//getting the sum of all the genres
		Genre genre = new Genre();
		sum = genre.sumGenre();
		
		//need to rescale the border so everything fits
		border = height * 0.09f;

		fill(0);
		//title of the vis
		textSize(36);
		textWidth = textWidth("Game Genre Popularity");
		textOffset = textWidth * 0.5f;
		text("Game Genre Popularity" , ((width * 0.5f) - textOffset), border);

		//draws the main part of the vis
		for(int i = 0 ; i < gameGenre.size() ; i ++)
		{
			//the y value text and shapes are drawn at
			tempY = (i + 2) * border;
			
			//ratio to scale everything by
			ratio = 2.0f * ((float) gameGenre.get(i).amount / sum);

			//swap between the circle drawn on the left or the right
			//most of the code here is just to make everything center correctly
			if(i % 2 == 0)
			{
				textSize(tsize + (tsize * ratio));

				fill(255);
				ellipse(width - (border * 2.0f), tempY , radius + (radius * ratio), radius + (radius * ratio));

				fill(0);
				textWidth = textWidth(gameGenre.get(i).genre);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).genre, ((width * 0.5f) - textOffset), tempY + 10);

				textWidth = textWidth("" + gameGenre.get(i).amount);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).amount, width - (border * 2.0f) - textOffset, tempY + 10);
			}
			else
			{
				textSize(tsize + (tsize * ratio));

				fill(255);
				ellipse(border * 2.0f, tempY, radius + (radius * ratio), radius + (radius * ratio));

				fill(0);
				textWidth = textWidth(gameGenre.get(i).genre);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).genre, ((width * 0.5f) - textOffset), tempY + 10);

				textWidth = textWidth("" + gameGenre.get(i).amount);
				textOffset = textWidth * 0.5f;
				text(gameGenre.get(i).amount, (border * 2.0f) - textOffset, tempY + 10);
				
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


	//draws the menu
	public void drawVis()
	{	
		//print the image
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

		//Buttons on the menu
		fill(255);
		stroke(0);
		
		fill(menuColours[3]);
		rect(menuX + (menuBorder * 2.0f), menuY + menuBorderDown, menuBorder * 6.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + (menuBorder * 3.0f), menuY + (menuBorderDown * 8.0f), menuBorder * 4.0f, menuBorderDown);

		fill(0);

		// Putting the text in the buttons
		// textWidth and textOffset are used to get the text centered
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
