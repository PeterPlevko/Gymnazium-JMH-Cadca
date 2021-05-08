{Cviklova Antonia, 4.F,2013/14}
{VST: dane je trojcif. cislo}
{VYS: ciferny sucet cisel}

PROGRAM CIF_SUC_3CIF_CISLA;
USES CRT;
VAR cislo, cislo_2 : integer;
BEGIN
CLRSCR;
WRITELN('Program na ciferny sucet trojciferneho cisla');
WRITELN('____________________________________________');
WRITELN;
WRITELN;
WRITE('Zadaj trojciferne cislo: ');
READ(cislo);
CLRSCR;
WRITELN('Program na ciferny sucet trojciferneho cisla');
WRITELN('____________________________________________');
WRITELN;
WRITELN;
cislo_2:=cislo_2+cislo MOD 10;
cislo:=cislo DIV 10;
READLN;
READLN;
END.