program subor;
uses crt;
var FTeplota: text;
    Denna_teplota: integer;
    I: INTEGER;
begin
  ClrScr;
  Assign(FTeplota, 'zoznam.dat');
  Rewrite(FTeplota);
  for i := 1 to 31 do
  begin
    Write('Zadaj teplotu ',i,'.januara');
    Readln(Denna_teplota);
    Writeln(FTeplota, Denna_teplota);
  end;
  Close(FTeplota);
end.