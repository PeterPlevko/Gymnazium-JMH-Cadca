{Delincak Matej, Sexta A, sk.r.: 2016/2017}
{Program: Zaznam}
{Vstupne podmienky: }
{Vystupne podmienky: }

program Zaznam;
uses crt;
type Player = record
       najlepsi: real;
       meno: string;
       priezvisko: string;
       narodnost: string;
       poradcislo: integer;
     end;
var Tour: array[0..50] of Player;
    Zoznam: text;
    count: integer;
    answer, menu: char;

 procedure ShowHead;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                                Skok do dialky                               ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;
end;


procedure ShowMenu1;
begin
  ShowHead;
  Writeln('Menu:');
  Writeln('1. Nacitaj zo suboru');
  Writeln('2. Nacitaj rucne');
  Writeln('3. Ukonci');
  Writeln;
  Write('Zadaj volbu: ');
  menu := READKEY;
  while (menu <> '1') and (menu <> '2') and (menu <> '3') do
  begin
    Write('Zadaj volbu: ');
    menu := READKEY;
    menu := UpCase(menu);
    Writeln('Zadal si nespravny znak.');
    Writeln;
  end;
  if menu = '3' then answer := 'N';
end;


procedure Swap(paIndexF, paIndexS: integer);
var help: Player;
begin
  help := Tour[paIndexF];
  Tour[paIndexF] := Tour[paIndexS];
  Tour[paIndexS] := help;
end;

procedure Add;
var s: string;
    num: real;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                            Nahratie noveho hraca                            ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;

  with Tour[count] do
  begin
    Writeln('Pridanie noveho zaznamu: ');
    Write('Zadaj meno: ');
    Readln(meno);
    Write('Zadaj priezvisko: ');
    Readln(priezvisko);
    Write('Zadaj narodnost: ');
    Readln(narodnost);
    Write('Zadaj najlepsie skore: ');
    Readln(najlepsi);
    Write('Zadaj startovne cislo: ');
    Readln(poradcislo);
  end;
  Inc(count);
end;

procedure AddPlayer;
var s: string;
    num: real;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                            Nahratie noveho hraca                            ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;

  with Tour[count] do
  begin
    Writeln('Pridanie noveho zaznamu: ');
    Write('Zadaj meno: ');
    Readln(meno);
    Write('Zadaj priezvisko: ');
    Readln(priezvisko);
    Write('Zadaj narodnost: ');
    Readln(narodnost);
    Write('Zadaj startovne cislo: ');
    Readln(poradcislo);
  end;
end;

procedure AddPlayerVys(paI: integer);
var s: string;
    num: real;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                            Nahratie vysledku                                ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;

  with Tour[paI] do
  begin
    Write('Nacitanie skore pre hraca ', priezvisko,': ');
    Readln(najlepsi);
  end;
end;


procedure DeleteZ;
var s: string;
    clear: boolean;
    num: real;
    i: integer;
begin
  ClrScr;
  clear := false;
  Writeln('Vymazania stareho zaznamu: ');
  Write('Zadaj meno: ');
  Readln(s);
  for i := 1 to count do
  begin
    if Tour[i].meno = s then
    begin
      Tour[i].meno := '';
      Tour[i].priezvisko := '';
      Tour[i].narodnost := '';
      Tour[i].najlepsi := 0;
      Tour[i].poradcislo := 0;
      clear := true;
    end;
    if clear = true then
    Tour[i] := Tour[i+1];
  end;
  Dec(count);
end;

procedure SortByName;
var clear: boolean;
    index, i: integer;
begin
  clear := false;
  index := count-1;
  while clear = false do
    begin
      for i := 0 to count-1 do
      begin
        if Ord(Tour[i].meno[1]) > Ord(Tour[i+1].meno[1]) then
        begin
          Swap(i, i+1);
        end;
      end;
      Dec(index);
      if index <= 0 then clear := true;
    end;
end;

procedure SortByPrie;
var clear: boolean;
    index, i: integer;
begin
  clear := false;
  index := count-1;
  while clear = false do
    begin
      for i := 0 to count-1 do
      begin
        if Ord(Tour[i].priezvisko[1]) > Ord(Tour[i+1].priezvisko[1]) then
        begin
          Swap(i, i+1);
        end;
      end;
      Dec(index);
      if index <= 0 then clear := true;
    end;
end;

procedure SortByNarod;
var clear: boolean;
    index, i: integer;
begin
  clear := false;
  index := count-1;
  while clear = false do
    begin
      for i := 0 to count-1 do
      begin
        if Ord(Tour[i].narodnost[1]) > Ord(Tour[i+1].narodnost[1]) then
        begin
          Swap(i, i+1);
        end;
      end;
      Dec(index);
      if index <= 0 then clear := true;
    end;
end;

procedure SortBySkok;
var clear: boolean;
    index, i: integer;
begin
  clear := false;
  index := count-1;
  while clear = false do
    begin
      for i := 0 to count-1 do
      begin
        if Tour[i].najlepsi < Tour[i+1].najlepsi then
        begin
          Swap(i, i+1);
        end;
      end;
      Dec(index);
      if index <= 0 then clear := true;
    end;
end;

procedure SortByPorad;
var clear: boolean;
    index, i: integer;
begin
  clear := false;
  index := count-1;
  while clear = false do
    begin
      for i := 0 to count-1 do
      begin
        if Tour[i].poradcislo < Tour[i+1].poradcislo then
        begin
          Swap(i, i+1);
        end;
      end;
      Dec(index);
      if index <= 0 then clear := true;
    end;
end;

