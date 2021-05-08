program kombinacne_cislo;
uses crt;
var         n,k:integer;
         anonie:char;
kombinacnecislo:real;

 function faktorial (k:integer):longint;
 var i,m:longint;
 begin
 m:=1;
 for i:=m to k do m:=m*i;
 faktorial:=m;
 end;

begin
repeat
clrscr;
write('                        zadaj celkovy pocet n: ');
readln(n);
write('                        Zadaj pocet prvkov v skupine k: ');
read(k);
kombinacnecislo:=faktorial(n)/faktorial(n-k)/faktorial(k);
writeln('                        pocet moznosti je ',trunc(kombinacnecislo));
 repeat
  gotoxy(1,20);
  write ('Ak chces pokracovat napis A ak nie tak napis N: ');
  anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.