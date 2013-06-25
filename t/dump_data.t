
package Test::dump_data;

use IPC::Cmd qw[can_run];
use lib 't/lib';
use MyTest::Common;
use Test::Exception;
use Test::File;
use Test::More qw/no_plan/;

my ( $class, $root, $sqitch ) = MyTest::Common->setup;

SKIP: {
    skip 'cp/pg_dump NOT found in PATH',
        if ( !can_run('cp') or !can_run('pg_dump') );

    isa_ok my $dump_data
        = $class->new( sqitch => $sqitch, command => 'dump_data' ),
        $class;
    $dump_data->data_dir( $root->subdir('data')->stringify );

    lives_ok { $dump_data->execute } 'dump data for current change';
    file_exists_ok( $dump_data->data_dir
            . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" );
};

MyTest::Common->teardown;
