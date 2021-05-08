{Peter Plevko, Septima A, Sk. rok 2016/17
 Program na zistenie ci danny retazec je palindrom
 Vstupne podmienky: retazec znakov
 Vystupne podmiennky: palindrom ano/nie}
program palindrome;
uses crt;
var
anonie:char;
dlzka_retazca,i,premenna:integer;
retazec:string;
begin
 repeat
 clrscr;
 writeln('********************************************************************************');
 writeln('*                                   Program palindrom                          *');
 writeln('********************************************************************************');

 writeln;
 write('Zadaj retazec: ');
 readln(retazec);
 dlzka_retazca:=length(retazec);

 clrscr;
 writeln('********************************************************************************');
 writeln('*                                   Program palindrom                          *');
 writeln('********************************************************************************');
 writeln;

 for i:=1 to dlzka_retazca do begin
 premenna:=0;
 if ord(retazec[i])=ord(retazec[dlzka_retazca-i+1]) then premenna:=1;
 end;
 if premenna=1 then writeln ('Zadany retazec: ',retazec, ' je palindrome')
 else writeln('Zadany retazec: ',retazec, ' nieje palindrom');
  repeat
  gotoxy(1,20);
  write ('Ak chces pokracovat napis A ak nie tak napis N: ');
  anonie:=readkey;
  until (upcase(anonie) ='N') or (upcase(anonie) ='A');
 until  upcase(anonie) = 'N';
end.
