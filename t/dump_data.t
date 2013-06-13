
use strict;

use App::Sqitch;
use Path::Class;
use Test::Dir;
use Test::Exception;
use Test::More qw/no_plan/;

my $CLASS = 'App::Sqitch::Command::dump_data';

ok my $sqitch = App::Sqitch->new( top_dir => Path::Class::Dir->new('t'), ),
    'Load a sqitch sqitch object';

my $config = $sqitch->config;

isa_ok my $dump_data = App::Sqitch::Command->load(
    {   sqitch  => $sqitch,
        command => 'dump_data',
        config  => $config,
    }
    ),
    $CLASS, 'dump_data command';

dir_not_exists_ok +File::Spec->catdir( 't', 'data' );
can_ok( $dump_data, 'execute' );
lives_ok { $dump_data->execute } 'dump data for current change';
