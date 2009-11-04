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
	
	###SQL Injectable Code###
	
	$user = <>;
	$pass = <>;
	$sql = "SELECT COUNT(user) FROM foo WHERE user = '$user' AND pass = '$pass'";
	$sth = $dbh->prepare($sql);
	$sth->execute();
	$sth->bind_columns(\($count));
	while ($sth->fetch) {
		printf "%s\n", $count;
	}
	