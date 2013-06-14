requires "App::Sqitch";
requires "DBD::Pg";
requires "DBD::SQLite";

on development => sub {
	requires 'Dist::Zilla', 4.300034;
};

on test => sub {
	requires 'Test::Dir';
	requires 'Test::Exception', 0.32;
};
