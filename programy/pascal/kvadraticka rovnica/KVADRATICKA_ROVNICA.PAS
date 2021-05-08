{Pavlina Olesnanikova,2.C,Sk.rok:2012/13}
{Program na vzpocet kvadratickej rovnice}

Program Kvadraticka_rovnica;
USES CRT;
VAR koef_a,koef_b,koef_c,DIS,koren,koren_1,koren_2:REAL;

BEGIN
 CLRSCR;
 WRITELN('                     Program na vypocet kvadratickej rovnice');
 WRITELN('                     _______________________________________');
 WRITELN;
 WRITELN;
 WRITELN;
 WRITE('Zadaj koef A: ');
 READLN(koef_A);
 WRITE('Zadaj koef B: ');
 READLN(koef_B);
 WRITE('Zadaj koef C: ');
 READLN(koef_C);
 CLRSCR;
 WRITELN('                     Program na vypocet kvadratickej rovnice');
 WRITELN('                     _______________________________________');
 WRITELN;
 WRITELN;
 WRITELN;
 WRITE('Kvadraticka rovnica tipu: ax2 + bx + c =0');
 WRITELN;
 WRITELN;
 Dis:=(-koef_b*koef_b)-(4*koef_a*koef_c);
 If Dis>0 then
           begin
           koren_1:=(-koef_b+SQRT(dis))/(2*koef_a);
           koren_2:=(-koef_b-SQRT(dis))/(2*koef_a);
           writeln('kvadraticka rovnica ma 2 korene');
           writeln ('koren 1=' ,koren_1,'koren 2=',koren_2);
           end
          else if dis=0 then
                        begin
                        koren:=(-koef_b)/(2*koef_a);
                        writeln('koren= ',koren:5:2);
                        end
                       else IF dis<0 then
                         writeln ('kvadraticka rovnica nema riesenie');


 WRITE('Stlac klavesu enter.');
 WRITELN;
 READLN;
 READLN;
 END.
