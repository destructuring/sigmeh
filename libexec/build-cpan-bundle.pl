#!/usr/bin/env perl

use strict;
use CPAN;
use Config;
use File::Copy;
use File::Spec::Functions;

# Extract a list of the third party modules installed on this machine
my $podfile = $ARGV[0];
print "Loading modules from $podfile\n";
open(DATA,$podfile) or die "Can't open module list ($podfile): $!";
while(<DATA>) {
  if (m/.*C<Module> L<(.*)>/) {
    my ($module) = split /\|/,$1,0;
    $module =~ s{-}{::}g;
    my ($mo) = CPAN::Shell->expand("Module", $module);
    if ($mo) {
      $mo->get("meh");
    }
    else {
      print "Can't expand $module\n";
    }
  }
}
close(DATA);
