program precitanie;
uses crt;
var
j,i:integer;
subor:text;
riadok:string;
begin
clrscr;
{priradime premennej konkretny  subor}
assign(subor,'zoznam1.txt');
{otvorime ho na citanie}
reset (subor);
{kym nieje koniec suboru}
while not eof (subor)do begin
{precitame riadok zo suboru}
readln(subor,riadok);
{napiseme riadok na obrazovku}
riadok[1] := ' ';
for i:= 1 to length(riadok)do
riadok[i]:=riadok[i];


writeln(riadok);


end;
{zatvorime subor}
close(subor);
readln;
end.