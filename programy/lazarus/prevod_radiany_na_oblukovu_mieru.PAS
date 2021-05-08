{Peter Plevko, Septima A, Sk. rok 2016/17
 Program na vypocitanie hodnoty sinusu
 Vstupne podmienky: uhol v stupnoch
 Vystupne podmienky: cele cislo}
program supne_na_radiany;
uses crt;
const pi= 3.14;
var cislo,radian:real;
    anonie:char;


begin
 repeat
 clrscr;
 writeln('********************************************************************************');
 writeln('*                  Program na vypocitanie sinusu                               *');
 writeln('********************************************************************************');
 write('zadaj stupne: ');
 readln(cislo);
 radian:=cislo*(pi/180);
 writeln('Hodnota zadaneho stupna je: ',sin(radian):0:4);
 readln;
  repeat
   clrscr;
   writeln('********************************************************************************');
   writeln('*                  Program na vypocitanie sinusu                               *');
   writeln('********************************************************************************');
   write ('Ak chces pokracovat napis A ak nie tak napis N: ');
   anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.