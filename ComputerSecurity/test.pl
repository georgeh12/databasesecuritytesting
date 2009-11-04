	use DBI;
	
	###Create Table###
	
	# Connect to the database.
	$dbh = DBI->connect("dbi:mysql:database=test;host=localhost", "root", "password") ||
  	die "Got error $DBI::errstr when connecting to $dbh\n";
	
	
	# Drop table 'foo'. This may fail, if 'foo' doesn't exist.
	# Thus we put an eval around it.
	eval { $dbh->do("DROP TABLE foo") };
	print "Dropping foo failed: $@\n" if $@;
	
	# Create a new table 'foo'. This must not fail, thus we don't
	# catch errors.
	$dbh->do("CREATE TABLE foo (user VARCHAR(20), pass VARCHAR(20), data INTEGER)");
	
	# add values
	$dbh->do("INSERT INTO foo VALUES (?, ?, ?)", undef, "george", "gpass", 1);
	$dbh->do("INSERT INTO foo VALUES (?, ?, ?)", undef, "bob", "bpass", 2);
	
	### INSERT some data into 'foo'###
	
	#We are using $dbh->quote() for quoting the name.
	$dbh->do("INSERT INTO foo VALUES (1, " . $dbh->quote("Tim") . ")");
	
	# Same thing, but using placeholders
	$dbh->do("INSERT INTO foo VALUES (?, ?)", undef, 2, "Jochen");
	
	
	###SQL Injectable Code###
	
	print "Enter a value for unsecured SQL code: ";
	$target = <>;
	$sql = "select * from foo where user = $target";
	$sth = $dbh->prepare( $sql );
	$sth->execute;
	while (my $ref = $sth->fetchrow_arrayref()) {
		print "Found a row: user = $ref->[0], pass = $ref->[1]\n";
	}
	
	
	###Secured SQL Code###
	
	print "Enter a value for secured SQL code: ";
	$target = <>;
	$sql = "select * from foo where id = ?";
	$sth = $dbh->prepare( $sql );
	$sth->execute( $target );
	while (my $ref = $sth->fetchrow_arrayref()) {
		print "Found a row: user = $ref->[0], pass = $ref->[1]\n";
	}

	$sth->finish();
	
	# Disconnect from the database.
	$dbh->disconnect();
	