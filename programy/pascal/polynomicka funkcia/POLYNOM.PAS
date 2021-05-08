{Monika Steinigerova 2.E  2008/2009}

Program polynom;
uses crt;

var  i,N : integer;
     vysl, hodn: real;

     pole: array[0..20] of real;


function Mocnina(Zaklad:real;Exponent:integer):real;
var vysledok:real;
    j:integer;
begin
vysledok:=1;
case(Exponent) of
0:vysledok:=1;
1:vysledok:=Zaklad;
else for j:=1 to Exponent do
          begin
          vysledok:=vysledok*Zaklad;
          end;
  end;
Mocnina:=vysledok;
end;

begin
  clrscr;
  writeln;
  write('             Program na urcenie hodnoty polynomu ');
  writeln;
  writeln;


 write('Zadajte stupen polynomu: ');
  readln(N);
 writeln;

 writeln;
 writeln('Zadajte cisla a0...a',n,': ');
 writeln;

 for i:=0 to N do
  begin
   write(' Zadajte koeficient a',i,': ');
   read(pole[i]);
  end;

 writeln;
 write('Zadajte Hodnotu X: ');
  read(hodn);

  write('zadali ste polynom  ');
                for i:=N downto 0
                do
                begin
                write(pole[i]:0:0);
                if (i>0) then write('x');
                if (i>1) then write('^',i);
                if (i>0) then write(' + ');
                end;
         writeln;
         writeln('Hodnota x je ',hodn:0:0);

  {clrscr;}
  writeln;
  write('              Urcenie hodnoty polynomu ');
  writeln;
  writeln;


 write(' Proces pocitania: ');
 writeln;
 vysl:= pole[0];
 write(vysl:0:0);
 for i:=1 to n do
  begin
   write('+',pole[i]*Mocnina(hodn,i):0:0);
   vysl:= vysl+ pole[i]*Mocnina(hodn,i) ;

  end;
 write(' = ',vysl:0:0,' pre x = ',hodn:0:0);
 readkey;
end.