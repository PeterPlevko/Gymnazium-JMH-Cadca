{Nikola Kubackova, 3.D, 2016/2017}
{Hra kamen,papier,noznice}

PROGRAM Hra_kamen_papier_noznice;
USES crt;
VAR x,Hrac,PC:integer;
    znak:char;

BEGIN

 clrscr;
 REPEAT
 writeln;
 writeln('                      Vitajte v hre Kamen,papier,noznice');
 writeln('                      __________________________________');
 writeln;
 writeln;
 writeln('      Pre kamen zadajte cislo 1,pre papier cislo 2 a pre noznice cislo 3');
 writeln;
 Write  ('  Hrac: ');
 read(Hrac);
 Write  ('  PC : ');
 PC:=random(3)+1;
 write(PC);

 IF(Hrac=1) AND (PC=2) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste kamen a PC zadal papier');
   writeln;
   writeln('  Prehrali ste');
   writeln('  ------------');
   END;

 IF(Hrac=2) AND (PC=3) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste papier a PC zadal noznice');
   writeln;
   writeln('  Prehrali ste');
   writeln('  ------------');
   END;

 IF(Hrac=1) AND (PC=3) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste kamen a PC zadal noznice');
   writeln;
   writeln('  Vyhrali ste');
   writeln('  -----------');
   END;

 IF(Hrac=3) AND (PC=1) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste noznice a PC zadal kamen');
   writeln;
   writeln('  Prehrali ste');
   writeln('  ------------');
   END;

 IF(Hrac=1) AND (PC=1) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste kamen aj PC zadal kamen');
   writeln;
   writeln('  Doslo k remize');
   writeln('  --------------');
   END;

 IF(Hrac=2) AND (PC=1) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste papier a PC zadal noznice');
   writeln;
   writeln('  Prehrali ste');
   writeln('  ------------');
   END;

 IF(Hrac=2) AND (PC=2) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste papier aj PC zadal papier');
   writeln;
   writeln('  Doslo k remize');
   writeln('  --------------');
   END;

 IF(Hrac=3) AND (PC=3) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste noznice aj PC zadal noznice');
   writeln;
   writeln('  Doslo k remize');
   writeln('  --------------');
   END;

 IF(Hrac=3) AND (PC=2) THEN
   BEGIN
   writeln;
   writeln('  Zadali ste noznice a PC zadal papier');
   writeln;
   writeln('  Vyhrali ste');
   writeln('  -----------');
   END;

 writeln;
 writeln('  Pre opakovanie programu stlacte "A", pre ukoncenie programu "N".');
 znak:=(upcase(readkey));
 clrscr;
   UNTIL (znak='N');

 END.
