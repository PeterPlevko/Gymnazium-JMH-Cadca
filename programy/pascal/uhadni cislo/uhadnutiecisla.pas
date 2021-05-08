{Dalibor Jarabica III.D 2014/2015}
{VST:Zadaj cislo}
{VYS:Rovnake cislo ako zadal PC}





program uhadnutie_cisla_z_daneho_intervalu;
uses crt;
var cislo,pom:integer;
begin
 randomize;
  clrscr;
  writeln('                          Hadanie cisla ');
  writeln('                          ______________');
  writeln;
  writeln;
  writeln;
  writeln;
  writeln;
  writeln;
  writeln('Zadaj cislo od 1 do 5 :');
  read(cislo);
  clrscr;
  writeln('                          Hadanie cisla ');
  writeln('                          ______________');
  writeln;
  writeln;
  writeln;
  writeln;
  writeln;
  writeln;
  pom:=random(5)+1;
  writeln;
  writeln;
  writeln;
  if pom=cislo then writeln('cisla sa rovanju')
               else writeln('cisla sa nerovnaju');
  writeln;
  writeln;
  writeln;
  repeat
      if cislo>pom then writeln('zadali ste vacsie cislo ako PC zadaj znova cislo')
                   else writeln('zadali ste menise cislo ako pc zadaj znova cislo');
      writeln;


      read(cislo);
  until cislo=pom;
  writeln;
  repeat
    if cislo=pom then writeln('uhadli ste cislo');
                 writeln('PC zadal cislo',cislo);
    writeln;


  until cislo=pom;


  readln;
  readln;
end.












