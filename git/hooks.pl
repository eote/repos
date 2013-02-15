#!/usr/bin/perl -w
use strict;
use Cwd qw/getcwd/;
use File::Spec;
my $cwd = getcwd();
my $filename = File::Spec->rel2abs($0,$cwd);#;#ARGV[0];
my (undef,$dir,undef) = File::Spec->splitpath($cwd);
$dir =~ s/\/+$//;
my (undef,$pdir,undef) = File::Spec->splitpath($cwd);

my $scriptdir = File::Spec->catfile($pdir,'scripts');
my $runner = 'perl';

my $scriptname = shift;
if($scriptname =~ m/^\.sh/) {
	$runner = 'sh';	
}
my $script = File::Spec->catfile($scriptdir,$scriptname);
print STDERR join(" ",($runner,$script,$filename,@ARGV)),"\n";
exec $runner,$script,$filename,@ARGV;

