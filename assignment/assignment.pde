//Please Note parts of this project will only work in processing 3

ArrayList<Draw> draw = new ArrayList<Draw>();
ArrayList<GameData> games = new ArrayList<GameData> ();
ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
ArrayList<Developer> devs = new ArrayList<Developer> ();

void setup() 
{
	size(1000, 800);
	background(255);

	
	DrawBarChart barChart = new DrawBarChart();
	draw.add(barChart);
	DrawTrendGraph trendGraph = new DrawTrendGraph();
	draw.add(trendGraph);


	// Draw draw = new Draw ();
	OOPAssignmentUtils util = new OOPAssignmentUtils();

	
	games = util.populate();	
	gameGenre = util.populateGenre();	
	devs = util.populateDeveloper();

	draw.get(0).drawVis();

	// draw.drawBarChart(games);
	// draw.drawDeveloperVisualization(games, devs);
	// draw.drawTrendGraph(games);
	// draw.drawGenreVisualization(gameGenre);
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void draw()
{
	// background(255);
	// if(keys[1])
	// {
	// 	draw.get(0).drawVis(games);
	// }
	// if(keys[2])
	// {
	// 	draw.get(1).drawVis(games);
	// }
}