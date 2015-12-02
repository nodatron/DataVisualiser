class Menu extends Draw
{

	float menuX;
	float menuY;
	float menuBorder;
	float menuBorderDown;
	float halfBorder;
	color[] menuColours;

	Menu() 
	{
		super();
		menuX = border;
		println("Border =" +border);
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = vertRange * 0.1f;
		halfBorder = menuBorder * 0.5f;
	}

	Menu(color corners, color sides, color buttons, color background) 
	{
		super();
		menuX = border;
		println("Border =" +border);
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = vertRange * 0.1f;
		halfBorder = menuBorder * 0.5f;
		menuColours = new color[4];
		menuColours[0] = corners;
		menuColours[1] = sides;
		menuColours[2] = buttons;
		menuColours[3] = background;
	}


	void drawVis()
	{	
		background(menuColours[3]);
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
		textSize(27);
		text("Top 50 PC Games of all Time", menuX + (menuBorder * 2.0f), menuY + ((menuBorder * 2.0f) - halfBorder));

		
		textSize(18);
		text("Review Barchart", menuX + menuBorder, (menuY + (menuBorder * 4.0f) - halfBorder));
		text("Review Trend Graph", menuX + (menuBorder * 6.0f), (menuY + (menuBorder * 4.0f) - halfBorder));
		text("Developer Area Graph", menuX + menuBorder, (menuY + (menuBorder * 7.0f) - halfBorder));
		text("Genre Info Graphic", menuX + (menuBorder * 6.0f), (menuY + (menuBorder * 7.0f) - halfBorder));
		text("C14339246 | Niall O'Donnell", menuX + (menuBorder * 3.0f), (menuY + (menuBorderDown * 9.0f) - halfBorder));

	}

	

}