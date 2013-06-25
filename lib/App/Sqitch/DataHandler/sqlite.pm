
use strict;

package App::Sqitch::DataHandler::sqlite;

use Carp;
use IPC::Cmd qw[can_run];
use Mouse;

sub dump {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = can_run('cp') or croak 'cp not in PATH';
    my $full_cmd = "$cmd $db $data_dir/$change_id.dump";
    return $full_cmd;
}

sub load {
    my ( $self, $db, $data_dir, $change_id ) = @_;
    my $cmd = can_run('cp') or croak 'cp not in PATH';
    my $full_cmd = "cp $data_dir/$change_id.dump $db";
    return $full_cmd;
}

1;
