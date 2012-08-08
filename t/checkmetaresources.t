#!perl

use strict;
use warnings;

use Capture::Tiny qw/capture/;
use Dist::Zilla::Tester;
use Test::More 0.88;
use Try::Tiny;

my $no_meta = 'corpus/DZ_noMeta';
my $no_home = 'corpus/DZ_noHome';
my $all_meta = 'corpus/DZ_allMeta';

## Tests start here

#--------------------------------------------------------------------------#
# default attributes
#--------------------------------------------------------------------------#

{
  my $label = "default attributes";
  dzil_not_released( $no_meta, $label );
  dzil_released( $all_meta, $label );
  dzil_released( $no_home, $label );
}

#--------------------------------------------------------------------------#
# fixture subs
#--------------------------------------------------------------------------#

sub dzil_released     { _dzil_test(1, @_) }
sub dzil_not_released { _dzil_test(0, @_) }

sub _dzil_test {
  my ($should_release, $corpus, $label, $filter_sub) = @_;

  subtest "$label: $corpus" => sub {
    my $tzil;
    try {
      $tzil = Dist::Zilla::Tester->from_config(
        { dist_root => $corpus},
      );
      ok( $tzil, "created test dist from $corpus" );

      $filter_sub->() if $filter_sub;

      capture { $tzil->release };
    } finally {
      my $err = shift || '';
      if ( $should_release ) {
        is ( $err, "", "did not see missing resources warning" );
        ok(
          grep({ /fake release happen/i } @{ $tzil->log_messages }),
          "FakeRelease happened",
        );
      }
      else {
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
  }
}

done_testing;
