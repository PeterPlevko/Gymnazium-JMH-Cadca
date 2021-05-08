{Peter Plevko, Septima A, Sk. rok 2016/17
 Program na zistenie poctu znakov, slov, viet
 Vstupne podmienky: retazec znakov
 Vystupne podmienky: zisteny vysledok}
program pocet_slov_vo_vete;
uses crt;
     var anonie:char;
         pocet,pocet2,pocet1,i,j:integer;
         veta,s:string;


 begin
 repeat
 clrscr;
  writeln('               *********************************************');
  writeln('               *  Vypise pocet znakov, slov, viet vo vete  *') ;
  writeln('               *********************************************') ;
  writeln;
 write('napis vetu: ');
 readln(s);
 veta:=s;
 pocet:=0;

  if s[1]<> ' ' then pocet:=pocet+1;
  for j:=1 to length(s)
  do begin if (s[j]=' ') and (s[j+1]<>' ')then pocet:=pocet+1;
  end;

  writeln('pocet slov je: ',pocet);
  for i:=1 to length(veta) do begin if (veta[i] <> ' ') then pocet1:=pocet1+1;
  end;

  writeln('pocet znakov vo vete je : ' ,pocet1);
  for i:=1 to length(veta) do begin if (veta[i] = '.' ) or (veta[i]='?') or (veta[i]='!') then pocet2:=pocet2+1;
  end;
  writeln('pocet viet je: ',pocet2);

  repeat
   gotoxy(1,20);
   write ('Ak chces pokracovat napis A ak nie tak napis N: ');
   anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.
