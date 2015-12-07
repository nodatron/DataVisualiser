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

void setup() 
{
	size(600, 600);
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

void draw()
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

