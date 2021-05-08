{Peter Plevko,Septima A, Sk. rok 2017/18
 Vypocitanie integralu zadanej polynomickej funkcie
 Vstupne podmienky:polynomicky stupen (cele kladne cislo),polynomicky mnohoclen (realne cisla),spodna a horna hranica
 Vystupne podmienky: hodnota daneho integralu (realne cislo)}
program integral;
uses crt,graph;
var pocet,i,k,gd,gm,pom,velkost:integer;
    dolhr,horhr,test,str1,str2,krt_str,dlh_str,posun,sucet:real;
    pole:array [0..100] of real;
    anonie,volba:char;
    pos:string;
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
            gotoxy (1,20);
            write ('Ak chces pokracovat stlac A ak nie tak napis N: ');
            anonie:=readkey;
          until (upcase(anonie) ='N') or (upcase(anonie) ='A');
          end;
begin
 repeat
 ochrana (test,true,true,true,false,'Zadaj polynomicky stupen mnohoclena: ');
  pocet:=trunc(test)+1;
 for i:=1 to pocet do
      ochrana (pole[i],false,false,false,true,'Zadaj koeficient Ÿlena s polynomickym stupnom:');
 ochrana (dolhr,false,false,false,false,'Zadaj dolnu hranicu intervalu:');
 ochrana (horhr,false,false,false,false,'Zadaj hornu hranicu intervalu:');
 posun:=(horhr-dolhr)/200;
 for i:=0 to 199 do
  begin
   str1:=pole[0];
   for k:=1 to pocet do
            str1:=str1*(dolhr +(i*posun)) + pole[k];
   str2:=pole[0];
   for k:=1 to pocet do
            str2:=str2*(dolhr +((i+1)*posun)) + pole[k];
   if str1>str2 then begin
                      dlh_str:=str1;
                      krt_str:=str2;
                     end
                else begin
                      dlh_str:=str2;
                      krt_str:=str1;
                     end;
   sucet:=sucet +(krt_str*posun + ((dlh_str-krt_str)*posun)/2);
  end;
  velkost:=1;
  clrscr;
  gd:=detect;
  initgraph(gd,gm,'e:\ins\tp70\units');
 repeat
  rectangle (0,0,600,400);
  rectangle (570,0,600,30);
  rectangle (570,30,600,60);
  moveto (580,15);
  lineto (590,15);
  moveto (585,10);
  lineto (585,20);
  moveto (580,45);
  lineto (590,45);
  moveto(0,200);
  lineto(600,200);
  moveto(300,0);
  lineto(300,400);
  for i:=0 to 12*velkost do begin
                 moveto (trunc(50/velkost)*i,190+trunc(velkost-1)*3);
                 lineto (trunc(50/velkost)*i,210-trunc(velkost-1)*3);
                 str(-6*velkost+i,pos);
                 outtextxy (trunc(50/velkost)*i-5,215,pos);
                    end;
  for i:=0 to 8*velkost do begin
                 moveto (290+trunc(velkost-1)*3,trunc(50/velkost)*i);
                 lineto (310-trunc(velkost-1)*3,trunc(50/velkost)*i);
                 str(4*velkost-i,pos);
                 if i<>4*velkost then
                 outtextxy (275,trunc(50/velkost)*i-4,pos);
                    end;
 posun:=1/50*velkost;
 for i:=0 to trunc(horhr-dolhr)*trunc(50/velkost) do begin
          str1:=pole[0];
          for k:=1 to pocet do
              str1:=str1*(dolhr+(i*posun)) + pole[k];
          if (abs (str1*50/velkost) < 200) and ((str1*50/velkost) > -200) and (trunc(300+((dolhr+i*posun)*50/velkost))>0)
          and (trunc(300+((dolhr+i*posun)*50/velkost))<600) then  begin
                                 sound (300+trunc(str1*40));
                                 delay (25);
                                 nosound;
                                       end;
          PutPixel (trunc(300+((dolhr+i*posun)*50/velkost)) ,200 -trunc (str1*50/velkost),white);
                                      end;
 repeat
  volba:=readkey;
 until ((volba='+') and (velkost<3)) or ((volba='-') and (velkost>0)) or (ord(volba)=13);
 if volba = '+' then
                velkost:=velkost+1
 else
                velkost:=velkost-1;
 clrscr;
 until ord(volba)=13;
 closegraph;
  nadpis;
  writeln ('Hodnota tohto integralu je:',sucet:2:2);
 ukoncenie;
until  upcase(anonie) = 'N';
end.
