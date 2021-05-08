{Program na zistenie najvacsieho spolocneho delitela dvoch cisel
Jozef Sustek II.E 2005\2006}
Program Zistenie_najvacsieho_spolocneho_delitela;
uses    crt;
var     cislo1:longint;
        cislo2:longint;
        a,b:longint;


begin
  clrScr;
  writeln('  Program na zistenie najvacieho spolocneho delitela dvoch cisel');
  writeln;
  writeln;
  writeln('Zadaj prve cislo');
  read(a);
 while a<0 do begin writeln('Zadal si zaporne cislo, zadaj kladne');
                    read(a);
              end;
  writeln;
  writeln('Zadaj druhe cislo');
  read(b);
 while b<0 do begin writeln('Zadal si zaporne cislo, zadaj kladne');
                    read(b);
              end;
  cislo1:=a;
  cislo2:=b;


 repeat if cislo1>=cislo2  then cislo1:=cislo1 mod cislo2
                           else cislo2:=cislo2 mod cislo1
 until (cislo1=0) or (cislo2=0);
 if cislo1=0 then cislo1:=cislo2;
  clrScr;
  writeln('   Program na zistenie najvacieho spolocneho delitela dvoch cisel');
  writeln;
  writeln;
  writeln('nsd(',a,',',b,')=',cislo1);
  readln;
  readln;
 end.