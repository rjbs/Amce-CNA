use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'Amce::CNA',
  VERSION_FROM  => 'lib/Amce/CNA.pm',
  LICENSE       => 'perl',
  PREREQ_PM     => {
    'Class::ISA'    => 0,
    'Sub::Exporter' => 0.960,
  },
);
