{Monika Suskova }
program ZLOMOK;
 uses crt;
 var citatel,menovatel,citt,menn,vacsi,mensi,zvysok:integer;
 function NSD(cit,men:integer):integer;


begin
 if cit>men then
              begin
               vacsi:=cit;
               mensi:=men;
              end
            else
              begin
               vacsi:=men;
               mensi:=cit;
              end;
 repeat
  zvysok:= vacsi mod mensi;
  if zvysok<>0 then
                 begin
                  vacsi:=mensi;
                  mensi:=zvysok;
                 end
               else NSD:=mensi;
 until zvysok=0;
 end;
procedure nadpis;
 begin
  clrscr;
  writeln;
  writeln;
  write(                                'Program na zjednodusenie zlomku');
  writeln;
  writeln;
 end;

begin
 nadpis;
 write('Zadaj citatela (vacsieho ako 0) = ');
 read(citatel);
 writeln;
 write('Zadaj menovatela (vacsieho ako 0) : ');
 read(menovatel);
 citt:=citatel;
 menn:=menovatel;
 if NSD(citt,menn)=1 then
                       begin
                        nadpis;
                        write('Zlomok ',citatel,'/',menovatel,' je v zakladnom tvare')
                       end
                     else
                       begin
                        citatel:=citatel div NSD(citt,menn);
                        menovatel:=menovatel div NSD(citt,menn);
                        nadpis;
                        write('Zjednoduseny zlomok je : ',citatel,'/',menovatel);
                       end;
 readln;
 readln;
end.


