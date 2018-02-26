use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->post_ok('/api/echo', json =>{i=>"work"})->json_is({i=>"work"});
$t->post_ok('/graphql', json => {
  query => 'mutation m {echo(body: [{key:"one", value:"two"}]) { key value }}'
})->json_is(
  { data => { echo => [{key=>"one", value=>"two"}] } },
)->or(sub { diag explain $t->tx->res->body });

done_testing();
