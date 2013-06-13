
use strict;

use App::Sqitch;
use Path::Class;
use Test::More qw/no_plan/;

my $CLASS = 'App::Sqitch::Command::load_data';

ok my $sqitch = App::Sqitch->new( top_dir => Path::Class::Dir->new('sql'), ),
    'Load a sqitch sqitch object';

my $config = $sqitch->config;

isa_ok my $load_data = App::Sqitch::Command->load(
    {   sqitch  => $sqitch,
        command => 'load_data',
        config  => $config,
    }
    ),
    $CLASS, 'load_data command';
