{Gaborova Sona, II.D, 2017/2018}
{Najvacsi spolocny delitel a najmensi spolocny nasobok dvoch Z+cisel}
{VST: Dane su dve Z+ cisla}
{VYS: NSN a NSD zadanych Z+ cisel}

program NSN_a_NSD_dvoch_celych_kladnych_cisel;
uses crt;
var cislo1,cislo2,NSN:real;
    cis1,cis2,NSD:longint;
    pismeno:char;

begin
 REPEAT
 clrscr;
 writeln('                  Urcenie NSD a NSN dvoch celych kladnych cisel');
 writeln('                  _____________________________________________');
 writeln;
 writeln('Program urci najvacsieho spolocneho delitela a najmensi spolocny nasobok dvoch celych kladnych cisel');
 writeln;
 writeln;
 write('Zadajte prve  cele kladne cislo:  ');
 readln(cislo1);
 {ochrana vstupnych udajov}
 while(cislo1 <> trunc(cislo1)) or (cislo1 < 0) do
   begin writeln('Zadali ste nespravne cislo.');
         write('Zadajte lubovolne CELE KLADNE cislo:  ');
         readln(cislo1);
   end;
 {koniec ochrany vstupnych udajov}
 write('Zadajte druhe cele kladne cislo:  ');
 readln(cislo2);
 {ochrana vstupnych udajov}
 while(cislo2 <> trunc(cislo2)) or (cislo2 < 0) do
   begin writeln('Zadali ste nespravne cislo.');
         write('Zadajte lubovolne CELE KLADNE cislo:  ');
         readln(cislo2);
   end;
 {koniec ochrany vstupnych udajov}

 clrscr;
 writeln('                  Urcenie NSD a NSN dvoch celych kladnych cisel');
 writeln('                  _____________________________________________');
 writeln;
 writeln;

 cis1:=trunc(cislo1);
 cis2:=trunc(cislo2);
 while (cis1<>cis2) do
   repeat
       if (cis1>cis2) then cis1:=cis1-cis2;
       if (cis2>cis1) then cis2:=cis2-cis1;
   until (cis1=cis2);

 writeln('NSD (',cislo1:4:0,',',cislo2:4:0,') = ',cis1);
 writeln;
 NSN:=((cislo1*cislo2)/(NSD));   {vyhadzuje z programu}
 writeln('NSN (',cislo1:4:0,' , ',cislo2:4:0,') = ',NSN:4:0);

 gotoxy(1,22);
 write('Ak chcete pokracovat v programe stlacte klavesu A, ak nie stlacte klavesu N');
 pismeno:=readkey;
 pismeno:=upcase(pismeno);
 while ((pismeno) <> 'A') and ((pismeno) <> 'N') do
  begin
   writeln('Stlacili ste nespravnu klavesu.');
   writeln('Pre ukoncenie programu stlacte N, pre pokracovanie stlacte A.');
   pismeno:=readkey;
   pismeno:=upcase(pismeno);
   end;
 UNTIL pismeno='N';
end.