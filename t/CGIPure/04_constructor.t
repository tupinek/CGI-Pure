print "Testing: new('init' => {'foo' => '1', 'bar' => [2, 3, 4]}) ".
	"hash constructor.\n" if $debug;
my $obj = $class->new(
	'init' => {'foo' => '1', 'bar' => [2, 3, 4]},
	'utf8' => 1,
);
my @params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 1);
ok($obj->param('bar'), 2);
@params = $obj->param('bar');
ok(join(' ', @params), '2 3 4');

$obj = $class->new(
	'init' => {'foo' => '1', 'bar' => [2, 3, 4]}, 
	'utf8' => 0
);
@params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 1);
ok($obj->param('bar'), 2);
@params = $obj->param('bar');
ok(join(' ', @params), '2 3 4');

print "Testing: new('init' => 'foo=5&bar=6&bar=7&bar=8') query string ".
	"constructor.\n" if $debug;
$obj = $class->new(
	'init' => 'foo=5&bar=6&bar=7&bar=8',
	'utf8' => 1,
);
@params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

$obj = $class->new(
	'init' => 'foo=5&bar=6&bar=7&bar=8',
	'utf8' => 0,
);
@params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

print "Testing: new('init' => \$".$class."_object) clone constructor.\n" 
	if $debug;
my $old_obj = $obj;
$obj = $class->new(
	'init' => $old_obj,
	'utf8' => 1,
);
@params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

$obj = $class->new(
	'init' => $old_obj,
	'utf8' => 0,
);
@params = $obj->param;
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

print "Testing: new() constructor for 'GET' method.\n" if $debug;
$ENV{'QUERY_STRING'} = 'name=JaPh%2C&color=red&color=green&color=blue';
$ENV{'REQUEST_METHOD'} = 'GET';
$obj = $class->new;
@params = $obj->param;
ok(join(' ', @params) eq 'name color' || join(' ', @params) eq 'color name');

# TODO Test utf8 chars.
