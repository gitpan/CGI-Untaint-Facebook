use strict;
use warnings;
use ExtUtils::MakeMaker;
use IO::Socket::INET;

my $s = IO::Socket::INET->new(
	PeerAddr => 'www.facebook.com:80',
	Timeout => 10
);
unless($s) {
	die 'CGI::Untaint::Facebook needs a permanent connexion to the Internet';
}

WriteMakefile(
    NAME                => 'CGI::Untaint::Facebook',
    AUTHOR              => q{Nigel Horne <njh@bandsman.co.uk>},
    VERSION_FROM        => 'lib/CGI/Untaint/Facebook.pm',
    ABSTRACT_FROM        => 'lib/CGI/Untaint/Facebook.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'GPL')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0.82,	# Need new_ok()
	'CGI::Untaint' => 0,
	'CGI::Untaint::url' => 0,
	'Test::NoWarnings' => 0,
	'LWP::UserAgent' => 0,
	'URI::Heuristic' => 0,
	'Mozilla::CA' => 20120823,
	'LWP::Protocol::https' => 0,
	# 'Test::Kwalitee' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CGI-Untaint-Facebook-*' },
);
