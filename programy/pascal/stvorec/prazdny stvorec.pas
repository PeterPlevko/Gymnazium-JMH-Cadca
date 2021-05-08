{Matej Matejcik, Gym v CA}
Program Stvorec;
Uses crt;
Var Pocet:integer;
I,F,K:integer;

Begin
Clrscr;
Writeln('Napis miery');
Readln(Pocet);
Writeln;
For I:=1 To pocet do Begin
If (I=1) or (I=pocet) then
for F:=1 to Pocet do Write('*')
Else Begin Write('*');
For K:=1 to (Pocet-2) do Write(' ');
Write('*');
Readln;
End.