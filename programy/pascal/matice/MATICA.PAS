{Andrea Turiakova, Gymnazium J.M.Hurbana,3 seminar}

program matica;
uses crt;
var koniec,prikaz:char;
    m,n,i,j,k,l:smallint;
    matica_A,matica_B,matica_C:array[1..8,1..8] of integer;

procedure suc_koef;
begin
writeln(' Vybral si NASOBENIE MATICE KOEFICIENTOM');
write(' Zadaj pocet riadkov matice:');readln(m);
write(' Zadaj pocet stlpcov matice:');readln(n);
write(' Zadaj koeficient sucinu: ');readln(k);
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice A:');readln(matica_A[i,j]);
                    end;
for i:=1 to m do
   for j:=1 to n do
   matica_C[i,j]:=k*matica_A[i,j];
end;

procedure sucet;
begin
writeln(' Vybral si SUCET DVOCH MATIC');
write(' Zadaj pocet riadkov matic:');readln(m);
write(' Zadaj pocet stlpcov matic:');readln(n);
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice A:');readln(matica_A[i,j]);
                    end;
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice B:');readln(matica_B[i,j]);
                    end;
for i:=1 to m do
   for j:=1 to n do
   matica_C[i,j]:=matica_A[i,j]+matica_B[i,j];

end;


procedure rozdiel;
begin
writeln(' Vybral si ROZDIEL DVOCH MATIC');
write(' Zadaj pocet riadkov matic:');readln(m);
write(' Zadaj pocet stlpcov matic:');readln(n);
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice A:');readln(matica_A[i,j]);
                    end;
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice B:');readln(matica_B[i,j]);
                    end;
for i:=1 to m do
   for j:=1 to n do
   matica_C[i,j]:=matica_A[i,j]-matica_B[i,j];

end;

procedure sucin;
begin
writeln(' Vybral si SUCIN DVOCH MATIC');
write(' Zadaj pocet riadkov matice A: '); readln(m);
write(' Zadaj pocet stplcov matice A a pocet riadov matice B: '); readln(n);
write(' Zadaj pocet stlpcov matice B: '); readln(k);
for i:=1 to m do
   for j:=1 to n do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice A:');readln(matica_A[i,j]);
                    end;
for i:=1 to n do
   for j:=1 to k do begin
   write(' Zadaj prvok ',i,'. riadku ',j,'. stlpca Matice B:');readln(matica_B[i,j]);
                    end;

for i:=1 to m do
   for j:=1 to k do   begin
     matica_C[i,j]:=matica_A[i,1]*matica_B[1,j];
     for l:=2 to n do
     matica_C[i,j]:=matica_C[i,j]+(matica_A[i,l]*matica_B[l,j]);
                      end;
end;

procedure nadpis;
begin
clrscr;
writeln;
writeln('                     OPERACIE S MATICAMI');
writeln('                     -------------------');
writeln;writeln;
end;

begin
repeat
clrscr;
nadpis;
writeln(' Vyber z nasledujucej ponuky operaciu: ');
writeln(' 1) NASOBENIE MATICE KOEFICIENTOM');
writeln(' 2) SUCET DVOCH MATIC');
writeln(' 3) ROZDIEL DVOCH MATIC');
writeln(' 4) SUCIN DVOCH MATIC');
read(prikaz);

clrscr;
nadpis;

case prikaz of
'1':  suc_koef;
'2':  sucet;
'3':  rozdiel;
'4':  sucin;
end;

clrscr;
nadpis;

gotoxy(100,50);
write('Matica A');
for i:=1 to m do
writeln;
for j:=1 to n do  begin
gotoxy((100+j*10),(51+5*i));write(matica_A[i,j]);
                  end;

if (prikaz='2') or (prikaz='3') or (prikaz='4') then begin
 gotoxy(160,50); write('Matica B');

  If (prikaz='2') or (prikaz='3') then begin
  for i:=1 to m do
  writeln;
    for j:=1 to n do begin
      gotoxy((160+j*10),(51+5*i));
     write(matica_B[i,j],'  ');
                     end;
                                   end
  else
  for i:=1 to m do
  writeln;
  for j:=1 to k do  begin
  gotoxy((160+j*10),(51+5*i));
  write(matica_B[i,j],'  ');
                    end;
                                                     end;
gotoxy(220,50);
writeln('Matica C');
if (prikaz='1') or (prikaz='2') or (prikaz='3') then
for i:=1 to m do

    for j:=1 to n do  begin
    gotoxy((220+j*10),(51+5*i));
    write(matica_C[i,j],'   ');
                   end
                                             else
for i:=1 to m do
writeln;
    for j:=1 to k do begin
    gotoxy((220+j*10),(51+5*i));
    write(matica_C[i,j],'   ');
                   end;
writeln;writeln;writeln;
writeln(' Chces program opakovat? Pre ukoncenie stlac n/N');
koniec:=readkey;
until (koniec='n') or (koniec='N');
end.

