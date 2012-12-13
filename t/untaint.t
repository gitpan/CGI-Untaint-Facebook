#!perl -w

use strict;
use warnings;
use Test::More;

eval 'use Test::CGI::Untaint';

if($@) {
        plan skip_all => 'Test::CGI::Untaint required for testing extraction handler';
} else {
        plan tests => 6;

        use_ok('CGI::Untaint::Facebook');

        is_extractable('http://www.facebook.com/rockvillebb', 'https://www.facebook.com/rockvillebb', 'Facebook');
        is_extractable('https://www.facebook.com/rockvillebb', 'https://www.facebook.com/rockvillebb', 'Facebook');
        unextractable('http://www.example.com/foo', 'Facebook');
        unextractable('http://www.facebook.com/fhvhvhj0vfj90', 'Facebook');
        unextractable('voicetimemoney', 'Facebook');
}