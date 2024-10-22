use strict;
use warnings;

# ファイルに書き込む
open(my $write_fh, '>', 'output.txt') or die "Could not open file!";
print $write_fh "This is a sample text.\n";
close($write_fh);

# ファイルから読み込む
open(my $read_fh, '<', 'output.txt') or die "Could not open file!";
while (my $line = <$read_fh>) {
    print $line;
}
close($read_fh);

#Endo
#Write
open(my $write_endo, '>', 'C:/Perl/practice/EndoTest1.txt') or die "Could not open file!";
print $write_endo "I'm Endo! Good night!!\n";
print $write_endo "I'm very sleepy...\n";
close($write_endo);
#Read
open(my $read_endo, '<', 'C:/Perl/practice/EndoTest1.txt') or die "Could not open file!";
while(my $line = <$read_endo>){
    print $line;
}
close($read_endo);