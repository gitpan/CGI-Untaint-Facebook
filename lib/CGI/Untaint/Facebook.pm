package CGI::Untaint::Facebook;

use warnings;
use strict;
use Carp;

# use base 'CGI::Untaint::object';
use base 'CGI::Untaint::url';
use LWP::UserAgent;
use URI::Heuristic;

=head1 NAME

CGI::Untaint::Facebook - Validate a URL is a valid Facebook URL

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

CGI::Untaint::Facebook validate if a given URL in a form is a valid Facebook URL.

    use CGI::Info;
    use CGI::Untaint;
    use CGI::Untaint::Facebook;
    # ...
    my $info = CGI::Info->new();
    my $params = $info->params();
    # ...
    my $u = CGI::Untaint->new($params);
    my $tid = $u->extract(-as_Facebook => 'web_address');
    # $tid will be lower case

=head1 SUBROUTINES/METHODS

=head2 is_valid

Validates the data.
Returns a boolean if $self->value is a valid Facebook URL.

=cut

sub is_valid {
	my $self = shift;

	my $value = $self->value;

	if(!defined($value)) {
		return 0;
	}

	# Ignore leading and trailing spaces
	$value =~ s/\s+$//;
	$value =~ s/^\s+//;

	if(!$self->SUPER::is_valid()) {
		return 0;
	}

	my $browser = LWP::UserAgent->new();
	$browser->agent('CGI::Untaint::Facebook');	# TODO: from class name
	$browser->timeout(10);
	$browser->max_size(128);

	my $url;
	if($value =~ /^http:\/\/www.facebook.com\/(.+)/) {
		$url = "https://www.facebook.com/$1";
	} elsif($value !~ /^https?:\/\/www.facebook.com\//) {
		$url = "https://www.facebook.com/$value";
	} else {
		$url = URI::Heuristic::uf_uristr($value);
	}
	my $request = new HTTP::Request('HEAD' => $url);
	$request->header('Accept' => 'text/html');
	if($ENV{'HTTP_ACCEPT_LANGUAGE'}) {
		$request->header('Accept-Language' => $ENV{'HTTP_ACCEPT_LANGUAGE'});
	}
	my $webdoc = $browser->simple_request($request);
	if(!$webdoc->is_success) {
		return 0;
	}
	if($url ne $value) {
		$self->value($url);
	}
	return 1;
}

=head1 AUTHOR

Nigel Horne, C<< <njh at bandsman.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-cgi-untaint-url-facebook at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CGI-Untaint-Twitter>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SEE ALSO

CGI::Untaint::url


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CGI::Untaint::Facebook


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CGI-Untaint-Facebook>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CGI-Untaint-Facebook>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CGI-Untaint-Facebook>

=item * Search CPAN

L<http://search.cpan.org/dist/CGI-Untaint-Facebook>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Nigel Horne.

This program is released under the following licence: GPL


=cut

1; # End of CGI::Untaint::Facebook