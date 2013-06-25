
use strict;

package App::Sqitch::DataHandler::pg;

use Carp;
use IPC::Cmd qw[can_run];
use Mouse;

sub dump {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = can_run('pg_dump') or croak 'pg_dump NOT found';
    my $full_cmd
        = "$cmd -Fp " . $db . " -f " . $data_dir . "/" . $change_id . ".dump";
    return $full_cmd;
}

sub load {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = can_run('psql') or croak 'psql NOT found';
    my $full_cmd
        = "$cmd -q -d "
        . $db . " -f "
        . $data_dir . "/"
        . $change_id . ".dump";
    return $full_cmd;
}

1;
