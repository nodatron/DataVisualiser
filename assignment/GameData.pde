// Class to hold the data for each game
class GameData {

	float criticReviewScore;
	float userReviewScore;
	String gameName;
	String developerName;
	

	GameData () 
	{
		criticReviewScore = 0;
		userReviewScore = 0;
		gameName = "";
		developerName = "";
	}

	GameData (String line) 
	{
		String[] parts = line.split(",");

		criticReviewScore = Float.parseFloat(parts[0]);
		userReviewScore = Float.parseFloat(parts[1]);
		gameName = parts[2];
		developerName = parts[3];
	}

	
}

