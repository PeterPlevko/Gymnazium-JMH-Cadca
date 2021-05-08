{Peter Plevko, Septima A, Sk. rok 2016/17
 Program hra kamen noznice papier
 Vstupne podmienky: Kamen/Papier/noznice
 Vystupne podmienky: vyhra, prehra }
program kamil;
uses crt;

var premenna,volba:integer;
    anonie:char;

begin
repeat
randomize;
 repeat
 clrscr;
 writeln('               *********************************************');
 writeln('               *      Program Kamen/Papier/noznice         *') ;
 writeln('               *********************************************') ;
 writeln('co zvolis ?');
 writeln('1.Kamen');
 writeln('2.Papier');
 writeln('3.noznice');
 write('volba: ');
 readln(volba);
 if volba = 3 then writeln ('Zvolil si: noznice');
 if volba = 2 then writeln ('Zvolil si: papier');
 if volba = 1 then writeln ('Zvolil si: kamen');
 until((volba<4)and(volba>0));
case volba of
1:begin {kamen};
premenna:=random(3)+1;
if premenna=1 then writeln ('Super zvolil: kamen, nerozhodne');
if premenna=2 then writeln ('Super zvolil: papier prehral si');
if premenna=3 then writeln ('Super zvolil: noznice vyhral si');
end;
2:begin {papier}
premenna:=random(3)+1;
if premenna=1 then writeln('Super zvolil: kamen, vyhral si') ;
if premenna=2 then writeln('Super zvolil: papier, nerozhodne');
if premenna=3 then writeln('Super zvolil: noznice, prehral si');
end;
3:begin {noznice}
premenna:=random(3)+1;
if premenna=1 then writeln ('Super zvolil: kamen prehral si');
if premenna=2 then writeln ('Super zvolil: papier nerozhodne');
if premenna=3 then writeln ('Super zvolil: noznice nerozhodne');
end;
end;
 repeat
  gotoxy(1,20);
  write ('Ak chces pokracovat napis A ak nie tak napis N: ');
  anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.

