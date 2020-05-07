#!/usr/bin/perl -w

use lib "..";
# /var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/ports.pl
# /var/lib/myfrdcsas/versions/myfrdcsa-1.0/sandbox-new/javapengine-20200108/javapengine-20200108/src/main/java/com/simularity/os/javapengine/example/ManualAsk.java
# cd /var/lib/myfrdcsa/sandbox/javapengine-20200108/javapengine-20200108 && ./frdcsa.sh
# cd /var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/scripts/ && ./test.pl

use FormalogPengines;
use KBS2::ImportExport;
use KBS2::Util qw(Var);

use Data::Dumper;
use JSON;

my $fp = FormalogPengines->new();
my $importexport = KBS2::ImportExport->new();

sub DoQuery {
  my (%args) = @_;
  my $res = $fp->GetAll($args{Query});
  my $array = $res->toArray();
  foreach my $elt (@$array) {
    print "<$elt>\n";
    push @results, ConvertJSONToPerl(Elt => $elt);
  }
}

sub ConvertJSONToPerl {
  my (%args) = @_;
  my $ds = from_json($args{Elt});
  print Dumper($ds);
}

sub DoQueryInterlingua {
  my (%args) = @_;
  my $input = $args{Input};
  my $res1 = $importexport->Convert
    (
     Input => $input,
     InputType => 'Interlingua',
     OutputType => 'Prolog',
    );
  if ($res1->{Success}) {
    my $output = $res1->{Output};
    print "$output\n";
    my $query = "($output,transform_result(X,Y))";
    DoQuery(Query => $query);
  }
}

# DoQueryInterlingua(Input => [['member',Var('?X'),['_prolog_list',['a','taco',Var('?A'),Var('?_A'),'B',Var('?A'),'C D'],'b','dag',2,'2','c']]]);

my $query = "member(X, [a(taco,A,_A,'B','C D'),b,dag,2,c])";
# my $query = "(member(X,[a(taco,A,_A,'B',A,'C D'),b,dag,2,'2',c]),transform_result(X,Y))";
DoQuery(Query => $query);

# my $query = "formalogPenginesCall(member(X, [1,'1',a,A,'A',[],B]),Result)";
# my $query = "formalogPenginesCall(member(X, [1,'1',a,A,'A',[],B]))";
