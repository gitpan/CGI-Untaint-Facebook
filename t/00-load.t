#!perl -Tw

use strict;

use Test::More tests => 2;

BEGIN {
    use_ok( 'CGI::Untaint::Facebook' ) || print "Bail out!
";
}

require_ok('CGI::Untaint::Facebook') || print 'Bail out!';

diag( "Testing CGI::Untaint::Facebook $CGI::Untaint::Facebook::VERSION, Perl $], $^X" );
