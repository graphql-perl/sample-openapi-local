package MyApp;
use Mojo::Base "Mojolicious";

sub startup {
  my $self = shift;

  # Load the "api.yaml" specification from the public directory
  $self->plugin(OpenAPI => {spec => $self->static->file("api.yaml")->path});
}

1;
