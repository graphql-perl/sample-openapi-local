use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->post_ok('/api/echo', json =>{i=>"work"})->json_is({i=>"work"});
$t->get_ok('/api/echo?q=good')->json_is("good");
$t->post_ok('/api/user', json => {email=>'a@b',name=>'Bob'})->json_is(
  {email=>'a@b', name=> 'Bob'}
);
$t->post_ok('/graphql', json => {
  query => '{echoGet(q: "Hello")}'
})->json_is(
  { data => { echoGet => 'Hello' } },
)->or(sub { diag explain $t->tx->res->body });
$t->post_ok('/graphql', json => {
  query => 'mutation m {echo(body: [{key:"one", value:"two"}]) { key value }}'
})->json_is(
  { data => { echo => [{key=>"one", value=>"two"}] } },
)->or(sub { diag explain $t->tx->res->body });
$t->post_ok('/graphql', json => {
  query => 'mutation m {createUser(user: {email:"one@a", name:"Bob"}) { email name }}'
})->json_is(
  { data => { createUser => {email=>'one@a', name=>'Bob'} } },
)->or(sub { diag explain $t->tx->res->body });

done_testing();
