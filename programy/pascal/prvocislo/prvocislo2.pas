{Monika Steinigerova 2.E, sk.r. 2008/2009}

Program Prvocislo;
uses crt;
Var Cislo,I : Integer;
    Delitelu : Integer;
Begin
 clrscr;
 writeln('     Program na zistenie ci dane cele cislo je prvocislo');
 writeln;
 writeln;
 write('Zadaj cislo : ');
 Readln(Cislo);
 Delitelu:=0;
 writeln;
 clrscr;
 writeln('      Program na zistenie ci dane cele cislo je prvocislo');
 writeln;
 writeln;
For I:=2 to Trunc(Sqrt(Cislo)) do  {Hladame delitele}
   if Cislo mod I = 0 then
      Delitelu:=Delitelu+1;

 if (Delitelu = 0) and (cislo>1) then
     writeln(' Dane cislo ',cislo,' je  prvocislo.')
 else
     Writeln('Dane cislo ',cislo,' nie je prvocislo.');

 {Cislo mensie nez 2 nemoze byt prvocislom, bez ohladu na pocet delitelov}
 Readln;
End.
