{Hornerova schema}  {R cisla}
{Tom ç Kuric}
program horner;
uses crt;
type pole=array[1..10,1..11]of real;
var i,j,rad,derivacia,poc:integer;
    a:pole;
    l:longint;
    bod,vysledok:real;
    c:char;
    b:boolean;

function faktorial(c:integer):longint;forward;
function vypvBx(var a:pole;bod:real;rad:integer):real;forward;
function derivuj(a:pole;bod:real;rad,derivacia:integer):real;forward;



function faktorial(c:integer):longint;
 var i:integer;
 begin
  if c<2 then faktorial:=1 else faktorial:=c*faktorial(c-1);
 end;

function vypvBx(var a:pole;bod:real;rad:integer):real;
 var i,j:integer;
 begin
  a[2,1]:=a[1,1];
  for i:=2 to rad+1 do
  a[2,i]:=a[2,i-1]*bod+a[1,i];
  vypvBx:=a[2,i];
{ writeln('f(x) v bode ',bod:2:2,' je ',a[2,i]:3:3);}
 end;

function derivuj(a:pole;bod:real;rad,derivacia:integer):real;
 var i,j,k:integer;

 begin
  for i:=1 to derivacia do
  begin
   for j:=2 to rad-i+1 do
   a[2,j]:=(a[2,j-1]*bod+a[2,j]);
   {write(a[i+2,j]:2:2,' - ');}
   {if rad<>i then a[i+2,rad-i+1]:=(a[i+2,j]*bod+a[i+1,j+1])}{*faktorial(i);}
  end;
  derivuj:=a[2,rad-derivacia+1]*faktorial(derivacia);
 end;

begin
  repeat
    clrscr; textcolor(white);
    writeln('Program na vyp mnohoclena v bode x/jeho derivaciu pomocou: ');
    writeln('                    Hornerovej schemy                      ');
    writeln;
    repeat
      gotoxy(1,4);
      writeln('>>  Zadaj rad/hodnost(1-9) mnohoclena:        ');
      gotoxy(41,4);textcolor(yellow);
      read(rad);   textcolor(white);
    until (rad<10)and(rad>0);
    writeln('>>  Zadaj nasobky clenov (ak dany clen neexistuje tak zadaj nulu).');
    writeln('>>  Kazdy nasobok/koeficient odentruj.');
    gotoxy(1,7);
    write('f(x)=');
    for i:=1 to rad do
    begin
      gotoxy(10,4+i+2);
      if i<rad then write('x^',rad-i+1) else write('x');
      gotoxy(5,5+i+2);
      write('+');
    end;
    textcolor(yellow);
    for i:=1 to rad+1 do
    begin
      gotoxy(6,4+i+2);
      read(a[1,i]);
    end;
    writeln;
    textcolor(white);
    write('>>  Zadaj bod, v kt chces vyp hodnotu mnohoclena: ');textcolor(yellow);readln(bod);textcolor(white);
    repeat
      write('>>  Chces aj derivovat ? (A/N): ');
      c:=readkey;
      writeln;c:=upcase(c);
    until (c='A') or(c='N');
    if c='A' then repeat write('>>  Zadaj, ktoreho stupna derivaciu chces 1 az ',rad,': ');textcolor(yellow);read(poc);textcolor(white);until (poc>0)and(poc<(rad+1));
    vysledok:=vypvBx(a,bod,rad);
    writeln('>>  f(x) v bode ',bod:2:2,' je ',vysledok:3:3);

    derivacia:=poc;
    if c='A' then writeln('>>  ',derivacia,' derivacia je: ',derivuj(a,bod,rad,derivacia):3:3);


    writeln;
    repeat
      write('>>  Chces pokracovat ? (A/N): ');
      c:=readkey;writeln;c:=upcase(c);
    until (c='A') or(c='N');
    if c='A'then b:=true else b:=false;
  until b=false;
end.



