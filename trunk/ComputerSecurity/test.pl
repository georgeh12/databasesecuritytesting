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
	
	###SQL Injectable Code###
	
	print "Enter a value for unsecured SQL code: ";
	$target = <>;
	$sql = "select * from foo where user = $target";
	$sth = $dbh->prepare( $sql );
	$sth->execute;
	while (my $ref = $sth->fetchrow_arrayref()) {
		print "Found a row: user = $ref->[0], pass = $ref->[1]\n";
	}
	
	$pass = <>;
	$user = <>;
	$sth = $dbh->prepare("SELECT COUNT(id) FROM users WHERE username = '$user' AND password ='$pass'");
	$sth->execute();
	$sth->bind_columns(\($count));
	while ($sth->fetch) {
		printf "%s\n", $count;
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

<< '*/';
	$cols = ( foo => 'foo', bar => 'bar', baz => 'baz' );
	$tbls = ( parts => 'parts', table2 => 'table2' );

	$inp_col = <>;  # get data from untrusted sources
	$inp_tbl = $ENV{TABLE};

	if ( exists( $cols{$inp_col} ) and exists( $tbls{$inp_tbl} ) {
		$sql = "select $cols{$inp_col} from $tbls{$inp_tbl}";
   		# now it's safe to run the query...
	}
	
	
	### INSERT some data into 'foo'###
	#We are using $dbh->quote() for quoting the name.
	$dbh->do("INSERT INTO foo VALUES (1, " . $dbh->quote("Tim") . ")");
	
	# Same thing, but using placeholders
	$dbh->do("INSERT INTO foo VALUES (?, ?)", undef, 2, "Jochen");
	
	###START TEST PROGRAM###
	# Now retrieve data from the table.
	my $sth = $dbh->prepare("SELECT id, name FROM foo");
	$sth->execute();
	while (my $ref = $sth->fetchrow_arrayref()) {
		print "Found a row: id = $ref->[0], name = $ref->[1]\n";
	}
	$sth->finish();
	
	# Disconnect from the database.
	$dbh->disconnect();
*/
	