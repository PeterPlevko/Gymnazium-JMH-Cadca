{Olesnanikova Pavlina,2.C,Sk.rok:2012/13}
{Program na urcenie Armstrongovho cila}

PROGRAM Armstrongovo_cislo;
USES CRT;
VAR CISLO,DESIATKY,STOVKY,JEDNOTKY,POMOCNA:INTEGER;
BEGIN
 CLRSCR;
 WRITELN('                     Program na urcenie Armstrongovho cisla');
 WRITELN('                     ______________________________________');
 WRITELN;
 WRITELN;
 WRITELN;
 WRITE('Zadaj trojciferne cislo: ');
 READLN(CISLO);
 CLRSCR;
 WRITELN('                     Program na urcenie Armstrongovho cisla');
 WRITELN('                     ______________________________________');
 WRITELN;
 WRITELN;
 WRITELN;
 STOVKY:=CISLO DIV 100;
 POMOCNA:=CISLO MOD 100;
 DESIATKY:=POMOCNA DIV 10;
 JEDNOTKY:=POMOCNA MOD 10;
 WRITELN;
 WRITELN;

 WRITELN;
 WRITELN;
 WRITE('Stlac klavesu enter');
 WRITELN;
 WRITELN;
 READLN;
 READLN;
 END.
