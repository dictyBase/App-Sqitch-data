
use strict;
use warnings;

use Module::Build 0.4005;

my %module_build_args = (

    "build_requires"     => { "Module::Build" => "0.4005" },
    "configure_requires" => { "Module::Build" => "0.4005" },
    "dist_abstract" =>
        "App-Sqitch extended commands for loading and dumping data",
    "dist_name"    => "App-Sqitch-Command-data",
    "dist_author"  => "Yogesh Pandit",
    "dist_version" => "0.0.1",
    "license"      => "perl",
    "module_name"  => "App::Sqitch::Command::data",
    "requires"     => {
        "App::Sqitch" => "0.972",
        "DBD::Pg"     => "2.19.3",
        "DBD::SQLite" => "1.39"
    }
);

my $build = Module::Build->new(%module_build_args);
$build->create_build_script;
