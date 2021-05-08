program tetivy;
uses crt;
var pole:array [1..20] of real;
    x:array [0..20] of real;
    pocet,i6:integer;
    presnost,a,b:real;


procedure nadpis;
begin
clrscr;
writeln;
writeln('           Regula falsi');
writeln;
writeln;
end;

procedure nacitanie;
var i,pom:byte;
begin
write('Zadaj stupen mnohoclenu:');
read(pocet);
pocet:=pocet+1;
writeln;
write('f(x)=');
for i:=pocet downto 2 do
write('       x^',i-1,'+');
pom:=0;
for i:=1 to pocet do begin
pom:=pom+1;
gotoxy((10*i)-4+pom,7);
read(pole[i]);
end;

writeln;
writeln('Zadaj interval pre X: <a,b>');
write('a=');
read(a);
write('b=');
read(b);
writeln;
write('Zadaj presnost: ');
read(presnost);
end;


function mocnina(cis:real; exp:integer):real;
var i3:byte;
    k:real;
begin
k:=cis;
if exp=1 then mocnina:=cis
         else if exp=0 then mocnina:=1
                       else begin for i3:=1 to exp-1 do k:=k*cis; mocnina:=k; end;
end;


function f(cislo:real):real;
var i,i2:integer;
    vys:real;
begin
i2:=pocet;
vys:=0;
for i:=1 to pocet do begin
i2:=i2-1;
vys:=pole[i]*mocnina(cislo,i2)+vys;
end;
f:=vys;
end;

function derivacia(x:real):real;
var pole1:array[1..20] of real;
    pom,i4,i5:integer;

begin
pole1:=pole;
pom:=pocet+1;
for i5:=1 to 3 do begin
for i4:=2 to pom do pole1[i4]:=(pole1[i4-1]*x)+pole1[i4];
pom:=pom-1;
                        end;
derivacia:=pole1[pom]*2;
end;



BEGIN
nadpis;
nacitanie;

if (f(a)*f(derivacia(a))) >0 then begin
 x[0]:=b;
 i6:=0;
 repeat
  i6:=i6+1;
  x[i6]:=(((a*f(x[i6-1]))-(x[i6-1]*f(a)))/(f(x[i6-1])-f(a)));
 until ((abs(x[i6]-x[i6-1])) < presnost);
 end

                             else begin
 x[0]:=a;
 i6:=0;
 repeat
  i6:=i6+1;
  x[i6]:=(((x[i6-1]*f(b))-(b*f(x[i6-1])))/(f(b)-f(x[i6-1])));
 until ((abs(x[i6]-x[i6-1])) < presnost);
 end;
writeln;
writeln;
writeln('X patri <',x[i6]:2:4,';',(x[i6]+presnost):2:4,'>');
writeln('X sa rovna priblizne ',((x[i6]+(x[i6]+presnost))/2):2:4);

readkey;
end.




