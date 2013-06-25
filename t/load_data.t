
package Test::load_data;

use IPC::Cmd qw[can_run];
use lib 't/lib';
use MyTest::Common;
use Test::Exception;
use Test::File;
use Test::More qw/no_plan/;

my ( $class, $root, $sqitch ) = MyTest::Common->setup;

SKIP: {
    skip 'cp/pg_dump NOT in PATH',
        if ( !can_run('cp') or !can_run('pg_dump') );

    isa_ok my $load_data
        = $class->new( sqitch => $sqitch, command => 'load_data' ),
        $class;
    $load_data->data_dir( $root->subdir('data')->stringify );

    if ( -e $load_data->data_dir
        . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" )
    {
        lives_ok { $load_data->execute } 'load data for current change';
    }
    else {
        my $dump_data
            = $class->new( sqitch => $sqitch, command => 'dump_data' );
        $dump_data->data_dir( $root->subdir('data')->stringify );
        $dump_data->execute;
        lives_ok { $load_data->execute } 'load data for current change';
    }

    file_exists_ok( $load_data->data_dir
            . "/813fcb3f292220dfb4d903d64ae70704824fe774.dump" );

};

MyTest::Common->teardown;
