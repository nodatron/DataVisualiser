class Menu extends Draw
{

	float menuX;
	float menuY;
	float menuBorder;
	float menuBorderDown;

	Menu() 
	{
		super();
		menuX = border;
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = vertRange * 0.1f;
	}


	void drawVis()
	{	
		//Top portion
		fill(127, 0, 0);
		rect(0, 0, border, border + (border * 0.5f));
		rect(width - border, 0, border, border + (border * 0.5f));
		fill(0, 0, 127);
		rect(border, 0, horRange, border);

		//Bottom portion
		fill(127, 0, 0);
		rect(0, height - (border + (border * 0.5f)), border, border + (border * 0.5f));
		rect(width - border, height - (border + (border * 0.5f)), border, border + (border * 0.5f));
		fill(0, 0, 127);
		rect(border, height - border, horRange, border);

		//Memu Icons
		fill(255);
		stroke(0);


		//TODO: make all the boxes for the words
		//TODO: make them link to a vis when it is clicked
		//TODO: Make it link to a vis when a button is pressed
		//TODO: Deside on the colours for the menu

		rect(menuX + (menuBorder * 2.0f), menuY + menuBorderDown, menuBorder * 6.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 3.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + menuBorder, menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);
		rect(menuX + (menuBorder * 6.0f), menuY + (menuBorderDown * 6.0f), menuBorder * 3.0f, menuBorderDown);

		rect(menuX + (menuBorder * 3.0f), menuY + (menuBorderDown * 8.0f), menuBorder * 4.0f, menuBorderDown);
	}

	void update()
	{
		//fix this later doesnt change the menu
		//Changes the vis being displayed on the screen
		if(mouseX > (menuX + menuBorder) && mouseX < (menuX + (menuBorder * 4.0f)) && 
		   mouseY > (menuY + menuBorderDown) && mouseY < (menuY + (menuBorderDown * 2.0f)))
		{
			draw.get(1).drawVis();
			isMenu = false;
		}
		if(mouseX > (menuX + (menuBorder * 6.0f)) && mouseX < (menuX + (menuBorder * 9.0f)) && 
		   mouseY > (menuY + menuBorderDown) && mouseY < (menuY + (menuBorderDown * 2.0f)))
		{
			draw.get(2).drawVis();
			isMenu = false;
		}
		if(mouseX > (menuX + menuBorder) && mouseX < (menuX + (menuBorder * 4.0f)) &&
		   mouseY > (menuY + (menuBorderDown * 6.0f)) && mouseY < (menuY + (menuBorderDown * 7.0f)))
		{
			draw.get(1).drawVis();	
			isMenu = false;
		}
		if(mouseX > (menuX + (menuBorder * 6.0f)) && mouseX < (menuX + (menuBorder * 9.0f)) &&
		   mouseY > (menuY + (menuBorderDown * 6.0f)) && mouseY < (menuY + (menuBorderDown * 7.0f))) 
		{
			draw.get(2).drawVis();
			isMenu = false;
		}
		if(mouseX > (menuX + (menuBorder * 6.0f)) && mouseX < (menuX + (menuBorder * 9.0f)) &&
		   mouseY > (menuY + (menuBorderDown * 6.0f)) && mouseY < (menuY + (menuBorderDown * 7.0f)))
		{
			draw.get(1).drawVis();
			isMenu = false;
		}
	}

}