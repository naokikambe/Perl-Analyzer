#!/perl
use strict;
use warnings;
use lib qw(./lib ../lib);
use Test::More tests => 9;

require_ok('Perl::Analyzer');

BEGIN {
    if ( -d 't') {
        chdir( 't' );
    }
}

my $src_dir = './u/foo';

my $paf = Perl::Analyzer->new();
ok( ref $paf eq 'Perl::Analyzer', 'create object Perl::Analyzer' );

my $data;
eval {
    $data = $paf->analyze($src_dir);
};

ok( ref $data eq 'HASH', 'file parsing successful' );

my $pkg_name;
my $file_name;
my $fileroot_dir = $src_dir . '/bar';

$pkg_name = '_DEFAULT_::u::foo::bar::mod';
$file_name = '/mod.pm';

is( 
    $data->{packages}->{$pkg_name}->{'package'},
    $pkg_name,
    'package name: mod'
);

is( 
    $data->{packages}->{$pkg_name}->{'filename'},
    $file_name,
    'filename: mod'
);

is( 
    $data->{packages}->{$pkg_name}->{'filerootdir'},
    $fileroot_dir,
    'filerootdir: mod'
);

###

$pkg_name = '_DEFAULT_::u::foo::bar::sub';
$file_name = '/sub.pl';

is( 
    $data->{packages}->{$pkg_name}->{'package'},
    $pkg_name,
    'package name: sub'
);

is( 
    $data->{packages}->{$pkg_name}->{'filename'},
    $file_name,
    'filename: mod'
);

is( 
    $data->{packages}->{$pkg_name}->{'filerootdir'},
    $fileroot_dir,
    'filerootdir: mod'
);

### 

done_testing();

1;
