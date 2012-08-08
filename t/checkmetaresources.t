#!perl

use strict;
use warnings;

use Capture::Tiny qw/capture/;
use Dist::Zilla::Tester;
use Test::More 0.88;
use Try::Tiny;

my $no_meta = 'corpus/DZ_noMeta';
my $all_meta = 'corpus/DZ_allMeta';

## Tests start here

{
  my $tzil;
  try {
    $tzil = Dist::Zilla::Tester->from_config(
      { dist_root => $no_meta},
    );
    ok( $tzil, "created test dist with no META resources");

    capture { $tzil->release };
  } finally {
    my $err = shift || '';
    like(
      $err,
      qr/META resources not specified/i,
      "saw missing resources warning",
    );
    ok(
      ! grep({ /fake release happen/i } @{ $tzil->log_messages }),
      "FakeRelease did not happen",
    );
  }
}

{
  my $tzil;
  try {
    $tzil = Dist::Zilla::Tester->from_config(
      { dist_root => $all_meta},
    );
    ok( $tzil, "created test dist with all META resources");

    capture { $tzil->release };
  } finally {
    my $err = shift || '';
    is ( $err, "", "did not see missing resources warning" );
    ok(
      grep({ /fake release happen/i } @{ $tzil->log_messages }),
      "FakeRelease happened",
    );
  }
}

done_testing;
