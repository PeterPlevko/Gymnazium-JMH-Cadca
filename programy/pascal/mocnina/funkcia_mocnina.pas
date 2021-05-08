program mocnina;
uses crt;
var x,n:integer;
function x_na_n(zaklad, expo:integer):integer;
var i,vys:integer;
begin
vys:=zaklad;
i:=1;
repeat
vys:=vys*zaklad;
i:=i+1
until (i=exp);
x_na_n:=vys;
end;
begin
CLRSCR;
readln(x,n);
writeln(x_na_n(x,n));
readln;
end.