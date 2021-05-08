{•uptovcov  Kl ra, 2.C, 2015/2016 }
{ Najv„Ÿçie Ÿ¡slo z 3 Ÿ¡sel }
{ VST: 3 Ÿ¡sla}
{ VYS: najv„Ÿçie Ÿ¡slo}

Program Najvacsie_cislo;
Uses crt;
Var a,b,c : integer;

Begin
 Clrscr;
writeln           (' Program na urcenie najvacsieho cisla z 3 zadanych cisel');
writeln           (' _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
writeln;
writeln;
writeln;
writeln('Zadaj 3 cisla');
write('Prve cislo:');
readln(a);
write(' Druhe cislo:');
readln(b);
write(' Tretie cislo:');
readln(c);
writeln;
writeln;
writeln;
writeln;
if a>b then
 if a>c then
writeln(' Najvacsie cislo je ',a');
else
writeln(' Najvascie cislo je ',c');
else
if b>c then
writeln(' Najvacsie cislo je ',b');
else
writeln('Najvacsi cislo je ',c');
readln;
end.
