{Natália Mitková, 2.D 2014/15}
{Program: Zrkadlovy obraz čísla}


 program zrkadlo;
 uses crt;
 var CISLO:REAL;
     POM, CISLO_1:INTEGER;
     spru:char;
 BEGIN
  repeat
  CLRSCR;
  writeln('                    ZRKADLOVY OBRAZ CISLA');
  writeln('                    _____________________');
  writeln;
  writeln;
  write('ZADAJ CISLO: ');
  readln(CISLO);
  CISLO_1:=TRUNC(CISLO);
  while((CISLO<0) or (CISLO<>TRUNC(CISLO))) do
   begin
   if (CISLO<0) then WRITE('ZADAL SI ZAPORNE CISLO, ZADAJ ZNOVA: ');
   if (CISLO<>TRUNC(CISLO)) then  WRITE('ZADAJ SI DESATINNE CISLO, ZADAJ ZNOVA: ');
                READ(CISLO);
   END;



  POM:=0;
  clrscr;
  writeln('                    ZRKADLOVY OBRAZ CISLA');
  writeln('                    _____________________');
  writeln;
  writeln;
while (CISLO_1 > 0)  do begin
                        POM:=(CISLO_1 mod 10);
                        WRITE(POM);
                        CISLO_1:=(CISLO_1 div 10);
                         end;
writeln(' je zrkadlovy obraz cisla ',CISLO:6:0,' ');
 writeln;
 writeln;
 writeln;
 writeln;
 write('Pre pokracovanie v programe stlac Enter, ak chces pokracovat stlac k');
 until readkey=('k');
 end.
