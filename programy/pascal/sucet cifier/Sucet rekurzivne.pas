program sucet_rekurzivne;         {S POUZITIM REKURZIE SCITAME 2 CISLA IBA S 1 PREMENNOU}
uses crt;
var a:integer;
procedure Sucet(var a:integer);
begin
  a:=a-1;
  if a>0 then Sucet(a)
         else begin
           write('zadaj 2. cislo: ');
           readln(a);
           end;
  a:=a+1;
end;
begin
CLRSCR;
write('zadaj 1. cislo: ');
readln(a);
Sucet(a);
writeln(a);
readln;
end.