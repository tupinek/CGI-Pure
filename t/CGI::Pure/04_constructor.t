# Modules.
use CGI::Pure;
use Test::More 'tests' => 3;

print "Testing: new() plain constructor.\n";
my $obj = CGI::Pure->new;
ok(defined $obj);
ok($obj->isa('CGI::Pure'));

print "Testing: new() empty constructor.\n";
eval {
	$obj = CGI::Pure->new('');
};
is($@, "Unknown parameter ''.\n");
