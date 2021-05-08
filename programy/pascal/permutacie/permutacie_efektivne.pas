program permutacie_efektivne;
uses crt;
var     i,j,m,n,pocet:integer;
        koniec:char;
        pole_l,pole_k:array[1..8] of integer;


procedure hlavicka;
begin
 writeln;
 writeln('                            Permutacie');
 writeln;writeln;writeln;
end;

procedure nacitanie;
begin
 for i:=1 to n do begin
write(' Zadaj ',i,'. prvok postupnosti: ');readln(pole_l[i]);
                 end;
 end;


procedure permutacia;
begin
for i:=1 to n do
write(pole_l[i],' ');
writeln;

m:=n;

repeat
pole_l[n+1]:=pole_l[1];
for j:=2 to m do
pole_l[j-1]:=pole_l[j];

pole_l[m]:=pole_l[n+1];
if (pole_l[m]<>pole_k[m]) then permutacia
  else m:=m-1;
until (m=1);
 end;

begin
repeat
clrscr;
hlavicka;
write(' Zadaj pocet prvkov: ');readln(n);
nacitanie;
for i:=2 to n  do
for j:=(i-1) downto 1 do
if (pole_l[i]=pole_l[j]) then begin
writeln(' Niektori z prvkov sa opakuje. Zadaj prvky znova! '); nacitanie;
                          end;
for i:=1 to n do
pole_k[i]:=pole_l[i];

clrscr;
hlavicka;
pocet:=1;
for i:=2 to n do
pocet:=pocet*i;
write('  Pocet permutacii z ',n,' prvkov je ',pocet,'.');
write('  Vypis permutacii z prvkov: ');
for i:=1 to n do
write(pole_l[i],'  ');
writeln;writeln;writeln;
permutacia;


writeln;writeln;writeln;
write(' Chces program opakovat? Pre ukoncenie stalc n/N.');
koniec:=readkey;

until (koniec='n') or (koniec='N');
end.

