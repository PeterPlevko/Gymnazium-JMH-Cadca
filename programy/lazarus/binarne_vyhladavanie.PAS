program binarne_vyhladavnie;
uses crt;
var pole:array[1..100] of integer;
i,dlzkaretazca,stred,spodok,vrch,cislo:integer;
najdenie:boolean;

begin
clrscr;
writeln('Binarne vyhladavanie');
writeln('dlzka retazca');
readln(dlzkaretazca);
writeln('Zadaj postupnost');
 for i:=1 to dlzkaretazca do
 begin readln(pole[i]);
 end;
writeln('ake cislo chces hladat ?');
readln(cislo);
spodok:=1;
vrch:=dlzkaretazca;
najdenie:=false;
 repeat
 stred:=trunc(spodok+vrch) div 2; {bez toho plus jedna by mohli vzniknut odchylky}
 if (cislo<pole[stred]) then vrch:=stred-1;

 if (cislo>pole[stred]) then spodok:=stred+1;

 if (cislo=pole[stred]) then najdenie:=true
                        else najdenie:=false;

 until ((najdenie=true) or (vrch<spodok));
if najdenie=true then writeln('Prvok sa nasiel')
                 else writeln('Prvok sa nenasiel');
readkey;
end.

