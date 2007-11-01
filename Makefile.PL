use ExtUtils::MakeMaker;

use 5.006;

WriteMakefile(
  NAME          => 'Amce::CNA',
  VERSION_FROM  => 'lib/Amce/CNA.pm',
  AUTHOR        => 'Ricardo SIGNES <rjbs@cpan.org>',
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM     => {
    'Class::ISA'    => 0,
    'Sub::Exporter' => 0.960,
  },
);
