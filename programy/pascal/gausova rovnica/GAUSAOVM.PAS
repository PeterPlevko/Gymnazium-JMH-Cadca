program GAUSSOVA_METODA;
uses crt;
var a:array[1..6,1..6] of real;
    g:array[1..6] of real;
    i,j,m,n,x,r,k,l,f:integer;
    p,pp,ppp,pp1,pomm:real;
    v,q :char;


procedure INFO;
begin
 clrscr;
 writeln(' Tento program vytvoril : Ivan Guba, Septima B., GJMHC ');
 writeln('Program sluzi na vypocet korenov zo sustavy linearnych rovnic');
 writeln('pomocou Gaussovej - eliminacnej metody ');
 writeln('program vypocita premennu Xn y poslednej rovnice a dosadi ju do');
 writeln('predchadyajucej rovnice - tak vypocita postupne vsetky korene');
 readln;
 clrscr;
end;
procedure PROG;
begin
 clrscr;
  writeln;
  writeln('                    Z A D A V A N I E   M A T I C E');
  writeln;
  write('Zadaj pocet riadkov:');
  readln(m);
  write('Zadaj pocet stlpcov:');
  readln(n);
  writeln;


   for i:=1 to m do begin
   writeln;
   for j:=1 to n do begin
    if j<>n then write ('    *x[',j,'] ')
            else write ('    *x[',j,']³');
   end;
  end;

  for i:=1 to m do begin
   r:=1;
   for j:=1 to n+1 do begin
    gotoxy(r,i+7);
    r:=r+10;
    readln(a[i,j]);
   end;
  end;



  clrscr;
  writeln;
  write('Vypis povodnej matice:');
  writeln;
   for i:=1 to m do begin
    writeln;
    for j:=1 to n+1 do begin
    if j=n+1 then write ('³');
    write('  ',a[i,j]:7:2);
                     end;
                    end;

 for i:=1 to m do begin
  if a[1,1]=0 then
 for j:= 1 to n+1 do begin
    p:=a[1,j];
    a[1,j]:=a[i,j];
    a[i,j]:=p;
                   end;
  end;

 for x:=1 to n+1 do
 for i:=2 to m do
   if (a[i,x]<>0) and (i>x) then begin
            if a[x,x]=0 then begin
       for j:=1 to n+1 do begin
          ppp:=a[x,j];
          a[x,j]:=a[x+1,j];
          a[x+1,j]:=ppp;
                         end;
                         end;

    pp:=a[x,x];
    p:=a[i,x];
    for j:=1 to n+1 do
    a[i,j]:=a[x,j]*p-a[i,j]*pp;
                                  end;
                                 writeln;
 writeln;
 write('Vypis vyslednej matice:');
 writeln;
  for i:=1 to m do begin
    writeln;
  for j:=1 to n+1 do begin
    if j=n+1 then write ('³');
                  write('  ',a[i,j]:7:2);
                    end;
                  end;
 gotoxy(50,24);
 write('Stlac  E N T E R ');
 readln;
 ClrScr;
 Writeln;
 WriteLn('                          K O R E N E');
 writeln;
 write('Vypis vyslednej matice:');
 writeln;
  for i:=1 to m do begin
    writeln;
  for j:=1 to n+1 do begin
    if j=n+1 then write ('³');
                  write('  ',a[i,j]:7:2);
                    end;
                  end;
 writeln;

 p:=0;
 pp:=0;
 for i:=1 to m do begin
  if p>0 then pp:=pp+1;
   p:=0;
    for j:=1 to n do
     if a[i,j]<>0 then p:=p+1;
                 end;

 if p>0 then pp:=pp+1;

 p:=0;
 pp1:=0;
 for i:=1 to m do begin
  if p>0 then pp1:=pp1+1;
   p:=0;
    for j:=n+1 to n+1 do
     if a[i,j]<>0 then p:=p+1;
 end;

 if p>0 then pp1:=pp1+1;

 writeln;

 if (pp<pp1)  then begin
                 writeln('Sustava nema riesenie');
                 readln;
                end
            else begin
 if (pp=pp1) and (pp<m) then begin
                              writeln('Sustava ma nekonecne vela rieseni');
                              readln;
                             end
                        else begin
   g[m]:=a[m,m+1]/a[m,m];
   writeln('Koren ',m,' je ',g[m]:5:1);
   for i:=m-1 downto 1 do begin
                           g[i]:=a[i,m+1];
                           for j:=i+1 to m do
                            g[i]:=g[i]-(a[i,j]*g[j]);
                           g[i]:=g[i]/a[i,i];
                           writeln('Koren ',i,' je ',g[i]:8:1);
                        end;
 Gotoxy(50,24);
 Write('Stlac  E N T E R  ');
                 end;
                              end;
readln;
end;


begin
 repeat
  clrscr;
  textcolor(white);
  gotoxy(27,2);
  writeln('Program ');
  gotoxy(35,2);
  textcolor(lightgreen);
  writeln('GAUSSOVA ELIMINACNA METODA');
  gotoxy(27,3);
  writeln('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
  gotoxy(27,1);
  writeln('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
 textcolor(red);
 gotoxy(29,7);
 writeln('1');
 gotoxy(29,8);
 writeln('2');
 gotoxy(29,10);
 textcolor(yellow);
 writeln('3');

 textcolor(white);
 gotoxy(31,7);
 writeln('³.informacie o programe');
 gotoxy(31,8);
 writeln('³.nacitanie novej sustavy rovnic ');
 gotoxy(31,9);
 writeln('³');
 gotoxy(31,10);
 textcolor(yellow);
 writeln('³.EXIT');
 textcolor(white);
 gotoxy(30,20);
 textcolor(lightred+blink);
 writeln('Zadaj volbu');
 gotoxy(42,20);
 textcolor(white);
 write('1..3');

  q:=readkey;
    case q of '1' : info;
              '2' : PROG;
    end;

until q='3';

end.
