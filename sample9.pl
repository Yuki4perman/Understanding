
use strict;
use warnings;

# コマンドライン引数の取得
my $filename = $ARGV[0] or die "Usage: $0 FILENAME\n";

# ファイルを読み込む
open(my $fh, '<', $filename) or die "Could not open file!";
while (my $line = <$fh>) {
    print $line;
}
close($fh);

#Endo
#get
my $name = $ARGV[1] or die "Error";
print "My name is $name";

