program zasobnik;
uses crt;
var kamil1,kamil2,zatvorky :integer;
anonie:char;
j,i:integer;
pole:array[1..10] of string;
begin
repeat
clrscr;
  writeln('    ***********************************************************************');
  writeln('    * program na zistenie spravne odzatvorkovania                         *') ;
  writeln('    *Max 10 zatvoriek, ak pouzivatel chce zadaj menej musi pouzit medzeru *') ;
  writeln('    ***********************************************************************') ;
for i:=1 to 10 do begin

                 write('zadajte ',i,' prvok pola ');
                 readln(pole[i]);
                 end;



for i:=1 to 10 do write(pole[i]);
writeln;

for i:=1 to 10 do begin
if ( pole[i]= '(' ) and ( pole[i+1] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+1],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+2] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+2],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+3] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+3],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+4] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+4],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+5] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+5],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+6] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+6],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+7] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+7],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+8] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+8],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+9] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+9],1,1);
                                                                         end;
if ( pole[i]= '(' ) and ( pole[i+10] = ')' ) then begin  delete (pole[i],1,1);
                                                                         delete (pole[i+10],1,1);
                                                                         end;
end;

i:=1;
if (pole[i])= '(' then begin
                  writeln('nespravne odzatvorkovany');
                  kamil1:=kamil1+1;
                  end;

if (pole[i])= ')' then begin
                  writeln ('nespravne odzatvorkovany');
                  kamil2:=kamil2+1;
                  end;
if (kamil1=0) and (kamil2=0) then writeln('vyraz je spravne odzatvorkovany');



 repeat
   gotoxy(1,32);
   writeln ('Ak chces pokracovat napis A ak nie tak napis N: ');
   anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.
