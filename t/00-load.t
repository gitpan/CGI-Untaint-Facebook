#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'CGI::Untaint::Facebook' ) || print "Bail out!
";
}

diag( "Testing CGI::Untaint::Facebook $CGI::Untaint::Facebook::VERSION, Perl $], $^X" );
