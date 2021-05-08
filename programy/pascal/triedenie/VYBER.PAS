Program Triedenia;
uses crt;
     var moznost,n:integer;
         pomocna:integer;
          var i,j,pocetcisel:Integer;
              hotovo:Boolean;
              odpoved:Char;
              cisla:array [1..100] of Integer;

Procedure Vypis_Pola;
 Begin
   n:=0;
   for n:=1 to pocetcisel do
    Begin
     write(  cisla[n],' ');
    End;
 End;

Procedure Meno_Programu;
 Begin
  clrscr;
  writeln;
  writeln('                               TRIEDENIA');
  writeln('                           *****************');
  writeln('              Program podla vyberu zoradi cisla vzostupne.');
  writeln;
 End;

Procedure Bubble_Sort;
Begin
for i:=1 to pocetcisel do
 Begin
 for j:=1 to pocetcisel-i do
   Begin
      if cisla[j]>cisla[j+1] then
      Begin
      pomocna:=cisla[j];
      cisla[j]:=cisla[j+1];
      cisla[j+1]:=pomocna;
      Vypis_pola;
      writeln;
      End;
   End;
 End;
End;

Procedure Insert_Sort;
 Begin
   for j:=2 to pocetcisel do
  Begin
    pomocna:=cisla[j];
    i:=j-1;
     while (i>=1) do
      Begin
         if (pomocna<cisla[i]) then
           Begin
             cisla[i+1]:=cisla[i];
             i:=i-1
           End
         else
           break;
      End;
   cisla[i+1]:=pomocna;
 Vypis_Pola;
 writeln;
 End
End;

Procedure Max_Min;
 var I,J,maxindex,Y,pom:integer;
   Begin
    for I:=pocetcisel downto 2 do
      Begin
        maxindex := I;
        for J :=1 to I do
          Begin
          if (cisla[J] > cisla[maxindex]) then
            Begin
              maxindex:= J;
            End;
            End;
        pom:=cisla[I];
        cisla[I]:=cisla[maxindex];
        cisla[maxindex] :=pom;
        Vypis_pola;
        writeln;
      End
 End;

Begin
repeat
Meno_Programu;
 write('Pocet cisel(maximum 100):'); readln(pocetcisel);
if pocetcisel>100 then
   Begin
    Meno_Programu;
    writeln('Pocet cisel nesmie byt vacsie nez 100.');
    write('Zadaj znova:'); readln(pocetcisel);
   End;
n:=0;
for i:=1 to pocetcisel do
    Begin
     n:=n+1;
     write('Zadaj ',n,'.cislo:'); readln(cisla[i]);
    End;
writeln;
Meno_Programu;
writeln(' Cisla,ktore si zadal:');
Vypis_pola;
writeln;
writeln;
writeln(' * Moznost 1: Bubble Sort');
writeln(' * Moznost 2: Insert Sort');
writeln(' * Moznost 3: Select Sort'); writeln;
write('Vyber moznost:'); readln(moznost);
Meno_Programu;
writeln(' Cisla,ktore si zadal:');
Vypis_Pola;
writeln;
writeln;
case moznost of
1: Bubble_Sort;
2: Insert_Sort;
3: Max_Min;
End;
writeln;
writeln('Usporiadanie cisel podla ',moznost,' triedenia:');
Vypis_Pola;

gotoxy(1,20);
write('Chces pokracovat? a/n:');
 repeat
  odpoved:=readkey;
  if (odpoved<>'a') and (odpoved<>'n') then
    Begin
    clrscr;
    Meno_programu;
    write('Zadali ste nespravny znak. Zadaj znovu (a/n):');
    End;
  until (odpoved='n') or (odpoved='a')
until(odpoved='n');
readln;
End.