#!/usr/bin/perl

use v5.10;
use strict;
use utf8;
use autodie;
use warnings;
use Encode qw(decode encode);
use experimental 'smartmatch';

# rename
# bold_hover-5a107f7d.svg to bold_hover.svg

for(glob('./*.svg')){
	my $newName = $_ =~ s/(-\w+)(?=\.svg)//r;
	# say($_,' => ',  $newName);
	rename($_, $newName);
}
