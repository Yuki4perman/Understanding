my $text = "I love Perl programming!";
if ($text =~ /Perl/) {
    print "Found 'Perl' in the text.\n";
}

$text =~ s/Perl/Python/;
print "$text\n";

my $text2 = "I'm Yuki! Nice to meet you!!";
print "処理前：$text2\n";
if($text2 =~ /Yuki/){
    print "このテキストに\"Yuki\"という文字が見つかりました。\n";
}
print "\"Yuki\"という文字を\"Motoki\"という文字に置換します。\n";
$text2 =~ s/Yuki/Motoki/;
print "置換後：$text2\n";
