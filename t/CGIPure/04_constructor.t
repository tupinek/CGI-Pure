# $Id: 04_constructor.t,v 1.2 2004-09-28 18:07:49 skim Exp $

print "Testing: new({'foo' => '1', 'bar' => [2, 3, 4]}) hash constructor.\n" 
	if $debug;
$obj = new $class({'foo' => '1', 'bar' => [2, 3, 4]});
my @params = $obj->param();
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 1);
ok($obj->param('bar'), 2);
@params = $obj->param('bar');
ok(join(' ', @params), '2 3 4');

print "Testing: new('foo=5&bar=6&bar=7&bar=8') query string constructor.\n"
	if $debug;
$obj = new $class('foo=5&bar=6&bar=7&bar=8');
@params = $obj->param();
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

print "Testing: new(\$".$class."_object) clone constructor.\n" if $debug;
my $old_obj = $obj;
$obj = new $class($old_obj);
@params = $obj->param();
ok(join(' ', @params) eq 'foo bar' || join(' ', @params) eq 'bar foo');
ok($obj->param('foo'), 5);
ok($obj->param('bar'), 6);
@params = $obj->param('bar');
ok(join(' ', @params), '6 7 8');

print "Testing: new() constructor for 'GET' method.\n" if $debug;
$ENV{'QUERY_STRING'} = 'name=JaPh%2C&color=red&color=green&color=blue';
$ENV{'REQUEST_METHOD'} = 'GET';
$obj = new $class();
@params = $obj->param();
ok(join(' ', @params) eq 'name color' || join(' ', @params) eq 'color name');

