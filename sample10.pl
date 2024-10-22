use strict;
use warnings;

my $text = "The quick brown fox jumps over the lazy dog.";

# 全ての単語を大文字に変換
$text =~ s/\b(\w+)\b/\U$1/g;
print "$text\n";

#Endo
my $text2 = "VERY HAPPY DAY!";
$text2 =~ s/([A-Z])/lc($1)/ge; 
print "$text2\n";