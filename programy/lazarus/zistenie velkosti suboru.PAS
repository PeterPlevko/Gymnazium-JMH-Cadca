program velkost;
uses crt;
var pocet_prvkov:integer;
 subor:text;
begin
clrscr;
assign (subor,'C:\menoprogramu.tpl');
reset(subor) ;
pocet_prvkov:=0;
while not (eof(subor)) do
begin
pocet_prvkov:=pocet_prvkov+1;
end;
writeln(pocet_prvkov);
readln;
end.