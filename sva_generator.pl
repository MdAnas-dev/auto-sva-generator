#!/usr/bin/perl
# sva_generator.pl
# Pattern miner and SVA code generator.
#
# Usage:
#   perl sva_generator.pl [input.csv] [output.sv] [threshold] [max_offset]
#
# Defaults:
#   input    = signals.csv
#   output   = auto_assertions.sv
#   threshold = 0.90  (90% confidence)
#   max_offset = 8    (clock cycles)

use strict;
use warnings;
use POSIX;

my $infile     = $ARGV[0] // 'signals.csv';
my $outfile    = $ARGV[1] // 'auto_assertions.sv';
my $threshold  = $ARGV[2] // 0.90;
my $max_offset = $ARGV[3] // 8;

my %trans;  # $trans{signal} = [ [time, value], ... ]

# --- Parse CSV ---
open(my $fh, '<', $infile) or die "Cannot open $infile: $!";
while (<$fh>) {
    chomp;
    next if /^time/;   # skip header
    my ($t, $sig, $val) = split /,/, $_, 3;
    push @{$trans{$sig}}, [$t + 0, $val];
}
close($fh);

my @signals = sort keys %trans;
printf "Loaded %d signals from %s\n", scalar @signals, $infile;

my @assertions;

# --- Pairwise temporal correlation ---
for my $i (0 .. $#signals) {
    for my $j (0 .. $#signals) {
        next if $i == $j;
        my ($A, $B) = ($signals[$i], $signals[$j]);

        my @ta     = map { $_->[0] } @{$trans{$A}};
        my %tb_set = map { $_->[0] => 1 } @{$trans{$B}};

        for my $k (1 .. $max_offset) {
            my $hits = grep { exists $tb_set{$_ + $k} } @ta;
            my $conf = @ta ? $hits / scalar(@ta) : 0;

            if ($conf >= $threshold) {
                my $sA = $A; $sA =~ s|.*/||;   # strip hierarchy
                my $sB = $B; $sB =~ s|.*/||;
                push @assertions, { a => $sA, b => $sB, k => $k, conf => $conf };
                last;  # take smallest k that passes threshold
            }
        }
    }
}

printf "Found %d candidate assertion(s)\n", scalar @assertions;

# --- Write SVA output ---
open(my $out, '>', $outfile) or die "Cannot write $outfile: $!";

print $out "// Auto-generated SVA properties\n";
print $out "// Tool: sva_generator.pl  |  Confidence threshold: ${threshold}\n";
print $out "// Generated: " . localtime() . "\n\n";
print $out "module auto_assertions(\n";
print $out "    input logic clk,\n";
print $out "    input logic rst_n\n";
print $out ");\n\n";

for my $p (@assertions) {
    my $name = "p_$p->{a}_implies_$p->{b}_k$p->{k}";
    printf $out "    // Confidence: %.1f%%  |  Offset: %d cycle(s)\n",
                $p->{conf} * 100, $p->{k};
    print $out  "    property $name;\n";
    print $out  "        \@(posedge clk) disable iff (!rst_n)\n";
    print $out  "        $p->{a} |=> ##$p->{k} $p->{b};\n";
    print $out  "    endproperty\n";
    print $out  "    $name: assert property ($name);\n\n";
}

print $out "endmodule\n";
close($out);

printf "Wrote %d assertions to %s\n", scalar @assertions, $outfile;
