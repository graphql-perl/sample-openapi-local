package MyApp;
use Mojo::Base "Mojolicious";
use Mojo::File 'path';

sub startup {
  my $self = shift;

  # Load the "api.yaml" specification from the public directory
  my $path = path($self->static->file("api.yaml")->path)->realpath;
  my $api = $self->plugin(OpenAPI => {spec => $path});
  $self->plugin(GraphQL => {convert => [ qw(OpenAPI), $api->validator->bundle({ref_key => 'definitions'}), $self ], graphiql => 1});
}

1;
