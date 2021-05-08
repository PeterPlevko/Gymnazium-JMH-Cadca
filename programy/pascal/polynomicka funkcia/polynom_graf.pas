{Blahovec Jan, 3.E, 2011/2012, seminare}
{Graf polynomickej funkcie}
Program polynom_graf;
uses crt,graph;
var gd,gm:smallint;
    hodnota:string;
    pole:array[1..100] of real;
    i,stupen,presnost :integer;
    poly,obsah,vyska,hhranica,dhranica,pomoc :real;
function polynom(dhranica:real; i:byte):real;
var poly :real;
begin
poly:=pole[0];

for i:=1 to stupen do begin
poly:=(poly*dhranica)+pole[i];                    {vypocet funkcnej hodnoty pre kazde x}
end;
polynom:=poly;
end;
begin

clrscr;
gotoxy(22,2);
writeln('  Polynom 1.1');
writeln('  __________________________________________________');
writeln('  Program na vypocet obsahu na polynomickej funkcii.');
writeln('  Funkcia je napriklad tvaru f : y=4x3-5x2+7x+3 ');
writeln;
write('  Zadaj najvyssi stupen polynomu <napr.x3> ');
readln(stupen);
write('  Zadaj dolnu hranicu intervalu : ');
readln(dhranica);
write('  Zadaj hornu hranicu intervalu : ');
readln(hhranica);
{write('  Zadaj pocet deleni(vacsie cislo = vacsia presnost) <rozmedzie 10-500> : ');
readln(presnost);}
for i:=0 to stupen do begin
write('  Zadaj koeficient a(',i,') : ');
readln(pole[i]);
end;
obsah:=0;
writeln;
clrscr;
vyska:={(hhranica-dhranica)/{presnost}}0.001;
repeat

dhranica:=dhranica+vyska;
obsah:=obsah+polynom(dhranica,stupen);
until dhranica>=hhranica;
obsah:=obsah-((polynom(dhranica,stupen)-polynom(hhranica,stupen))/2);
obsah:=obsah*vyska;



writeln;
writeln('  Polynom 1.1');
writeln('  __________________________________________________');
writeln('  Program na vypocet obsahu na polynomickej funkcii.');
writeln;
writeln('  Obsah plochy na grafe je ',Abs(obsah):4:2,' cm2.');
 {GRAF}
 gd:=detect;
 Initgraph(gd,gm,'');
 setlinestyle(0,0,2);
 setcolor(yellow);
 Line(10,500,1000,500);
 line(498,10,498,1000);


 for i:=0 to 16 do begin
 str(i*(-1),hodnota);         {prelozi hodnotu cisla na string}
 line(500-(30*i),496,500-(30*i),502);
 setcolor(magenta);
 outtextxy(500-(30*i)-5,510,hodnota);{30*i znamena ze od x/ovej suradnice postupne odcitava cisla a vypisuje ich}
 str(i,hodnota);
 outtextxy(496+(31*i),510,hodnota);
 setcolor(lightred);
 line(496+(31*i),496,496+(31*i),502)
                    end;
 for i:=1 to 16 do begin
 str(i*(1),hodnota);
 line(496,505-(30*i),502,505-(30*i));
 setcolor(magenta);
 outtextxy(510,505-(30*i)-5,hodnota);
 str(-i,hodnota);
 setcolor(lightred);
 line(496,505+(28*i),502,505+(28*i));
 setcolor(magenta);
 outtextxy(510,505+(28*i),hodnota);
 setcolor(lightred);
                   end;
 pomoc:=-16;
 repeat
 putpixel(round(500+30*pomoc),round(505-28*polynom(pomoc,stupen)),green);
 pomoc:=pomoc+0.001;
until pomoc>16;
 readln;
 closegraph;

end.
