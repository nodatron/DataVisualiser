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

	
}