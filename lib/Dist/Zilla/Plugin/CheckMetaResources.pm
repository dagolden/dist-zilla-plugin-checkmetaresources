use 5.008001;
use strict;
use warnings;

package Dist::Zilla::Plugin::CheckMetaResources;
# ABSTRACT: No abstract given for Dist::Zilla::Plugin::CheckMetaResources
# VERSION

# Dependencies
use autodie 2.00;

use Dist::Zilla 4 ();
use autodie 2.00;
use Moose 0.99;
use namespace::autoclean 0.09;

# extends, roles, attributes, etc.

with 'Dist::Zilla::Role::BeforeRelease';

# methods

sub before_release {
  my $self = shift;
  my $distmeta = $self->zilla->distmeta;

  $self->log("Checking META resources");

  if ( ref $distmeta->{resources} eq 'HASH' ) {
    $self->log("META resources OK");
  }
  else {
    $self->log_fatal("META resources not specified");
  }

  return;
}

__PACKAGE__->meta->make_immutable;

1;

=for Pod::Coverage before_release

=head1 SYNOPSIS

  # in dist.ini

  [CheckMetaResources]

=head1 DESCRIPTION

This is a "before release" Dist::Zilla plugin that ensures that your META file
will contain some "resources" data. If it doesn't find any, it will abort the
release process.

=head1 USAGE

Good luck!

=head1 SEE ALSO

Maybe other modules do related things.

=cut

# vim: ts=2 sts=2 sw=2 et:
