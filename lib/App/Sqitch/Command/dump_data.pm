
package App::Sqitch::Command::dump_data;

use 5.010;
use App::Sqitch::X qw(hurl);
use Locale::TextDomain qw(App-Sqitch);
use Mouse;
use namespace::autoclean;
use Try::Tiny;

extends 'App::Sqitch::Command';

our $VERSION = '0.0.1';

has project => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    default => sub {
        my $self = shift;
        try { $self->plan->project } || do {

            # Try to extract a project name from the database.
            my $engine = $self->engine;
            hurl status => __ 'Database not initialized for Sqitch'

                unless $engine->initialized;

            my @projs = $engine->registered_projects
                or hurl status => __ 'No projects registered';
            hurl status        => __x(
                'Use --project to select which project to query: {projects}',
                projects => join __ ', ',
                @projs,
            ) if @projs > 1;

            $projs[0];
        };
    },
);

has data_dir => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => sub {
        my $self = shift;
        return $self->sqitch->config->get( key => 'core.data_dir' );
    }
);

sub execute {

    my $self = shift;

    my $engine = $self->engine;
    my $state = $engine->current_state( $self->project ) || hurl {
        ident   => 'status',
        message => __ 'No changes deployed',
        exitval => 1,
    };

	# Change, Change ID, Database name
	# print $state->{change} . "\n" . $state->{change_id} . "\n" . $engine->destination . "\n";

	#print $self->sqitch->config->deploy_dir."\n";
    my $cmd
        = "pg_dump -Fp "
        . $engine->destination . " -f "
        . $self->data_dir . "/"
        . $state->{change_id} . ".dump";

    system($cmd);
}

1;

__END__



