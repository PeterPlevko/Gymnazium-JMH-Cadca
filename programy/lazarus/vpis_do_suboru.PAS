program vpisdo;
uses crt;
var
cislo:string;
subor: file of string;
begin
clrscr;
{otvorime a prepiseme subor}
assign (subor,'zoznam1.txt' );
rewrite(subor);
repeat
{precita z klavesnice}
 readln(cislo);
{zapiseme ho do suboru}
write(subor,cislo);
{zadanim nuly sa program ukonci}
until cislo='0';
close(subor);
end.