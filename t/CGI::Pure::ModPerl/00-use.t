# Pragmas.
use strict;
use warnings;

# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Test.
	use_ok('CGI::Pure::ModPerl');
}

# Test.
require_ok('CGI::Pure::ModPerl');