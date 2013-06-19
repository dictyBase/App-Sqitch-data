
Steps for testing custom commands for `App::Sqitch`
1. Create a static config file with all required config.
	* For a new `sqitch` object, pass this as config.
2. Create a `sqlite3` db with pre-loaded changes. Configure it in the above mentioned config file

Run the test using this config, for Step 1
