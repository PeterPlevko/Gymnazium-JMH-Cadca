program mnohoclen;            {VYPOCET MNOHOCLENA V DANOM BODE}
uses crt;
var stupen,i,x,vysledok,j:integer;
koeficient:array[1..100,1..100] of integer;
begin
CLRSCR;
write('zadaj stupen mnohoclena: ');
readln(stupen);
stupen:=stupen+1;
write('zadaj koeficienty: ');
for i:=1 TO stupen DO read(koeficient[1,i]);
write('zadaj v ktorom bode chces vypocitat mnohoclen: ');
readln(x);
vysledok:=0;
{for i:=1 to stupen DO
     vysledok:=koeficient[1,i]+(vysledok*x);
writeln('vysledok = ',vysledok); }

for i:=1 to stupen DO
  begin
    vysledok:=koeficient[1,i]+(vysledok*x);
    koeficient[2,i]:=vysledok;
  end;
writeln('vysledok=',vysledok);

{for i:=1 to (stupen-1) DO
  begin
    vysledok:=koeficient[2,i]+(vysledok*x);
    koeficient[3,i]:=vysledok;
  end;
writeln(  }
readln;
end.


