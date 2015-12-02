class OOPAssignmentUtils 
{

	public OOPAssignmentUtils() {}

	//put all the populate the functions here
	ArrayList<Genre> populateGenre() 
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

	ArrayList<GameData> populate() 
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

	ArrayList<Developer> populateDeveloper() 
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

	void updateMenu()
	{
		if(isMenu)
		{
			draw.get(0).drawVis();
		}
		if(keys['0'])
		{
			isMenu = true;
			
		}
		if((mouseX > (m.menuX + m.menuBorder)) && (mouseX < (m.menuX + (m.menuBorder * 4.0f))) && 
		   (mouseY > (m.menuY + (m.menuBorderDown * 3.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 4.0f))))
		{
			draw.get(1).drawVis();
			isMenu = false;
			println("g1");
		}
		//
		if((mouseX > (m.menuX + (m.menuBorder * 6.0f))) && (mouseX < (m.menuX + (m.menuBorder * 9.0f))) &&
		   (mouseY > (m.menuY + (m.menuBorderDown * 3.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 4.0f))))
		{
			draw.get(2).drawVis();	
			isMenu = false;
			println("g2");
		}
		//
		if((mouseX > (m.menuX + m.menuBorder)) && ((mouseX < (m.menuX + (m.menuBorder * 4.0f)))) &&
		   ((mouseY > (m.menuY + (m.menuBorderDown * 6.0f)))) && ((mouseY < (m.menuY + (m.menuBorderDown * 7.0f))))) 
		{
			draw.get(3).drawVis();
			isMenu = false;
			println("g3");
		}
		//
		if((mouseX > (m.menuX + (m.menuBorder * 6.0f))) && (mouseX < (m.menuX + (m.menuBorder * 9.0f))) &&
		   (mouseY > (m.menuY + (m.menuBorderDown * 6.0f))) && (mouseY < (m.menuY + (m.menuBorderDown * 7.0f))))
		{
			draw.get(4).drawVis();
			isMenu = false;
			println("g4");
		}

	}
}