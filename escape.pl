#!/opt/bin/perl -w

# escape.pl - Automatically escapes regular expression clean sigs
# v. 2017-01-04

use strict;
use Getopt::Std;

# Handle arguments
my %opts;

getopts('h', \%opts);

if ($opts{h}) {
    help();
}

# Functions
###########

# Provide help
sub help {
    print "
escape.pl - Automatically escapes regular expression clean sigs

  Usage: escape.pl
    -h
        Show this help

  Delineate regex commands with three commas,

        e.g.: ,,,REGEX,,,
              ,,,md5,,,
              ,,,b64,,,
              ,,,q,,,

  and then paste the regex at the prompt.

";
    exit;
}

# Ask user for the regex they want to test
print "\nPlease enter the regex: ";

# Clear any spaces at the beginning or end of the input
chomp(my $regex = <STDIN>);

# Split the regex in to an array using a pre-defined delimiter
my @array = split(",,,", $regex);
my $result;

# Loops through the array and on the even array values look for and escape any special characters
# and to replace php tag, md5, quotes and base64decode with equivalent regex
for ( my $i=0; $i < scalar(@array); $i++ ) {
        if ($i % 2 == 0) {
                $array[$i] =~ s/(\\|\/|\*|\+|\?|\^|\$|\(|\)|\[|\]|\{|\}|\.|\:|\&|\@|\|)/\\$1/g;
        } else {
                $array[$i] =~ s/<\?php/<\\?\(\?\:php\)\?/g;
                $array[$i] =~ s/b64/\[A-Za-z0-9\+\/\]/g;
                $array[$i] =~ s/md5/\[a-f0-9\]\{32\}/g;
                $array[$i] =~ s/q/\['"\]/g;
}

        $result .= $array[$i];
}

print "\n$result\n\n";
