
use strict;

package App::Sqitch::DataHandler::sqlite;

use Mouse;

sub dump {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = "cp $db $data_dir/$change_id.dump";
    return $cmd;
}

sub load {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = "cp $data_dir/$change_id.dump $db";
    return $cmd;

}

1;
