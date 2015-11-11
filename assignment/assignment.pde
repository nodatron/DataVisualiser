//Please Note parts of this project will only work in processing 3

void setup () {
	size (1000, 800);
	background (255);

	Draw draw = new Draw ();
	OOPAssignmentUtils util = new OOPAssignmentUtils();

	ArrayList<GameData> games = new ArrayList<GameData> ();
	games = util.populate ();

	

	ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
	gameGenre = util.populateGenre();

	
	ArrayList<Developer> devs = new ArrayList<Developer> ();
	devs = util.populateDeveloper();


	

	// draw.drawBarChart(games);
	// draw.drawDeveloperVisualization(games, devs);
	// draw.drawTrendGraph(games);
	draw.drawGenreVisualization(gameGenre);
}