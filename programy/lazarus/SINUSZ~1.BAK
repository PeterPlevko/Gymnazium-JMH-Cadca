program sinus;
uses crt;
var i,expon:integer;
    x,odch,cis1,cis2,sinu:real;
    anonie:char;
function fakt (cislo:integer):integer;
         begin
          if cislo=0 then
                     fakt:=1
                     else
                     fakt:=cislo* fakt(cislo-1);
         end;
function moc (var cislo:real;exp:integer):real;
          var cislopov:real;
              j:integer;
          begin
           cislopov:=cislo;
           for j:=1 to exp-1 do
               cislopov:=cislo*cislopov;
           moc:=cislopov;
          end;
function perioda (uhol:real):real;
         begin
          if uhol<360 then
                      perioda:=uhol
          else
                      perioda:=perioda(uhol-360);
         end;
procedure nadpis;
          begin
           clrscr;
           writeln ('                               Vypisovanie permutacii');
           writeln;
           writeln;
          end;
procedure ochrana (var cislo:real; cele,vacsi,mensi,premenna:boolean;text:string);
         var dol_hr,hor_hr:integer;
         begin
          dol_hr:=0;
          hor_hr:=100;
          nadpis;
          if premenna then
                      write ('Zadaj ',i,'. prvok pola:')
                      else
                      write (text);
          readln (cislo);
          while (((trunc(cislo))<>cislo) and cele) or ((cislo<=dol_hr) and vacsi) or ((cislo>=hor_hr) and mensi) do
          begin
           nadpis;

           if not(trunc(cislo)=cislo) then
                                      write ('Zadal si realne cislo zadaj znova:')
           else if cislo<dol_hr then
                                 write ('Zadal si cislo mensie ako ',dol_hr + 1,' zadaj znova:')
           else if cislo>=hor_hr then
                                 write ('Zadal si cislo vacsie ako ',hor_hr -1,' zadaj znova:');
           readln (cislo);
          end;
         end;
procedure ukoncenie;
          begin
          repeat
            writeln;
            writeln;
            write ('Ak chces pokracovat stlac A ak nie tak napis N: ');
            anonie:=readkey;
          until (upcase(anonie) ='N') or (upcase(anonie) ='A');
          end;
begin
 {repeat}
  nadpis;
  ochrana (x,false,true,false,false,'Zadaj x:');
  ochrana (odch,false,true,false,false,'Zadaj povolenu odchylku:');
  x:=perioda(x);
  if x>270 then
           x:=360-x
  else if x>180 then
           x:=x-180
  else if x>90 then
           x:=180-x;
  x:=x*0.017;
  expon:=-1;
  repeat
   expon:=expon+2;
   cis1:=(moc(x,expon))/(fakt(expon));
   expon:=expon+2;
   if cis1<=odch then
                 break;
   cis2:=(moc(x,expon))/(fakt(expon));
   if cis2<=odch then begin
                       sinu:=sinu+cis1;
                       break;
                      end;
   sinu:=sinu+cis1-cis2;
  until false;
  writeln (sinu:2:2);
  readln;
  end.





