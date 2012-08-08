use 5.008001;
use strict;
use warnings;

package Dist::Zilla::Plugin::CheckMetaResources;
# ABSTRACT: Ensure META includes resources
# VERSION

# Dependencies
use Dist::Zilla 4 ();
use autodie 2.00;
use Moose 0.99;
use namespace::autoclean 0.09;

# extends, roles, attributes, etc.

has [qw/repository bugtracker/] => (
  is => 'ro',
  isa => 'Bool',
  default => 1,
);

has homepage => (
  is => 'ro',
  isa => 'Bool',
  default => 0,
);

with 'Dist::Zilla::Role::BeforeRelease';

# methods

sub before_release {
  my $self = shift;
  my $dm = $self->zilla->distmeta;

  $self->log("Checking META resources");

  my @keys = qw/repository bugtracker homepage/;
  my @errors = grep { $self->$_ && ! exists $dm->{resources}{$_} } @keys;

  if ( ! @errors ) {
    $self->log("META resources OK");
  }
  else {
    $self->log_fatal("META resources not specified: @errors");
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

This is a "before release" L<Dist::Zilla> plugin that ensures that your META file
will contain some "resources" data.

By default, it requires you to have at least 'repository' and 'bugtracker'
sections, but 'homepage' is optional.

You can toggle any of these checks on or off.  For example:

  [CheckMetaResources]
  repository = 1
  bugtracker = 0
  homepage = 1

=head1 SEE ALSO

=for :list
* L<Dist::Zilla>
* L<Dist::Zilla::Plugin::MetaResources>
* L<Dist::Zilla::Plugin::GithubMetas>
* L<Dist::Zilla::Plugin::AutoMetaResources>
* ... and plenty more (search metacpan.org for "dist zilla plugin meta")

=cut

# vim: ts=2 sts=2 sw=2 et:
