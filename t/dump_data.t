
use strict;

use App::Sqitch;
use FindBin qw($Bin);
use Path::Class qw(dir file);
use Test::Exception;
use Test::More qw/no_plan/;

my $CLASS = 'App::Sqitch::Command::dump_data';
require_ok $CLASS or die;

$ENV{SQITCH_CONFIG}        = 'nonexistent.conf';
$ENV{SQITCH_USER_CONFIG}   = 'nonexistent.user';
$ENV{SQITCH_SYSTEM_CONFIG} = 'nonexistent.sys';

isa_ok $CLASS, 'App::Sqitch::Command';
can_ok $CLASS, qw(
    options
    configure
    new
    execute
);

my $root = Path::Class::Dir->new($Bin)->subdir('sql');

ok my $sqitch = App::Sqitch->new(
    plan_file => $root->file('sqitch.plan'),
    top_dir   => $root,
    data_dir  => $root->subdir('data')->stringify,
    _engine   => 'sqlite',
    db_name   => $root->file('sql.db')->stringify
    ),
    'Load a sqitch object';

isa_ok my $dump_data
    = $CLASS->new( sqitch => $sqitch, command => 'dump_data' ), $CLASS;
$dump_data->data_dir( $root->subdir('data')->stringify );

lives_ok { $dump_data->execute } 'dump data for current change';
