use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->post_ok('/api/echo', json =>{i=>"work"})->json_is({i=>"work"});

done_testing();
