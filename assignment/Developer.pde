class Developer {

	String name;
	int freq;
	float avgCriticScore;
	float avgUserScore;

	Developer () {
		name = "";
		freq = 0;
		avgCriticScore = 0;
		avgUserScore = 0;
	}

	Developer (String line) {
		name = line;
		freq = 0;
		avgCriticScore = 0;
		avgUserScore = 0;
	}

	void developerFrequency() 
	{
		for (int i = 0 ; i < games.size () ; i ++) 
		{
			for (int j = 0 ; j < devs.size () ; j ++) 
			{
				if (games.get(i).developerName.equals(devs.get(j).name)) 
				{
					devs.get(j).freq ++;
				}
			}
		}
	}

	int findHighestFreq() 
	{
		int highest = 0;

		for (Developer d : devs) 
		{
			if (d.freq > highest) 
			{
				highest = d.freq;			
			}
		}

		return highest;
	}

	//gets the avg score for each developer
	void avgDevScore(String devName, int pos)
	{
		int i = 0;
		float sumCritic = 0;
		float sumUser = 0;
		for(GameData gd : games)
		{
			if(gd.developerName.equals(devName))
			{
				i ++;
				sumCritic += gd.criticReviewScore;
				sumUser += gd.userReviewScore;
			}
		}

		devs.get(pos).avgCriticScore = sumCritic / (float) i;
		devs.get(pos).avgUserScore = sumUser / (float) i;
	}
}