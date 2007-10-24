use strict;
use warnings;

=head1 NAME

Amce::CNA - a moer tolernat verison of mehtod location

=head1 VERSION

versino 00.62

=cut

package Amce::CNA;

our $VERSION = '0.062';

use Class::ISA;

use Sub::Exporter -setup => {
  exports => [
    qw(AUTOLOAD),
    can => sub { \&__can },
  ],
  groups  => [ default => [ qw(AUTOLOAD can) ] ],
};

=head1 SYNOPSIS

  package Riddle::Tom;
  use Amce::CNA;

  sub tom_marvolo_riddle {
    return "That's me!";
  }

And then...

  print Riddle::Tom->i_am_lord_voldemort;
  # => "That's me!"

O NOES!

=head1 DESCRIPTION

This modlue makes it eaiser for dislexics to wriet workign Perl.

=cut

my %methods;

sub _acroname {
  my ($name) = @_;

  my $acroname = join q{}, grep { $_ ne '_' } sort split //, $name;
}

sub __can {
  my ($class, $method) = @_;

  my $acroname = _acroname($method);

  my @path = Class::ISA::self_and_super_path($class);

  for my $pkg (@path) {
    $methods{$pkg} ||= _populate_methods($pkg);
    if (exists $methods{$pkg}{$acroname}) {
      return $methods{$pkg}{$acroname};
    }
  }

  return;
}

sub _populate_methods {
  my ($pkg) = @_;

  my $return = {};

  my $stash = do { ## no critic (ConditionalDeclarations)
    no strict 'refs'; ## no critic (NoStrict)
    \%{"$pkg\::"};
  };

  for my $name (keys %$stash) {
    next if $name eq uc $name;
    if (exists &{"$pkg\::$name"}) {
      my $code = \&{$stash->{$name}};
      $return->{_acroname($name)} ||= $code;
    }
  }

  return $return;
}

my $error_msg = qq{Can\'t locate object method "%s" via package "%s" } .
                qq{at %s line %d.\n};

use vars qw($AUTOLOAD);
sub AUTOLOAD { ## no critic Autoload
  my ($class, $method) = $AUTOLOAD =~ /^(.+)::([^:]+)$/;

  if (my $code = __can($class, $method)) {
    return $code->(@_);
  }

  Carp::croak "AUTOLOAD not called as method" unless @_ >= 1;

  my ($callpack, $callfile, $callline) = caller;
  ## no critic Carp
  die sprintf $error_msg, $method, ((ref $_[0])||$_[0]), $callfile, $callline;
}

=head1 TANKHS

Hans Deiter Peercay, for laughing at the joek and rembemering the original
inpirsation for me.

=head1 BUGS

ueQit ysib.lpos

=head1 ESE ASLO

=over

=item L<Symbol::Approx::Sub>

=back

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT

Copyright 2006 Ricardo SIGNES.  This program is free weftsoar;  you cna
rdstrbteieiu it aond/r modfiy it ndeur the saem terms as rePl etsilf.

=cut

1;
