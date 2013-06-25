
use strict;

use App::Sqitch;
use FindBin qw($Bin);
use IPC::Cmd qw[can_run];
use Path::Class qw(dir file);
use Test::Exception;
use Test::File;
use Test::More;

my ( $class, $root );

BEGIN {
    if ( !can_run('cp') ) {
        plan skip_all => 'cp NOT found in PATH';
    }

    $class = 'App::Sqitch::Command::load_data';
    require_ok $class or die;

    $ENV{SQITCH_CONFIG}        = 'nonexistent.conf';
    $ENV{SQITCH_USER_CONFIG}   = 'nonexistent.user';
    $ENV{SQITCH_SYSTEM_CONFIG} = 'nonexistent.sys';

    $root = Path::Class::Dir->new($Bin)->subdir('sql');
}

my $sqitch = App::Sqitch->new(
    plan_file => $root->file('sqitch.plan'),
    top_dir   => $root,
    data_dir  => $root->subdir('data')->stringify,
    _engine   => 'sqlite',
    db_name   => $root->file('sql.db')->stringify
);

isa_ok my $load_data
    = $class->new( sqitch => $sqitch, command => 'load_data' ), $class;
$load_data->data_dir( $root->subdir('data')->stringify );

if ( -e $load_data->data_dir
    . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" )
{
    lives_ok { $load_data->execute } 'load data for current change';
}
else {
    my $dump_data = $class->new( sqitch => $sqitch, command => 'dump_data' );
    $dump_data->data_dir( $root->subdir('data')->stringify );
    $dump_data->execute;
    lives_ok { $load_data->execute } 'load data for current change';
}
file_exists_ok(
    $load_data->data_dir . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" );

END {
    unlink( $load_data->data_dir
            . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" );
}

done_testing();
