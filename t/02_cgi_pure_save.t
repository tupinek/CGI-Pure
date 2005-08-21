#!/usr/bin/env perl
# $Id: 02_cgi_pure_save.t,v 1.4 2005-08-21 09:44:09 skim Exp $

# Pragmas.
use strict;
use warnings;

# Modules.
use CGI::Pure::Save;
use Test;

# Global variables.:
use vars qw/$debug $dir $class/;

BEGIN {
	# Name of class.
	$dir = $class = 'CGI::Pure::Save';
	$dir =~ s/:://g;

	my $tests = `egrep -r \"^[[:space:]]*ok\\(\" t/$dir/*.t | wc -l`;
	chomp $tests;
	plan('tests' => $tests);

	# Debug.
	$debug = 1;
}

# Prints debug information about class.
print "\nClass '$class'\n" if $debug;

# For every test for this class.
my @list = `ls t/$dir/*.t`;
foreach (@list) {
	chomp;
	do $_;
	print $@;
}
