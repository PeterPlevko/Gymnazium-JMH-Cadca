program jedna;
uses crt;
var cislo:integer;
    vyber:integer;
    zvysok,i,n:byte;
    pole: array [1..20] of integer;
    pole2: array [1..20] of char;
begin
n:=1;
clrscr;
writeln('Zadaj volbu');
writeln('1: prevod z 10 sustavy na 2');
writeln('2: prevod z 10 sustavy na 8');
writeln('3: prevod z 10 sustavy na 16');
readln(vyber);
case vyber of
1:
begin
writeln('Zadaj cislo');
readln(cislo);
repeat
for i:=1 to 20 do begin
zvysok:=cislo mod 2;
cislo:=cislo div 2;
pole[i]:=zvysok;
end;
until zvysok=0;
end;


2:
begin
writeln('Zadaj cislo');
readln(cislo);
repeat
for i:=1 to 20 do begin
zvysok:=cislo mod 8;
cislo:=cislo div 8;
pole[i]:=zvysok;
end;
until zvysok=0;
end;


3:
begin
writeln('Zadaj cislo');
readln(cislo);
repeat
for i:=1 to 20 do begin
zvysok:=cislo mod 16;
cislo:=cislo div 16;
pole[i]:=zvysok;

end;
until zvysok=0;
end;

end;

writeln('Vypis :');
for i:=1 to 10 do begin
write(' ',pole[i]) ;
end;
readln;
end.