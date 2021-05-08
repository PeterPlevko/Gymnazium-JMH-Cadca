{Peter Plevko, Septima A, Sk. rok 2017/18
 Program na vzfarbenie stvorca
 Vstupne podmienky: ktory stvorec
 Vystupne podmienky: vystupny stvorec}
program grafika;
uses crt,graph;
var
volba,gd,gm:integer;
begin
initGraph(gd,gm,'');
moveto(1,20);
outtext('Zadaj cislo stvorca ktory chces vymalovat na zeleno 1,2,3...');
moveto(1,40);
outtext('napis kolky stvorec chces vyfarbyt rata sa zlava do prava');
readln(volba);
rectangle(50,100,100,50);
rectangle(100,100,150,50);
rectangle(150,100,200,50);
rectangle(200,100,250,50);
{prvy riadok}
rectangle(50,150,100,100);
rectangle(100,150,150,100);
rectangle(150,150,200,100);
rectangle(200,150,250,100);
{druhy riadok}
rectangle(50,200,100,150);
rectangle(100,200,150,150);
rectangle(150,200,200,150) ;
rectangle(200,200,250,150);
{treti riadok}
rectangle(50,250,100,200);
rectangle(100,250,150,200);
rectangle(150,250,200,200);
rectangle(200,250,250,200);
{stvrty riadok}
setfillstyle(solidfill,green);
if volba=1 then bar(50,100,100,50);
if volba=2 then bar(100,100,150,50);
if volba=3 then bar(150,100,200,50);
if volba=4 then bar(200,100,250,50);
{prvy}
if volba=5 then bar(50,150,100,100);
if volba=6 then bar(100,150,150,100);
if volba=7 then bar(150,150,200,100);
if volba=8 then bar(200,150,250,100);
{druhy}
if volba=9 then bar (50,200,100,150);
if volba=10 then bar(100,200,150,150);
if volba=11then bar (150,200,200,150) ;
if volba=12 then bar(200,200,250,150);
{treti}
if volba=13 then bar (50,250,100,200);
if volba=14 then bar(100,250,150,200);
if volba=15 then bar(150,250,200,200);
if volba=16 then bar(200,250,250,200);
{stvrty}
readln;
closegraph;
end.