
Steps for testing custom commands for `App::Sqitch`

- [ ] Create a static config file with all required config.
	* For a new `sqitch` object, pass this as config.
- [ ] Create a `sqlite3` db with pre-loaded changes. Configure it in the above mentioned config file
- [ ] Automate test for `pg` engine for the same changes


* __Points to consider__
   - [ ] No False positive tests.
   - [ ] Setup & teardown
   - [ ] Check if loads in database
   - [ ] Skip test if systems exec do not exist || croak
   - [ ] Use module called IPC::Command for binaries
   - [ ] qw/no_plan
   - [ ] No BEGIN & END. Use subroutines
   - [ ] Use SKIP block
