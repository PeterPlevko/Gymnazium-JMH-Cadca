{Peter Plevko, Septima A, Sk. rok 2017/18
 Vypocitanie hodnoty mnohoclena pomocou hornerovej schemy
 Vstupne podmienky: polynomicky stupen (cele kladne cislo), hodnota x a cleny mnohoclena (realne cisla)
 Vystupne podmienky: hodnota mnohoclena (realne cislo)}
program hodnota_mnohoclena;
uses crt;
var pocet,i:integer;
    test,x,sucet:real;
    anonie:char;
    pole: array [0..100] of real;
procedure nadpis;
          begin
           clrscr;
           writeln ('                               Hodnota mnohoclena');
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
                      write ('Zadaj koeficient clena s polynomickym stupnom ',pocet-i,':')
                      else
                      write (text);
          readln (cislo);
          while (((trunc(cislo))<>cislo) and cele) or ((cislo<=dol_hr) and vacsi) or ((cislo>=hor_hr) and mensi) do
          begin
           nadpis;

           if not(trunc(cislo)=cislo) then
                                      write ('Zadal si realne cislo zadaj znova:')
           else if cislo<=dol_hr then
                                 write ('Zadal si cislo mensie ako ',dol_hr + 1,' zadaj znova:')
           else if cislo>=hor_hr then
                                 write ('Zadal si cislo vacsie ako ',hor_hr -1,' zadaj znova:');
           readln (cislo);
          end;
         end;
procedure ukoncenie;
          begin
          repeat
            nadpis;
            write ('Ak chces pokracovat napis A ak nie tak napis N: ');
            anonie:=readkey;
          until (upcase(anonie) ='N') or (upcase(anonie) ='A');
          end;
begin
 repeat
  ochrana (test,true,true,true,false,'Zadaj polynomicky stupen mnohoclena: ');
  pocet:=trunc(test)+1;
  ochrana (x,false,false,false,false,'Zadaj x s pruhom: ');
  for i:=1 to pocet do
      ochrana (pole[i],false,false,false,true,'Zadaj koeficient Ÿlena s polynomickym stupnom:');
  sucet:=pole[0];
  for i:=1 to pocet do
           sucet:=sucet*x + pole[i];
  nadpis;
  writeln ('Hodnota mnohoclena je: ',sucet:2:2);
  readln;
  ukoncenie;
 until  upcase(anonie) = 'N';
end.