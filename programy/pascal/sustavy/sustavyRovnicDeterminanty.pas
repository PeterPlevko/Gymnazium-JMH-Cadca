program sustavyRovnicDeterminanty; {VYPOCET SUSTAVY ROVNIC POMOCOU DETERMINANTOV}
uses crt;
var i,j,D,pocet:integer;
determinant,pomocne:array[1..10] of integer;
matica:array[1..5,1..6] of integer;
vyber:char;
procedure vypis;
 begin
  writeln;
  for i:=1 to pocet DO
   begin
   for j:=1 to pocet+1 do
    begin
    if j>pocet then write(' |',matica[i,j])
    else write (' ',matica[i,j]);
    end;
 writeln;
 end;
end;

begin
randomize;
CLRSCR;
writeln('-------------VYPOCET SUSTAVY ROVNIC POUZITIM DETERMINANTOV----------------');
write('Zadaj, kolko mame rovnic/neznamych: ');
readln(pocet);
write('CHCES ZADAVAT KOEFICIENTY MANUALNE, ALEBO NAHODNE?: M: MANUALNE, N: NAHODNE : ');
readln(vyber);
if (vyber='M') OR (vyber='m') then
begin
writeln('ZADAVAJ KOEFICIENTY AKO CELE CISLA: '); {NACITAVANIE KOEFICIENTOV AK JE ZADANE MANUALNE ZADAVANIE}
for i:=1 to pocet do
  for j:=1 to pocet+1 do
   begin
   if j>pocet then
    begin
     write(' = ');
     readln(matica[i,j]);
    end
   else
    begin
     write(chr(96+j));
     write(i,': ');
     readln(matica[i,j]);
    end;
   end;
end;
if (vyber='N') or (vyber='n') then {NACITAVANIE KOEFICIENTOV AK JE ZADANE RANDOM ZADAVANIE}
begin
 for i:=1 to pocet do
  for j:=1 to pocet+1 do
   matica[i,j]:=random(10)-5;
end;

if (vyber<>'N') AND (vyber<>'n') AND (vyber<>'M') AND (vyber<>'m') then writeln('ZADAL SI NEPLATNY VSTUP!');

writeln;
writeln('SUSTAVA ROVNIC: '); {VYPISANIE SUSTAVY ROVNIC S KOEFICIENTAMI}
for i:=1 to pocet do
 begin
  for j:=1 to pocet+1 do
   begin
   if j>pocet then write(' =',matica[i,j])
   else
    begin
    if matica[i,j]>-1 then write('+',matica[i,j],chr(119+j))
    else write(' ',matica[i,j],chr(119+j));
    end;
   end;
writeln;
end;

writeln;
writeln('MATICA VYTVORENA ZO SUSTAVY: '); {MATICA VYTVORENA ZO SUSTAVY ROVNIC}
vypis;

if pocet=3 then begin      {AK JE MATICA 3X3, VYPOCITAME PODLA SARUSOVHO PRAVIDLA}
D:=(matica[1,1]*matica[2,2]*matica[3,3])+(matica[1,2]*matica[2,3]*matica[3,1])+(matica[1,3]*matica[2,1]*matica[3,2])-(matica[3,1]*matica[2,2]*matica[1,3])-(matica[3,2]*matica[2,3]*matica[1,1])-(matica[3,3]*matica[2,1]*matica[1,2]);
{VYPOCET DETERMINANTU CELEJ MATICA POMOCOU SARUSOVHO PRAVIDLA}
for i:=1 to 3 DO     {VYPOCET PRVEHO CIASTKOVEHO DETERMINANTU}
  pomocne[i]:=matica[i,1];
for i:=1 to 3 DO
  matica[i,1]:=matica[i,4];
determinant[1]:=(matica[1,1]*matica[2,2]*matica[3,3])+(matica[1,2]*matica[2,3]*matica[3,1])+(matica[1,3]*matica[2,1]*matica[3,2])-(matica[3,1]*matica[2,2]*matica[1,3])-(matica[3,2]*matica[2,3]*matica[1,1])-(matica[3,3]*matica[2,1]*matica[1,2]);

for i:=1 to 3 DO    {VYPOCET DRUHEHO CIASTKOVEHO DETERMINANTU}
begin
  matica[i,1]:=pomocne[i];
  pomocne[i]:=matica[i,2];
end;
for i:=1 to 3 DO
  matica[i,2]:=matica[i,4];
determinant[2]:=(matica[1,1]*matica[2,2]*matica[3,3])+(matica[1,2]*matica[2,3]*matica[3,1])+(matica[1,3]*matica[2,1]*matica[3,2])-(matica[3,1]*matica[2,2]*matica[1,3])-(matica[3,2]*matica[2,3]*matica[1,1])-(matica[3,3]*matica[2,1]*matica[1,2]);

for i:=1 to 3 DO    {VYPOCET TRETIEHO CIASTKOVEHO DETERMINANTU}
begin
 matica[i,2]:=pomocne[i];
 pomocne[i]:=matica[i,3];
end;
for i:=1 to 3 DO
  matica[i,3]:=matica[i,4];
determinant[3]:=(matica[1,1]*matica[2,2]*matica[3,3])+(matica[1,2]*matica[2,3]*matica[3,1])+(matica[1,3]*matica[2,1]*matica[3,2])-(matica[3,1]*matica[2,2]*matica[1,3])-(matica[3,2]*matica[2,3]*matica[1,1])-(matica[3,3]*matica[2,1]*matica[1,2]);
writeln('vysledok:[',(determinant[1]/D):2:3,';',(determinant[2]/D):2:3,';',(determinant[3]/D):2:3,']');
end;

if pocet<>3 then begin {AK NIE JE MATICA 3X3, ROZVIJAME MATICU PODLA RIADKA A STLPCA}
for i:=1 to pocet do
 begin
  D:=matica[i,1]

readln;
end.


