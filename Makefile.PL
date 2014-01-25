use strict;
use warnings;
use ExtUtils::MakeMaker;
use IO::Socket::INET;

my $s = IO::Socket::INET->new(
	PeerAddr => 'www.facebook.com:443',
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
        'Test::Most' => 0,
	'CGI::Untaint' => 0,
	'CGI::Untaint::url' => 0,
	'Test::NoWarnings' => 0,
	'LWP::UserAgent' => 0,
	'URI::Escape' => 0,
	'URI::Heuristic' => 0,
	'Mozilla::CA' => 20120823,
	'LWP::Protocol::https' => 6.03,
	'Net::SSLeay' => 1.57,
	# 'Test::Kwalitee' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CGI-Untaint-Facebook-*' },
);
