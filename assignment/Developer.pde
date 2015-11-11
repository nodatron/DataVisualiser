class Developer {
	String name;
	int freq;

	Developer () {
		name = "";
		freq = 0;
	}

	Developer (String line) {
			name = line;
			freq = 0;
	}

	/*
		Find the most popular dev updated
			-compare the values in ArrayList<GameData> with the dev name in ArrayList<Developer>
			-add 1 to the freq variable if it is a match
			-do a wordle for to show the most popular developer
	*/
	

	ArrayList<Developer> developerFrequency (ArrayList<GameData> gameInfo,
								  ArrayList<Developer> devs) {
		for (int i = 0 ; i < gameInfo.size () ; i ++) {
			for (int j = 0 ; j < devs.size () ; j ++) {
				if (gameInfo.get(i).developerName.equals (devs.get(j).name)) {
					devs.get(j).freq ++;
				}
			}
		}

		return devs;
	}

	int findMostFreqDeveloper (ArrayList<Developer> devs) {
		int maxIndex = 0;

		for (int i = 0 ; i < devs.size () ; i ++) {
			if (devs.get(i).freq > devs.get(maxIndex).freq) {
				maxIndex = i;
			}
		}

		return maxIndex;
	}
}