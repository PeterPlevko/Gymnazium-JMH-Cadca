{Antonia Cviklova,4.F,2013\2014}

Program RANDOMIA;
Uses crt;
Var VH,MojeCislo,Cislo,Poc,Prem:integer;
I:integer;
Test:char;


Begin
Repeat
 Clrscr;
 Randomize;
 Writeln('               Program na uhadnutie cisla z daneho intervalu.');
 Writeln('               ______________________________________________');
 Writeln;
 Write('Zadaj vrchnu hranicu intervalu {kladne cislo} (potvrd tlacidlom ENTER) : ');
 Readln(VH); {VH - vrchna hranica }
 Writeln('Cislo sa bude generovat z intervalu <1;',VH,'> .');
 Writeln;
 Writeln('Pre pokracovanie stlac ENTER .');
 readln;
 Writeln;
 Cislo:=Random(VH)+1;

Repeat


        Clrscr;
        Writeln('               Program na uhadnutie cisla z daneho intervalu.');
        Writeln('               ______________________________________________');
        Writeln;
        Write('Zadaj tvoje cislo, ktore sa porovna s vygenerovanym (potvrd s ENTER) : ');
        Readln(MojeCislo);
        Writeln;
        IF MojeCislo=Cislo then

        Begin
         Writeln('Uhadol si cislo');
         Poc:=Poc+1;
        end

        else IF MojeCislo>Cislo then

        begin
         Writeln('Vygenerovane cislo je mensie ako tvoje .');
         Poc:=Poc+1;
         Writeln;
         Writeln('Pre pokracovanie stlac ENTER .');
         readln;
        end

        else

        Begin
         Writeln('Vygenerovane cislo je vacsie ako tvoje .');
         Poc:=Poc+1;
         Writeln;
         Writeln('Pre pokracovanie stlac ENTER .');
         readln;
        end;

until MojeCislo=Cislo;  {opakuje sa dokial nase cislo nebude zhodne s vygenerovanym}

 Writeln;
 Writeln('Uhadol si cislo na ',Poc,'. krat !');
 Writeln;
 Writeln('Ak chces program ukoncit stlac N, ak chces program opakovat stlac Y.');
 Writeln('Svoju volbu potvrd tlacidlom ENTER .');
 Readln(Test);
Until   Upcase(Test)='N';
        Writeln;

end.

