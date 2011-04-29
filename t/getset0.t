use warnings;
use strict;

use Test::More tests => 4;
use t::LoadXS ();
use t::WriteHeader ();

t::WriteHeader::write_header("callparser0", "t");
ok 1;
require_ok "Devel::CallParser";
t::LoadXS::load_xs("getset0", "t", ["Devel::CallParser"]);
ok 1;

t::getset0::test_cv_getset_call_parser();
ok 1;

1;
