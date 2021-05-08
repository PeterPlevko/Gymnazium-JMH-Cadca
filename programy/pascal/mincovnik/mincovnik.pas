Program mincovnik;
uses crt;
var delenie : array [1..26] of longint;
    plat : array [1..1000] of longint;
    vysledna : array [1..1000] of longint;
    sto5, sto2, sto, desiat5, desiat2, desiat, pet, dva, jeden, cyklus, cyklus2, pocet,
    zaklad3, zvysovanie : longint;
    code : integer;
    retazec : string;

Procedure Nadpis;

begin
 clrscr;
 writeln;
 writeln('                                 Mincovnik');
 writeln('                                 ---------');
 writeln;
end;

begin
textcolor(white);
Delenie[1] := 500; Delenie[2] := 200; Delenie[3] := 100; Delenie[4] := 50;
Delenie[5] := 20; Delenie[6] := 10; Delenie[7] := 5; Delenie[8] := 2;
 repeat
   nadpis;
   write(' Zadaj pocet pracovnikov: ');
   readln (retazec);
   val (retazec, pocet, code);
   If (code <> 0) or (pocet < 1) then begin
    repeat
     Nadpis;
     write(' Zadal si zly pocet, zadaj pocet znova: ');
     readln (retazec);
     val (retazec, pocet, code);
    until (code = 0) and (pocet > 0);
                     end;
   Nadpis;
   for cyklus := 1 to pocet do begin
    Nadpis;
    write(' Zadaj plat ', cyklus, '. pracovn¡ka: ');
    readln (retazec);
    val (retazec, Plat[cyklus], code);
    If (code <> 0) or (Plat[cyklus] < 0) then begin
     repeat
      Nadpis;
      write(' Zadal si zly plat ', cyklus, '. pracovnika,  zadaj plat znova ');
      readln (retazec);
      val (retazec, plat[cyklus], code);
     until (code = 0) and (Plat[cyklus] > -1);
                     end;
                               end;
   vysledna[pocet+1] := 0;
   for cyklus := 1 to pocet do begin
    vysledna[cyklus] := Plat[cyklus];
    vysledna[pocet+1] := vysledna[pocet+1] + Plat[cyklus];
                               end;
   for cyklus := 18 to 26 do
    Delenie[cyklus] := 0;
   Nadpis;
   textcolor(yellow);
   writeln ('         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄ¿');
   writeln ('         ³ Pracovnik Ÿ. ³ 500 ³ 200 ³ 100 ³ 50 ³ 20 ³ 10 ³ 5 ³ 2 ³ 1 ³  Suma  ³');
   writeln ('         ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄ´');
   zvysovanie := 0;
   repeat
   zvysovanie := zvysovanie + 1;
   for cyklus := 1 to 8 do begin
   Delenie[8+cyklus] :=  Plat[zvysovanie]  div Delenie[cyklus];
   Plat[zvysovanie] := Plat[zvysovanie] mod Delenie[cyklus];
                           end;
   Delenie[17] :=  Plat[zvysovanie];
   for cyklus := 18 to 26 do
   Delenie[cyklus] := Delenie[cyklus] + Delenie[cyklus-9];
   writeln ('         ³      ', zvysovanie, '       ³ ', Delenie[9] : 3, ' ³  ', Delenie[10], '  ³  ', Delenie[11], '  ³  ',
   Delenie[12], ' ³  ', Delenie[13], ' ³  ', Delenie[14], ' ³ ', Delenie[15], ' ³ ',
   Delenie[16], ' ³ ', Delenie[17], ' ³  ', vysledna[zvysovanie] : 4, '  ³');
   If zvysovanie <= pocet-1 then
   writeln ('         ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄ´')
                           else
   writeln (' ÚÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄ´');
    until zvysovanie = pocet;

   writeln (' ³ Spolu ³      ', pocet, '       ³ ', Delenie[18] : 3, ' ³  ', Delenie[19], '  ³  ', Delenie[20], '  ³  ',
   Delenie[21], ' ³  ', Delenie[22], ' ³  ', Delenie[23], ' ³ ', Delenie[24], ' ³ ',
   Delenie[25], ' ³ ', Delenie[26], ' ³ ', vysledna[pocet+1] : 5, '  ³');

   writeln (' ÀÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÙ');
   writeln;
   textcolor(green);
   gotoxy(2,24);
   writeln ('Ak chces ukoncit program stlac A');
 until upcase(readkey) = 'A';
end.
