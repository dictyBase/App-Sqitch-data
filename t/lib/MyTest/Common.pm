
package MyTest::Common;

use App::Sqitch;
use App::Sqitch::Command::dump_data;
use FindBin qw($Bin);

sub setup {

    my $self = @_;

    $ENV{SQITCH_CONFIG}        = 'nonexistent.conf';
    $ENV{SQITCH_USER_CONFIG}   = 'nonexistent.user';
    $ENV{SQITCH_SYSTEM_CONFIG} = 'nonexistent.sys';

    my $class  = 'App::Sqitch::Command::dump_data';
    my $root   = Path::Class::Dir->new($Bin)->subdir('sql');
    my $sqitch = App::Sqitch->new(
        plan_file => $root->file('sqitch.plan'),
        top_dir   => $root,
        data_dir  => $root->subdir('data')->stringify,
        _engine   => 'sqlite',
        db_name   => $root->file('sql.db')->stringify
    );

    return ( $class, $root, $sqitch );
}

sub teardown {
    print "Tearing down\n";
}

1;
