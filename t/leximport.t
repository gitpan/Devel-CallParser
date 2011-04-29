use warnings;
use strict;

BEGIN {
	eval {
		require Lexical::Sub;
		Lexical::Sub->VERSION(0.004);
	};
	if($@ ne "") {
		require Test::More;
		Test::More::plan(skip_all => "good Lexical::Sub unavailable");
	}
}

use Test::More tests => 5;
use t::LoadXS ();
use t::WriteHeader ();

t::WriteHeader::write_header("callparser0", "t");
ok 1;
require_ok "Devel::CallParser";
t::LoadXS::load_xs("listquote", "t", ["Devel::CallParser"]);
ok 1;

use Lexical::Sub foo => sub { [ "aaa", @_, "zzz" ] };
t::listquote::cv_set_call_parser_listquote(\&foo, "xyz");

my $ret;
eval q{$ret = foo:ab cd:;};
is $@, "";
is_deeply $ret, [ "aaa", "xyz", "a", "b", " ", "c", "d", "zzz"  ];

1;
