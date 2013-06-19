
use strict;

use App::Sqitch;
use File::Spec;
use FindBin qw($Bin);
use Path::Class qw(dir file);
use Test::Dir;
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

diag($Bin);
ok my $sqitch = App::Sqitch->new(
    plan_file => file(qw(sql sqitch.plan)),
    top_dir   => dir(qw(sql)),
    data_dir  => dir(qw(sql data)),
    _engine   => 'sqlite',
    db_name   => File::Spec->catfile( 'sql', 'sql.db' ),

    sqitch_db => File::Spec->catfile( 'sql', 'sql-sqitch.db' )
    ),
    'Load a sqitch object';

my $config = $sqitch->config;
diag( $config->{data_dir} );

#is_deeply $CLASS->configure(
##    $config,
#{   data_dir => dir(qw(t sql data)),
#db_name  => File::Spec->catfile( 't', 'sql', 'sql.db' )
#}
#),
#{
#data_dir => dir(qw(t sql data)),
#db_name  => File::Spec->catfile( 't', 'sql', 'sql.db' )
#},
#'Should have mode, verify, set, and log-only options';

#$CLASS->configure( $config, { confname => file(qw(t sql sqitch.conf)) } );

#isa_ok my $dump_data = App::Sqitch::Command->load(
#{   sqitch  => $sqitch,
#command => 'dump_data',
#config  => $config,
#}
#),
#$CLASS, 'dump_data command';

isa_ok my $dump_data
    = $CLASS->new( sqitch => $sqitch, command => 'dump_data' ), $CLASS;

#diag( $dump_data->{db_name} );

# dir_not_exists_ok +File::Spec->catdir( 't', 'data' );
# $dump_data->data_dir('t/sql/data');
lives_ok { $dump_data->execute } 'dump data for current change';
