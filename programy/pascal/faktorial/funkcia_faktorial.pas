program faktorial;
uses crt;
var cislo:integer;
function fakt(a:integer):integer;
    var i,f:integer;
    begin
    f:=1;
    for i:=1 TO a DO f:=f*i;
    fakt:=f;
    end;

begin
CLRSCR;
write('zadaj cislo ');
readln(cislo);
writeln('faktorial tohto cisla je ',fakt(cislo));
readln;
end.

