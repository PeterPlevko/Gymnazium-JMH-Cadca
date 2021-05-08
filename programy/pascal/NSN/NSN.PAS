{Program na zistenie najmensieho spolocneho nasobku dvoch cisel
Jozef Sustek II.E 2005\2006}
Program Na_zistenie_najmensieho_spolocneho_nasobku;
uses crt;
var cislo1:longint;
    cislo2:longint;
    x,y:longint;
    z:integer;
    va:longint;
    me:longint;
    x1:longint;


begin
  clrscr;
  Writeln('        Program na zistenie najmensieho spolocneho nasobku dvoch cisel');
  writeln;
  writeln;
  Writeln('Zadaj prve cislo');
  read(cislo1);
 while cislo1<0 do  begin writeln('Zadal si zaporne cislo, zadaj kladne');
                     read(cislo1);
                   end;
  writeln;
  writeln('Zadaj druhe cislo');
  read(cislo2);
 while cislo2<0 do  begin writeln('Zadal si zaporne cislo, zadaj kladne');
                     read(cislo2);
                   end;
  x:=1;y:=1;z:=2;x1:=1;
if cislo1>cislo2 then begin va:=cislo1;me:=cislo2;end;
                 
if cislo1<cislo2 then begin va:=cislo2;me:=cislo1;end;

repeat y:=va*x1;x1:=x1+1;
  repeat x:=me*z;z:=z+1;
  until  y<=x;
 until  x=y;
 clrscr;
 Writeln('        Program na zistenie najmensi spolocneho nasobku dvoch cisel');
  writeln;
  writeln;
  readln;
  if cislo1=cislo2 then writeln('Najmensi spolocny nasobok cisla ',cislo1,' a ', cislo2,'je  ',cislo1);
  if cislo1<>cislo2 then Writeln('Najmensi spolocny nasobok cisla ',cislo1,' a ', cislo2,' je ',x);
  readln;
end.
