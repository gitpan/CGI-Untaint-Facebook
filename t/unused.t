#!perl -wT

use strict;
use warnings;
use Test::More;

if($ENV{RELEASE_TESTING}) {
	use Test::Requires {
		'warnings::unused' => 0.04
	};
}

BEGIN {
	if($ENV{RELEASE_TESTING}) {
		use_ok('CGI::Untaint::Facebook');
		use warnings::unused -global;
	}
}

if(not $ENV{RELEASE_TESTING}) {
	plan(skip_all => 'Author tests not required for installation');
} else {
	new_ok('CGI::Untaint::Facebook');
	plan tests => 2;
}
