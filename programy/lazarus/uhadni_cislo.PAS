{Peter Plevko, Septima A, Sk. rok 2017/18
 Program uhadni cislo
 Vstupne podmienky: pocet pokusov, hranice, cislo
 Vystupne podmienky: vyhra,prehra }
program uhadni;
uses crt;
var
start,konec,i,pocetpokusov ,cislo,premenna:integer;


begin
randomize;
clrscr;
writeln('pocet pokusov');
readln(pocetpokusov);

writeln('Zadaj dolnu hranicu');
readln(start);
writeln('end');
readln(konec);
premenna:=random(konec-start)+start;
repeat
write('Napis cislo na ktore myslim: ');
readln(cislo);
i:=i+1;
if cislo=premenna then
begin writeln('uhadol si'); Break; end else writeln('neuhadol si');
until i=pocetpokusov;
readln;
end.