program zasobnik;
uses crt;
type  Uk=^ zaznam;
       zaznam = record
          meno: string;
          vyska: integer;
          dalsi:uk;
       end;

var zas,novy,pom : uk;
    odpoved:char;
    a,x:byte;

procedure napln;
begin
  clrscr;
  writeln;
  writeln('                           Program Zasobnik');
  writeln;
  new(novy);
  gotoxy(20,4);
  write('Zadaj meno  :  ');
  read(novy^.meno);
  gotoxy(20,6);
  write('Zadaj vysku  :  ');
  read(novy^.vyska);
  novy^.dalsi:=zas;
  zas:=novy;
  readln;
end;

procedure vypis;
var n:byte;
begin
  clrscr;
  n:=4;
  writeln;
  writeln('                           Program Zasobnik');
  writeln;
  pom:=novy;
  while pom<>nil do
  begin
    gotoxy(20,n);
    write('Meno : ',pom^.meno,'    ');
    gotoxy(40,n);
    writeln('Vyska : ',pom^.vyska);
    pom:=pom^.dalsi;
    inc(n);
  end;
  readln;
end;

procedure vymaz;
var zly:UK;
begin
  clrscr;
  if novy<> nil then
    begin
      zly:=novy;
      novy:=novy^.dalsi;
      Dispose(zly)
    end;
  writeln;
end;

begin
  clrscr;
  zas:=nil;
  novy:= nil;
  writeln;
  repeat
  clrscr;
  writeln;
  writeln('                           Program Zasobnik');
  writeln;
  writeln('1 - Novy');
  writeln('2 - Vypis');
  writeln('3 - Vymazanie');
  writeln('0 - Koniec');
  write('Zadaj volbu : ');
  readln(a);
  clrscr;
  case a of
  1: repeat
       napln;
       x:=0;
       repeat
         gotoxy(22,10);
         write('Chces pokracovat? (A/N)');
         odpoved:=readkey;
         if (odpoved='a')or(odpoved='A') then begin
                                                textcolor(green);
                                                gotoxy(41,10);
                                                write('A');
                                                delay(1000);
                                                textcolor(lightgray);
                                                x:=1;
                                              end;
         if (odpoved='n')or(odpoved='N') then begin
                                                x:=5;
                                                textcolor(red);
                                                gotoxy(43,10);
                                                write('N');
                                                delay(1000);
                                                textcolor(lightgray);
                                              end;

       until x>0;
       writeln;
     until x=5;
  2: vypis;
  3: vymaz;
  end;
  until a=0;
end.