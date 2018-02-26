package MyApp::Controller::Echo;
use Mojo::Base "Mojolicious::Controller";

sub index {
  # Validate input request or return an error document
  my $self = shift->openapi->valid_input or return;
  my $data = $self->req->method eq 'POST'
    ? $self->req->json
    : $self->req->param('q');
  # Render back the same data as you received using the "openapi" handler
  $self->render(openapi => $data);
}

1;
