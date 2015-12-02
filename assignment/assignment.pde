//Please Note parts of this project will only work in processing 3

ArrayList<Draw> draw = new ArrayList<Draw>();
ArrayList<GameData> games = new ArrayList<GameData> ();
ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
ArrayList<Developer> devs = new ArrayList<Developer> ();
OOPAssignmentUtils util = new OOPAssignmentUtils();
Menu m;

void setup() 
{
	size(800, 800);
	background(255);

	m = new Menu(color(153, 255, 204), color(0, 204, 0), color(102, 204, 204), color(51, 204, 255));
	// Menu menu = new Menu();
	draw.add(m);
	DrawBarChart barChart = new DrawBarChart();
	draw.add(barChart);
	DrawTrendGraph trendGraph = new DrawTrendGraph();
	draw.add(trendGraph);
	DrawAreaGraph areaGraph = new DrawAreaGraph();
	draw.add(areaGraph);
	GenreVis genreVis = new GenreVis();
	draw.add(genreVis);


	// Draw draw = new Draw ();
	

	
	games = util.populate();	
	gameGenre = util.populateGenre();	
	devs = util.populateDeveloper();

	Developer dev = new Developer();
	dev.developerFrequency();
	int highest = dev.findHighestFreq();
	for(int i = 0 ; i < devs.size() ; i ++)
	{
		dev.avgDevScore(devs.get(i).name, i);
	}

	draw.get(0).drawVis();

}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
  // util.updateMenu();
  util.updateMenu();
}

boolean isMenu = true;



void mousePressed()
{
	util.updateMenu();
}


void draw()
{
	
}