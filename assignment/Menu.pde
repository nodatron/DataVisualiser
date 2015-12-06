class Menu extends Draw
{

	float menuX;
	float menuY;
	float menuBorder;
	float menuBorderDown;
	float halfBorder;
	float textWidth;
	float textOffset;
	color[] menuColours;
	PImage img;

	Menu() 
	{
		super();
		menuX = border;
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = (height * 0.5f) * 0.1f;
		halfBorder = menuBorder * 0.5f;
		textWidth = 0;
		textOffset = 0;
	}

	Menu(color corners, color sides, color buttons, color background, String filename) 
	{
		super();
		menuX = border;
		println("Border =" +border);
		menuY = border;
		menuBorder = horRange * 0.1f;
		menuBorderDown = (height * 0.5f) * 0.1f;
		halfBorder = menuBorderDown * 0.5f;
		textWidth = 0;
		textOffset = 0;
		menuColours = new color[4];
		menuColours[0] = corners;
		menuColours[1] = sides;
		menuColours[2] = buttons;
		menuColours[3] = background;
		img = loadImage(filename);
	}


	void drawVis()
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
		textSize(27);
		textWidth = textWidth("Top 50 PC Games of all Time");
		textOffset = textWidth * 0.5f;
		text("Top 50 PC Games of all Time", (menuX + (menuBorder * 5.0f)) - textOffset, menuY + ((menuBorderDown * 2.0f) - (halfBorder * 0.5f)));

		
		textSize(16);
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