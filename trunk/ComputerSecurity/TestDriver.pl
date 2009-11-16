	use DBI;
	
	
	###Create Table###
	
	# Connect to the database.
	$dbh = DBI->connect("dbi:mysql:database=test;host=localhost", "root", "password") ||
  	die "Got error $DBI::errstr when connecting to $dbh\n";
	
	# Drop table 'mytable'. This may fail, if 'mytable' doesn't exist.
	# Thus we put an eval around it.
	eval { $dbh->do("DROP TABLE mytable") };
	
	# Create a new table 'mytable'.
	$tableargs = "CREATE TABLE mytable (user VARCHAR(20), pass VARCHAR(20), data INTEGER)";
	printf ("Creating a new table: %s\n", $tableargs);
	$dbh->do($tableargs);
	
	print "\n";
	
	# Add two data entries
	$table_entry1 = "INSERT INTO mytable VALUES ('george', 'gpass', 1)";
	$table_entry2 = "INSERT INTO mytable VALUES ('bob', 'bpass', 2)";
	printf ("Adding a new entry: %s\n", $table_entry1);
	$dbh->do($table_entry1);
	printf ("Adding a new entry: %s\n", $table_entry2);
	$dbh->do($table_entry2);
	
	print "\n\n";
	
	
	###Testing###
	
	$command = "perl";
	
	#Testing InsecureLogin.pl with valid input
	$arg0 = "SecureLogin.pl";
	$arg1 = "george";
	$arg2 = "gpass";
	printf "Running InsecureLogin.pl with valid input: %s %s %s %s\n", $command, $arg0, $arg1, $arg2;
	system($command, $arg0, $arg1, $arg2);
	
	print "\n";
	
	#Testing InsecureLogin.pl with invalid input
	$arg0 = "InsecureLogin.pl";
	$arg1 = "george";
	$arg2 = "null' OR '1'='1";
	printf "Running InsecureLogin.pl with invalid input: %s %s %s %s\n", $command, $arg0, $arg1, $arg2;
	system($command, $arg0, $arg1, $arg2);
	
	print "\n";
	
	#Testing SecureLogin.pl with valid input
	$arg0 = "SecureLogin.pl";
	$arg1 = "george";
	$arg2 = "gpass";
	printf "Running SecureLogin.pl with valid input: %s %s %s %s\n", $command, $arg0, $arg1, $arg2;
	system($command, $arg0, $arg1, $arg2);
	
	print "\n";
	
	#Testing SecureLogin.pl with invalid input
	$arg0 = "SecureLogin.pl";
	$arg1 = "george";
	$arg2 = "null' OR '1'='1";
	printf "Running SecureLogin.pl with invalid input: %s %s %s %s\n", $command, $arg0, $arg1, $arg2;
	system($command, $arg0, $arg1, $arg2);
	