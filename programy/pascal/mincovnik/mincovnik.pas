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
    write(' Zadaj plat ', cyklus, '. pracovn�ka: ');
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
   writeln ('         ��������������������������������������������������������������������Ŀ');
   writeln ('         � Pracovnik �. � 500 � 200 � 100 � 50 � 20 � 10 � 5 � 2 � 1 �  Suma  �');
   writeln ('         ��������������������������������������������������������������������Ĵ');
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
   writeln ('         �      ', zvysovanie, '       � ', Delenie[9] : 3, ' �  ', Delenie[10], '  �  ', Delenie[11], '  �  ',
   Delenie[12], ' �  ', Delenie[13], ' �  ', Delenie[14], ' � ', Delenie[15], ' � ',
   Delenie[16], ' � ', Delenie[17], ' �  ', vysledna[zvysovanie] : 4, '  �');
   If zvysovanie <= pocet-1 then
   writeln ('         ��������������������������������������������������������������������Ĵ')
                           else
   writeln (' ����������������������������������������������������������������������������Ĵ');
    until zvysovanie = pocet;

   writeln (' � Spolu �      ', pocet, '       � ', Delenie[18] : 3, ' �  ', Delenie[19], '  �  ', Delenie[20], '  �  ',
   Delenie[21], ' �  ', Delenie[22], ' �  ', Delenie[23], ' � ', Delenie[24], ' � ',
   Delenie[25], ' � ', Delenie[26], ' � ', vysledna[pocet+1] : 5, '  �');

   writeln (' ������������������������������������������������������������������������������');
   writeln;
   textcolor(green);
   gotoxy(2,24);
   writeln ('Ak chces ukoncit program stlac A');
 until upcase(readkey) = 'A';
end.
