{Peter Plevko, Septima A, 2017/2018}
{Program olympijsky zaznam}
{Vstupne udaje : informacie o sportovcoch}
{Vystupne udaje: tabulka s udajmi}
Program Zaznam_bezcov;
uses crt;

Type udaje          = Record
meno                : String;
priezvisko          : String;
statna_prislusnost  : String;
rok                 : string;
                         End;

var
     subor:text;
     riadok,cislo:string;
     osoba:udaje;
     j,kkti,kamil,vymaz,hrac,bezec,i,nas_vyber1,nas_vyber,pocet,n:Integer;
     anonie,odpoved:Char;
     pole:Array[1..50] of udaje;

Procedure Meno_Programu;
Begin
 clrscr;
 writeln;
 writeln('                                Zoznam Bezcov');
 writeln;
End;

Procedure Pridat_Zaznam;
Begin
 i:=0;
 repeat
 Meno_Programu;
 i:=i+1;
 with osoba do
  Begin
   writeln('Zadaj udaje ',i,'. bezca');
   write('Priezvisko: ');
   readln(priezvisko);
   write('Meno: ');
   readln(meno);
   write('Statna prislusnost: ');
   readln(statna_prislusnost);
   write('Rok narodenia: ');
   readln(rok);
  End;
  pole[i]:=osoba;
  writeln;
  writeln('Pre ukoncenie zapisovania bezcov Stlac a');
  readln(odpoved);
  until (odpoved='a');
  pocet:=i;
End;

Procedure Vypis_Tabulky1;
Begin

 Meno_Programu;
 gotoxy(8,4);
 write('ษออออออออออออออหออออออออออหอออออออหอออออออออออออหออออออออออออออออออป');
 gotoxy(8,5);
 write('บPoradove Cislo');
 gotoxy(23,5);
 write('บPriezvisko');
 gotoxy(34,5);
 write('บMeno');
 gotoxy(42,5);
 write('บRok Narodenia ');
 gotoxy(56,5);
 write('บStatna prislusnostบ ');
 gotoxy(8,6);
 write('ศออออออออออออออสออออออออออสอออออออสอออออออออออออสออออออออออออออออออผ');
 for n:=1 to pocet do
  Begin
  gotoxy(9,6+n);
  write(n,'.');
  gotoxy(24,6+n);
  write(pole[n].priezvisko);
  gotoxy(35,6+n);
  write(pole[n].meno);
  gotoxy(43,6+n);
  write(pole[n].rok);
  gotoxy(57,6+n);
  write(pole[n].statna_prislusnost);
  writeln;
  End;
End;

Begin
repeat
 Meno_Programu;
 writeln('MENU');
 writeln('Pridat zaznam     =>1');
 writeln('Zmenit zaznam     =>2');
 writeln('Zmazat zaznam     =>3');
 writeln('Vypnutie programu =>4');
 writeln('Zapisat do suboru =>5 nefunguje            ');
 writeln('Precitat zo suboru=>6 nefunguje            ');
 write('Zadal si: ');
 readln(nas_vyber);
 case nas_vyber of
  1:Begin
     Pridat_Zaznam;
    End;
  2:begin
  writeln('Umiestnenie hraca kroteho udaje chces zmenit');
  write('Hrac: ');
  readln(hrac);
  n:=hrac;
  writeln('Co chces zmenit ?');
  writeln('Menu');
  writeln('Priezvisko        :1');
  writeln('Meno              :2');
  writeln('Rok               :3');
  writeln('Statna prislusnost:4');
  write('Zadal si: ');
  readln(nas_vyber1);
  case  nas_vyber1 of 1: begin
                         with osoba do begin
                         write('Napis nove priezvisko: ');
                         readln(pole[n].priezvisko);
                         end;
                         end;
                      2: begin
                         with osoba do begin
                         write('Napis nove meno: ');
                         readln(pole[n].meno);
                         end;
                         end;
                      3: begin
                         with osoba do begin
                         write('Napis novy rok:  ');
                         readln(pole[n].rok);
                         end;
                         end;
                      4: begin
                         with osoba do begin
                         write('Napis novu statnu prislusnost');
                         readln(pole[n].statna_prislusnost);
                         end;
                         end;
                       end;
                       end;
  3:begin
     writeln('Zadaj porardove cislo sportovca ktoreho chces vymazat');
     writeln('Zadal si: ');
     readln(vymaz);
     n:=vymaz;
     kkti:=n;
     with osoba do begin
     kamil:=1;
     pole[n].priezvisko:=' ';
     pole[n].meno:=' ';
     pole[n].rok:=' ';
     pole[n].statna_prislusnost:=' ';
     end;
     end;
  4: begin
     break;
     end;
  5: begin
     clrscr;
     {otvorime a prepiseme subor}
     assign (subor,'zoznam1.txt' );
     rewrite(subor);
     repeat
    {precita z klavesnice}
    readln(cislo);
    {zapiseme ho do suboru}
     write(subor,cislo);
    {zadanim nuly sa program ukonci}
    until cislo='0';
    close(subor);

     end;

   6: begin

       clrscr;
        {priradime premennej konkretny  subor}
       assign(subor,'zoznam1.txt');
      {otvorime ho na citanie}
      reset (subor);
      {kym nieje koniec suboru}
      while not eof (subor)do begin
      {precitame riadok zo suboru}
      readln(subor,riadok);
     {napiseme riadok na obrazovku}
  {   riadok[1] := ' ';
     for i:= 1 to length(riadok)do
     riadok[i]:=riadok[i]; }
writeln(riadok);
end;
{zatvorime subor}
close(subor);
readln;

       end;
 End;

 Vypis_Tabulky1;
 if kamil=1 then
  gotoxy(9,6+kkti);
  writeln('          ');

     repeat
   gotoxy(1,25);
   write ('Ak chces pokracovat napis A ak nie tak napis N: ');
   anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.
