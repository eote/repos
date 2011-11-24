#!/usr/bin/perl -w
use strict;

my @GIT = qw/git/;
my @Files = qw/
	git-repos.log
	git-repos.log.old
	git-repos.log.diff
	/;
sub run {
	print STDERR join(" ",@_);
	return system(@_) == 0;
}

run(qw/perl/, 'scripts/generate-log.pl');

foreach(@Files) {
	run(qw/git add/,$_);
}
run(qw/git commit/,@ARGV);
