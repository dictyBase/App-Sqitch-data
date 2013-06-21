
use strict;

package App::Sqitch::DataHandler::pg;

use Mouse;

sub dump {
    my ( $self, $db, $data_dir, $change_id ) = @_;

    my $cmd
        = "pg_dump -Fp "
        . $db . " -f "
        . $data_dir . "/"
        . $change_id . ".dump";
    return $cmd;
}

sub load {

    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd
        = "psql -q -d "
        . $db . " -f "
        . $data_dir . "/"
        . $change_id . ".dump";
}

1;
