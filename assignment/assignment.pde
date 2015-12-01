//Please Note parts of this project will only work in processing 3

ArrayList<Draw> draw = new ArrayList<Draw>();
ArrayList<GameData> games = new ArrayList<GameData> ();
ArrayList<Genre> gameGenre = new ArrayList<Genre> ();
ArrayList<Developer> devs = new ArrayList<Developer> ();
Menu m;

void setup() 
{
	size(800, 800);
	background(255);

	m = new Menu();
	Menu menu = new Menu();
	draw.add(menu);
	DrawBarChart barChart = new DrawBarChart();
	draw.add(barChart);
	DrawTrendGraph trendGraph = new DrawTrendGraph();
	draw.add(trendGraph);
	DrawAreaGraph areaGraph = new DrawAreaGraph();
	draw.add(areaGraph);


	// Draw draw = new Draw ();
	OOPAssignmentUtils util = new OOPAssignmentUtils();

	
	games = util.populate();	
	gameGenre = util.populateGenre();	
	devs = util.populateDeveloper();

}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

boolean isMenu = true;



void mousePressed()
{
	println("In function");
	//top button
	if((mouseX >= (m.menuX + (m.menuBorder * 2.0f))) && (mouseX <= (m.menuX + (m.menuBorder * 9.0f))) && 
	   (mouseY >= (m.menuY + m.menuBorderDown)) && (mouseY <= (m.menuY + (m.menuBorderDown * 3.0f))))
	{
		background(255);
		draw.get(0).drawVis();
		isMenu = true;
		println("menu");
	}
	//
	if((mouseX > (m.menuX + m.menuBorder)) && (mouseX < (m.menuX + (m.menuBorder * 4.0f))) && 
	   (mouseY > (m.menuY + (m.menuBorderDown * 3.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 4.0f))))
	{
		background(255);
		draw.get(1).drawVis();
		isMenu = false;
		println("g1");
	}
	//
	if((mouseX > (m.menuX + (m.menuBorder * 6.0f))) && (mouseX < (m.menuX + (m.menuBorder * 9.0f))) &&
	   (mouseY > (m.menuY + (m.menuBorderDown * 3.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 4.0f))))
	{
		background(255);
		draw.get(2).drawVis();	
		isMenu = false;
		println("g2");
	}
	//
	if((mouseX > (m.menuX + m.menuBorder)) && ((mouseX < (m.menuX + (m.menuBorder * 4.0f)))) &&
	   ((mouseY > (m.menuY + (m.menuBorderDown * 6.0f)))) && ((mouseY < (m.menuY + (m.menuBorderDown * 7.0f))))) 
	{
		background(255);
		draw.get(3).drawVis();
		isMenu = false;
		println("g3");
	}
	//
	if((mouseX > (m.menuX + (m.menuBorder * 6.0f))) && (mouseX < (m.menuX + (m.menuBorder * 9.0f))) &&
	   (mouseY > (m.menuY + (m.menuBorderDown * 6.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 7.0f))))
	{
		background(255);
		draw.get(2).drawVis();
		isMenu = false;
		println("g4");
	}
	//
	if((mouseX > (m.menuX + (m.menuBorder * 3.0f))) && (mouseX < (m.menuX + (m.menuBorder * 7.0f))) &&
	   (mouseY > (m.menuY + (m.menuBorderDown * 8.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 9.0f))))
	{
		background(255);
		draw.get(2).drawVis();
		isMenu = false;
		println("g5");
	}
}


void draw()
{
	// background(255);
	// draw.get(3).drawVis();
	if(isMenu)
		draw.get(0).drawVis();
	
}