{Cviklova Antonia,4.F,2013}
{VST: dane je cislo}
{VYS: ci je cislo parne alebo nie}
PROGRAM PARNE_CISLO;
USES CRT;
VAR cislo : integer;

BEGIN
CLRSCR;
WRITELN('                         Program na urcenie parneho cisla');
WRITELN('                         ________________________________');
WRITELN;
WRITELN;
WRITE ('Zadaj realne cislo: ');
READ (cislo);
CLRSCR;
WRITELN('                         Program na urcenie parneho cisla');
WRITELN('                         ________________________________');
WRITELN;
WRITELN;
IF cislo MOD 2 = 0 THEN WRITELN('Cislo ',cislo,' je parne.')
                   ELSE WRITELN('Cislo ',cislo,' je neparne.');
GOTOXY(1,20);
WRITE ('PRE UKONCENIE PROGRAMU STLAC KLAVESU ENTER');
READLN; {pre zastavenie obrazovky}
READLN;
END.
