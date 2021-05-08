{Delincak Matej, Sexta A, sk.r.: 2016/2017}
{Program: Program vypocita integral kvadratickej funkcie}
{Vstupne podmienky: Koeficienty a,b,c su realne}
{Vystupne podmienky: Obsah utvaru je realne cislo}

program Piskvorky;
uses crt, graph, mystpu;
const SIZEX = 600;
      SIZEY = 450;
      Gray50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);
var pis: array[0..2,0..2] of byte;
    gd, gm, x, y: integer;
    active: byte;
    prve: boolean;
    answer: char;

function IsFull: boolean;
var i, j: integer;
begin
  IsFull := false;
  for i := 0 to 2 do
  begin
    for j := 0 to 2do
    begin
      if pis[i, j] <> 0 then IsFull := true else
      begin
        IsFull := false;
        exit;
      end;
    end;
  end;
end;

procedure Clear;
var i, j: integer;
begin
  for i := 0 to 2 do
  begin
    for j := 0 to 2do
    begin
      pis[i, j] := 0;
    end;
  end;
end;

procedure CheckMouse;
var i, j: integer;
begin
  for i := 0 to 2 do
  begin
    for j := 0 to 2 do
    begin
      if (x > 70+i*150) AND (y > 10+j*150) AND (x < 70+(i+1)*150) AND (y < 10+(j+1)*150) then
      begin
        if pis[i,j] = 0 then
        begin

          pis[i, j] := active;
        end
        else
          if active = 1 then active := 2 else active := 1;
        Exit;
      end;
    end;
  end;
end;

function TestRiadok(paRiadok: integer):byte;
var i: integer;
begin
  TestRiadok:= 0;
  if pis[0, paRiadok] <> 0 then
  if (pis[0, paRiadok] = pis[1, paRiadok]) AND (pis[0, paRiadok] = pis[2, paRiadok]) then
  begin
    TestRiadok := pis[0, paRiadok];
    MoveTo(72, 95+paRiadok*150);
    LineTo(518, 95+paRiadok*150);
  end;
end;

function TestStlpec(paStlpec: integer): byte;
var i: integer;
begin
  TestStlpec:= 0;
  if pis[paStlpec, 0] <> 0 then
  if (pis[paStlpec, 0] = pis[paStlpec,1]) AND (pis[paStlpec,0] = pis[paStlpec,2]) then
  begin
    TestStlpec := pis[paStlpec, 0];
    MoveTo(145+paStlpec*150, 22);
    LineTo(145+paStlpec*150, 470);
  end;
end;

function TestDiag: byte;
var i: integer;
begin
  TestDiag:= 0;
  if pis[0, 0] <> 0 then
  begin
    if (pis[0, 0] = pis[1,1]) AND (pis[0,0] = pis[2,2]) then TestDiag := pis[0, 0];
  end;
  if pis[0, 2] <> 0 then
  begin
    if (pis[0, 2] = pis[1,1]) AND (pis[0,2] = pis[2,0]) then TestDiag := pis[0, 2];
  end;
end;

function Win: byte;
var i, j, k: integer;
     typ: boolean;
begin
  Win := 0;
  if active = 2 then
    begin
      SetColor(green);
    end
    else
    begin
      SetColor(red);
    end;

  for i := 0 to 2 do
  begin
    for j := 0 to 2 do
    begin
      if TestRiadok(i) >= 1 then Win := TestRiadok(i);
      if TestStlpec(j) >= 1 then Win := TestStlpec(j);
      if TestDiag >= 1 then Win := TestDiag;
    end;
  end;
end;

procedure WriteMatrix;
var i, j: integer;
begin
  ClearDevice;
  if Win = 0 then
  begin
    if active = 2 then
    begin
      SetColor(green);
      MoveTo(100, 5);
      OutText('Ide koliecko');
    end
    else
    begin
      SetColor(red);
      MoveTo(450,5);
      OutText('Ide krizik');
    end;
  end;
  SetLineStyle(0, 0, ThickWidth);
  for i := 0 to 2 do
  begin
    for j := 0 to 2 do
    begin
      case pis[i,j] of
        1:
        begin
          SetColor(green);
          Ellipse(70+i*150+75, 20+j*150+75, 0, 360, 72, 72);
        end;
        2:
        begin
          SetColor(red);
          MoveTo(70+i*150+3, 20+j*150+3);
          LineTo(70+(i+1)*150-3, 20+(j+1)*150-3);
          MoveTo(70+i*150+3, 20+(j+1)*150-3);
          LineTo(70+(i+1)*150-3, 20+j*150+3);
        end;
      end;
      SetColor(white);
      Rectangle(70+i*150, 20+j*150, 70+(i+1)*150, 20+(j+1)*150);
    end;
  end;
end;

begin
  TextColor(White);
  repeat
    Clear;
    initGraph(gd,gm,'C/TP7/TP/UNITS');
    WriteMatrix;
    active := 2;
    ukaz_mys;
    while Win = 0 do
    begin
      repeat
        kde_je_mys(x, y);
      until lavy;
      Delay(100);
      CheckMouse;
      WriteMatrix;
      if active = 1 then active := 2 else active := 1;
      if IsFull then Break;
    end;

    MoveTo(250, 5);
    if Win = 1 then
    begin
      SetColor(green);
      OutText('Vyhral koliecko.');
    end
    else
    begin
      if Win = 0 then
      begin
        SetColor(white);
        OutText('Nevyhral nik.');
      end
      else
      begin
        SetColor(red);
        OutText('Vyhral krizik.');
      end;
    end;
    Delay(2000);
    ClearDevice;
    MoveTo(250, 150);
    SetColor(white);
    zrus_mys;
    OutText('Nova hra ? A/N');
    answer := READKEY;
    answer := UpCase(answer);
    CloseGraph;

    {Spyta sa, ci ma program pokracovat}
    {GotoXY(1, 20);
    TextColor(White);
    repeat
      Write('Pokracovat v programe? - A/N: ');
      answer := READKEY;
      answer := UpCase(answer);
      Writeln('Zadal si nespravny znak.');
      Writeln;
    until (answer = 'A') or (answer = 'N');}
  until (answer <> 'A');
end.