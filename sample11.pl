use strict;
use warnings;

# テキストファイルを解析し、単語の出現回数をカウント
my $filename = "EndoTest1.txt";
open(my $fh, '<', $filename) or die "Could not open file!";

my %word_count;
while (my $line = <$fh>) {
    chomp $line;
    my @words = split(/\s+/, $line);
    foreach my $word (@words) {
        $word =~ s/[.,!?]//g;  # 句読点を除去
        $word_count{$word}++;
    }
}
close($fh);

# 結果を表示
foreach my $word (keys %word_count) {
    print "$word: $word_count{$word}\n";
}
