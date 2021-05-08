{VST: Dany je polomer gule r}
{VYS: Objem a povrch gule}
{Osrman Matej, 2.E}
{Program na vypocet objemu a povrchu gule}

program OBJEM_POVRCH_GULE;
uses crt;
var r, pi, OBJEM, POVRCH: real;

begin
 clrscr;
 gotoxy(6, 2);
 writeln('Program na urcenie objemu a povrchu gule');
 gotoxy(5, 3);
 writeln('__________________________________________');

 pi:= 3.1415;
 gotoxy(2, 6);
 write('Zadaj polomer gule, r(cm): ');
 readln(r);
 OBJEM:= 4/3*pi*r*r*r;
 POVRCH:= 4*pi*r*r;
 gotoxy(2, 9);
 writeln('Objem gule s polomerom ',r:8:2,' cm je ',OBJEM:8:2,' cm3');
 gotoxy(2, 11);
 writeln('Povrch gule s polomerom ',r:8:2,' cm je ',POVRCH:8:2,' cm2');
 gotoxy(6, 14);
 write('Pre ukoncenie programu stlac Enter');
 readln;

end.
