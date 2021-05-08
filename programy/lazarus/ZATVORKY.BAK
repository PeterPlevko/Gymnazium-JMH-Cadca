{Peter Plevko, Septima A, Sk. rok 2016/17
 Program na zistenie spravneho odzatvorkovania vyrazu
 Vstupne podmienky: retazec znakov
 Vystupne podmienky: retazec znakov hovoriaci o spravnosti odzatvorkovania vyrazu zadaneho uzivatelom}
program zatvorky;
uses crt,dos;
var pocet,i:integer;
    vyraz:string;
    anonie:char;
begin
 repeat
  gotoxy (20,10);
  write     ('***************');
  write     ('*    Zacni    *');
  write     ('*   Program   *');
  write     ('***************');

  clrscr;
  writeln ('                       Zistenie spravneho odzatvorkovania');
  writeln;
  writeln;
  write ('Zadaj vyraz: ');
   readln (vyraz);
  pocet:=0;
  for i:=1 to length(vyraz) do begin
                                if vyraz[i]='(' then
                                                pocet:=pocet+1;
                                if vyraz[i]=')' then
                                                pocet:=pocet-1;
                                if pocet<0 then
                                           break;
                               end;
  if pocet=0 then
             writeln ('Vyraz je spravne odzatvorkovany')
             else
             writeln ('Vyraz nie je spravne odzatvorkovany');
  readln;
  repeat
   clrscr;
   writeln ('                       Zistenie spravneho odzatvorkovania');
   writeln;
   writeln;
   write ('Ak chces pokracovat napis A ak nie tak napis N: ');
   anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.