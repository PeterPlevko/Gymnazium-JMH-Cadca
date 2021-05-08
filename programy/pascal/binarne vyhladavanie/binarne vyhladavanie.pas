program binarne_vyhladavanie;
uses crt;
var    prvok:array[1..10] of integer;
       zaciatok,koniec,i,stred,find,pocet:integer;
       zaver:char;


{Andrea Turiakova, Gymnazium J.M.Hurbana, 3.seminar}
{VST:pocet prvkov,jednlotlive prvky,hladany prvok }
{VYST: poradie hladaneho prvku}

procedure hlavicka;
 begin
  writeln;
  write('                    Binarne vyhladavanie prvkov v usporiadanom poli');
  writeln;writeln;writeln;
 end;

begin
  repeat
 hlavicka;
 write(' Zadaj pocet prvkov: '); readln(pocet);


 write(' Zadaj ',1,'. prvok: '); readln(prvok[1]);
 i:=2;


repeat
   write(' Zadaj ',i,'. prvok: '); readln(prvok[i]);
   if prvok[i]<prvok[i-1] then begin
   writeln(' Prvok je mensi ako predchadzajuci. Zadaj znova!');
   i:=i;
                               end
   else i:=i+1;
until (i=pocet+1);

clrscr;
hlavicka;
write(' Zadaj hladany prvok: '); readln(find);
zaciatok:=1;
koniec:=pocet;

repeat
 if (((zaciatok+koniec) mod  2)=1) then stred:=((zaciatok+koniec+1) div 2)
                                   else stred:=(zaciatok+koniec) div 2;
 if (find>prvok[stred]) then zaciatok:=stred+1
                        else koniec:=stred-1;
until (find=prvok[stred]) or ((koniec-zaciatok)=0);

if  (find=prvok[stred]) then writeln(' Dane cislo sa v postupnosti nachadza na ',stred,' mieste.')
                         else writeln(' Dane cislo sa v postupnosti nenachadza.');
writeln;writeln;writeln;writeln;
writeln(' Chces program opakovat? pre koniec stlac n/N.');
zaver:=readkey;
until (zaver='n') or (zaver='N');
end.

