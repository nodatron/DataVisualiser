// Class to hold data about the Genres
class Genre 
{
	int amount;
	String genre;

	Genre() 
	{
		amount = 0;
		genre = "";
	}

	Genre(String line) 
	{
		String[] s = line.split(",");
		amount = Integer.parseInt(s[0]);
		genre = s[1];
	}

	// Calculates the sum of all genres
	int sumGenre() 
	{
		int sum = 0;

		for(Genre g : gameGenre) 
		{
			sum += g.amount;
		}
		
		return sum;
	}
}