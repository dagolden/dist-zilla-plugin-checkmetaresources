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
##  my $changes_file = $self->changelog;
##  my $newver = $self->zilla->version;
##
##  $self->log("Checking Changes");
##
##  $self->zilla->ensure_built_in;
##
##  # chdir in
##  my $wd = File::pushd::pushd($self->zilla->built_in);
##
##  if ( ! -e $changes_file ) {
##    $self->log_fatal("No $changes_file file found");
##  }
##  elsif ( $self->_get_changes ) {
##    $self->log("$changes_file OK");
##  }
##  else {
##    $self->log_fatal("$changes_file has no content for $newver");
##  }

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