function FindSpace(paS: string): integer;
var i: integer;
begin
  for i := Length(paS) downto 1 do
  begin
    if paS[i] = ' ' then FindSpace := i;
  end;
end;

procedure WriteTab;
var i, j: integer;
begin

  Writeln('ÉÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
  Writeln('º Por. ³ St.Cis. ³  Meno      ³ Priezvisko ³ Stat      ³ Dlzka skoku          º');
  Writeln('ÇÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');
  for i := 0 to count do
  begin
    if Tour[i].meno <> '' then
    begin
      Write('º ', i+1, '.');
      if i < 9 then Write('   ³ ') else Write('  ³ ');

      Write(Tour[i].poradcislo);
      if Tour[i].poradcislo < 10 then Write('       ³ ') else Write('      ³ ');

      Write(Tour[i].meno);
      for j := 1 to 11-Length(Tour[i].meno) do Write(' ');
      Write('³ ');
      Write(Tour[i].priezvisko);
      for j := 1 to 11-Length(Tour[i].priezvisko) do Write(' ');
      Write('³ ');
      Write(Tour[i].narodnost);
      for j := 1 to 10-Length(Tour[i].narodnost) do Write(' ');
      Write('³ ');
      Write(Tour[i].najlepsi:1:1);
      Writeln('                  º');
    end;
  end;
  Writeln('ÈÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
end;


procedure ShowMenuAddPlayerVys;
var i: integer;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                              Nacitanie vysledkov                            ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;
  for i := 0 to count-1 do
  begin
    AddPlayerVys(i);
  end;
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                              Finalova listina                            ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');

  WriteTab;
  Writeln;
    Writeln;
    TextColor(White);
    Write('Naspat do menu? - A/N: ');
    answer := READKEY;
    answer := UpCase(answer);

    while (answer <> 'A') and (answer <> 'N') do
    begin
      Write('Naspat do menu? - A/N: ');
      answer := READKEY;
      answer := UpCase(answer);
      Writeln('Zadal si nespravny znak.');
      Writeln;
    end;
end;

procedure ShowMenuAddPlayer;
var i: integer;
begin
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                                Nacitanie hracov                             ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln;
  Write('Kolko hracov chces nacitat: ');
  Readln(i);
  while i <> 0 do
  begin
    AddPlayer;
    Dec(i);
    Inc(count);
  end;
  ClrScr;
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');
  Writeln('³                              Startovacia listina                            ³');
  Writeln('*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*');

  WriteTab;
  Readln;
  ShowMenuAddPlayerVys;
end;

procedure ShowMenu2;
begin
  ShowHead;
  Writeln('1. Usporiadaj podla mena');
  Writeln('2. Usporiadaj podla priezviska');
  Writeln('3. Usporiadaj podla narodnosti');
  Writeln('4. Usporiadaj podla skoku');
  Writeln('5. Pridaj zaznam');
  Writeln('6. Odstran zaznam');
  Writeln('7. Ukonci');
  Writeln;
  Write('Zadaj volbu: ');
  menu := READKEY;

  while (menu <> '1') and (menu <> '2') and (menu <> '3')
  and (menu <> '4') and (menu <> '5') and (menu <> '6') and (menu <> '7') do
  begin
    Write('Zadaj volbu: ');
    menu := READKEY;
    menu := UpCase(menu);
    Writeln('Zadal si nespravny znak.');
    Writeln;
  end;
  case menu of
    '1': SortByName;
    '2': SortByPrie;
    '3': SortByNarod;
    '4': SortBySkok;
    '5': Add;
    '6': DeleteZ;
    '7':
    begin
      answer := 'N';
      Exit;
    end;
  end;
  ClrScr;
  WriteTab;
  Write('Pokracovat v programe? - A/N: ');
    answer := READKEY;
    answer := UpCase(answer);
    
  while (answer <> 'A') and (answer <> 'N') do
  begin
    Write('Pokracovat v programe? - A/N: ');
    answer := READKEY;
    answer := UpCase(answer);
    Writeln('Zadal si nespravny znak.');
    Writeln;
  end;
  if menu = '7' then answer := 'N';
end;

procedure Load(paPath: string);
var s, sm: string;
    i, j, k, cislo, code: integer;
    max: real;
begin
  Assign(Zoznam, paPath);
  Reset(Zoznam);
  j := 0;
  while not eof(Zoznam) do
  begin
    i := 0;
    Readln(Zoznam, s);
    while s <> '' do
    begin
      sm := COPY(s, 1, FindSpace(s)-1);
      Delete(s, 1, FindSpace(s));
      if (i = 0) OR (i = 4) then
      Val(sm, cislo, code);
      case i of
        0:Tour[j].najlepsi := cislo/10;
        1:Tour[j].meno := sm;
        2:Tour[j].priezvisko := sm;
        3:Tour[j].narodnost := sm;
        4:Tour[j].poradcislo := cislo;
      end;
      Inc(i);
    end;
    Inc(j);
  end;

  count := j;
  Close(Zoznam);
  ClrScr;
  ShowMenu2;
end;


begin
  TextColor(White);
  repeat
    ShowHead;
    ShowMenu1;
    case menu of
      '1':Load('data.txt');
      '2':ShowMenuAddPlayer;
      '3':Exit;
    end;

    {Spyta sa, ci ma program pokracovat}
    {GotoXY(1, 20);}
    Writeln;
    Writeln;
    TextColor(White);
    while (answer <> 'A') and (answer <> 'N') do
    begin
      Write('Pokracovat v programe? - A/N: ');
      answer := READKEY;
      answer := UpCase(answer);
      Writeln('Zadal si nespravny znak.');
      Writeln;
    end;
  until (answer <> 'A');
end.