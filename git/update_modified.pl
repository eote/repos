#!/usr/bin/perl -w
use strict;
use Cwd qw/getcwd/;
use File::Spec;

sub run {
	print STDERR "\t",join(" ",@_),"\n";
	return system(@_) == 0;
}
sub update_subrepo {
	return;
	my $dir = shift;
	my $scriptdir = shift;
	print STDERR "$dir not exist.\n" unless(-d $dir);
	chdir($dir) or die("$!\n");
	print STDERR "[$dir]\n";
	run('git','add','-A');
	run('sh',File::Spec->catfile($scriptdir, 'commit.sh'));
}

my %status = (
	modified=>[],
);
open FI,'-|','git status';
while(<FI>) {
	if(m/^#\s+([^:]+):\s+(.+)?\s+$/) {
		push @{$status{$1}},$2;
	}
}
#modified:   babebase (modified content, untracked content)
#	modified:   fp-afun (untracked content)
#	#	modified:   fp-default (untracked content)
#
close FI;

my $cwd = getcwd();
my $scriptdir = File::Spec->rel2abs($0,$cwd);#;#ARGV[0];
(undef,$scriptdir,undef) = File::Spec->splitpath($scriptdir);
my %repos;
foreach(@{$status{modified}}) {
	next unless($_);
	if(m/^(.+\/)?privepo\/([^\/]+)\/git/) {
		$_ = $2;
	}
	elsif(m/^(.+)\.git/) {
		$_ = $1;
	}
	else {
		next;
	}
	s/^\.\///g;
	s/^git\///;
	$repos{$_} = 1;
}
print "[$_] haved been modified.\n" foreach(keys %repos);
run('sh',"$scriptdir/sync-repos.sh",keys %repos,@ARGV);
print STDERR "Done.\n";
#use Data::Dumper;print Data::Dumper->Dump([\%status,\%repos],[qw/*status *repos/]);

