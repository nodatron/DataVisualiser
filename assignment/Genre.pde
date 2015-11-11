class Genre {
	int amount;
	String genre;

	Genre () {
		amount = 0;
		genre = "";
	}

	Genre (String line) {
		String[] s = line.split(",");
		amount = Integer.parseInt(s[0]);
		genre = s[1];
	}

	/*
	TODO: Make some sort of visualsation for the most popular genre of game 
	TODO: Read in the values of the most popular genre in the file PCGamesGenre.csv
	TODO: Maybe make an icon for each of the genres myself, gun for action

	*/
	

	int sumGenre (ArrayList<Genre> gameGenre) {
		int sum = 0;

		for (Genre g : gameGenre) {
			sum += g.amount;
		}
		
		return sum;
	}
}