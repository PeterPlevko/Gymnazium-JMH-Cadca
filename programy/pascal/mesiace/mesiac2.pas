program mesiac;
uses crt;

var oper : char;
    koniec : byte;

procedure nadpis;
 begin
  gotoxy(35,3);
  writeln('Mesiace');
 end;


begin
clrscr;
 repeat;
  koniec:=0;
  nadpis;
  writeln;
  writeln;
  writeln('      A: Januar');
  writeln('      B: Februar');
  writeln('      C: Marec');
  writeln('      D: April');
  writeln('      E: Maj');
  writeln('      F: Jun');
  writeln('      G: Jul');
  writeln('      H: August');
  writeln('      I: September');
  writeln('      J: Oktober');
  writeln('      K: November');
  writeln('      L: December');
  writeln;
  writeln('      M: Koniec');
  writeln;
  write  ('  vyber: ');
  readln(oper);
  oper:= upcase (oper);

  case oper of

   'A': begin
         writeln('            Januar   ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  1.');
        end;

   'B': begin
         writeln('            Februar  ');
         writeln('             pocet dni: 28');
         writeln('             stvrtrok:  1.');
        end;

   'C': begin
         writeln('            Marec    ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  1.');
        end;

   'D': begin
         writeln('            April    ');
         writeln('             pocet dni: 30');
         writeln('             stvrtrok:  2.');
        end;

   'E': begin
         writeln('            Maj      ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  2.');
        end;

   'F': begin
         writeln('            Jun      ');
         writeln('             pocet dni: 30');
         writeln('             stvrtrok:  2.');
        end;
   'G': begin
         writeln('            Jul      ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  3.');
        end;

   'H': begin
         writeln('            August   ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  3.');
        end;

   'I': begin
         writeln('            September');
         writeln('             pocet dni: 30');
         writeln('             stvrtrok:  3.');
        end;

   'J': begin
         writeln('            Oktober  ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  4.');
        end;

   'K': begin
         writeln('            November ');
         writeln('             pocet dni: 30');
         writeln('             stvrtrok:  4.');
        end;

   'L': begin
         writeln('            December ');
         writeln('             pocet dni: 31');
         writeln('             stvrtrok:  4.');
        end;


   'M': begin
         koniec:=1;
        end;
  end;
 until koniec=1;

end.
