	use DBI;
	
	
	### Connect to the database###
	$dbh = DBI->connect("dbi:mysql:database=test;host=localhost", "root", "password") ||
  	die "Got error $DBI::errstr when connecting to $dbh\n";
	
	
	###Check for user args###
	
	eval { $user = $ARGV[0]} ||
	die "No user found. Correct usage: login.pl <user> <pass>\n";
	eval { $pass = $ARGV[1]} ||
	die "No pass found. Correct usage: login.pl <user> <pass>\n";
	
	###SQL Injectable Code###
	
	$sql = "SELECT user, data FROM mytable WHERE user = ? AND pass = ?";
	$sth = $dbh->prepare($sql);
	$sth->execute($user, $pass);
	
	printf "%10s%10s\n", "User", "Data";
	while (my $ref = $sth->fetchrow_arrayref()) {
		printf "%10s%10s\n", $ref->[0], $ref->[1];
	}

	###Clean up###
	
	$sth->finish();
	
	# Disconnect from the database.
	$dbh->disconnect();
	