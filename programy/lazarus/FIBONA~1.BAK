{Peter Plevko, Septima A, Sk. rok 2017/18
 Program vypocita lubovolne cislo fibonaciho postupnosti ktore uzivatel zada
 Vstupne podmienky: poradie vo fibonaciho postupnosti
 Vystupne podmienky: zadane cislo v poradi }
program fibonaciho_postupnost;
uses crt;
var i,pocet:longint;
    anonie :char;
POLE: array [0..100] of longint;
begin
 repeat
 clrscr;
 write('               Zadaj kolke cislo z fibonaciho postupnosti chces: ');
 readln(pocet);
 POLE[0]:=0;
 POLE[1]:=1;
 for i:=2 to pocet do POLE[i]:=POLE[i-1] + POLE[i-2];
 writeln('                    ',pocet,' Cislo vo fibonaciho postupnosti je: ',POLE[pocet]);
  repeat
  gotoxy(1,20);
  write ('Ak chces pokracovat napis A ak nie tak napis N: ');
  anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.