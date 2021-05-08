(*
   Autor  : Michal Cisarik 4.E Gymnazium J.M.Hurbana Cadca
            e-mail : alcatrazer@orangemail.sk
            mobil  : +421907877569

   15. marca 2006

   Verzia : 1.5
*)

Program  Hra_Zivot;


Uses     Crt4p2,Graph,Dos;


Type     generacia = array [0..41,0..41] of boolean;


Const

         RYCHLOSTI: array [1..6] of integer=(10000,4833,2250,958,312,1);


         STABILNA    :array[1..2,1..2] of boolean=
          ((true,true),
           (true,true));

          VYHYNIE1    :array[1..5,1..5] of boolean=
          (
           (false,false,true,false,false),
           (false,false,true,false,false),
           (true ,true ,true,true ,true ),
           (false,false,true,false,false),
           (false,false,true,false,false));

          VYHYNIE2   :array[1..5,1..5] of boolean=
          (
           (false,false,false,false,true ),
           (false,false,false,true ,false),
           (false,false,true ,false,false ),
           (false,true ,false,false,false),
           (true ,false,false,false,false));

           CYKLICKA1   :array[1..3,1..3] of boolean=
          ((false,false,false),
           (true ,true ,true),
           (false,false,false));

           CYKLICKA2   :array[1..10,1..10] of boolean=
           ((false,false,false,false,false,false,false,false,false,false),
            (false,false,false,false,false,false,false,false,false,false),
            (false,false,false,false,false,false,false,false,false,false),
            (false,false,true ,false,false,false,false,true ,false,false),
            (true ,true ,false,true ,true ,true ,true ,false,true ,true ),
            (false,false,true ,false,false,false,false,true ,false,false),
            (false,false,false,false,false,false,false,false,false,false),
            (false,false,false,false,false,false,false,false,false,false),
            (false,false,false,false,false,false,false,false,false,false),
            (false,false,false,false,false,false,false,false,false,false));

           POSUVAJUCA1 :array[1..3,1..3] of boolean=
          ((true ,false,true),
           (false,true ,true),
           (false,true ,false));


Var
          vstup     : generacia;

          RANDOM1
          ,RANDOM2  : array [1..8,1..8] of boolean;

          historia  : array [1..10] of generacia;

          subor     : file;


          susedov   : 0..8;

          i,j,k,
          m,n,
          x,y,h,v   : integer;

          mb,nb,kb  : byte;

          xo,yo     : integer;
          xx,yy     : integer;

          koniec,uz,
          play,raz  : boolean;

          s,s2,ret,
          rych      : string;

          mena      : array [1..100] of string;

          velkost   : integer;
          long      : longint;

          rychlost  : byte;

          okno      : record
                       bajtov   : word;
                       bajtov2  : word;
                       pamat    : pointer;
                       pamat2   : pointer;
                      end;


{inicializovanie grafiky}
Procedure init;
Var  gd,gm:integer;
     cesta:string;
begin
  DetectGraph(gd,gm);
  cesta:=ParamStr(0);

  cesta:=copy(cesta,1,length(cesta)-9);


  InitGraph(gd,gm,cesta);
  i:=GraphResult;
end;


{-------------------------------- M Y S -----------------------------------}

Function _x:integer;
var xko:integer;
begin
  asm
   mov ax,$0003
   int 33h
   mov xko,cx
  end;
  _x:=xko;
end;

Function _y:integer;
var yko:integer;
begin
  asm
   mov ax,$0003
   int 33h
   mov yko,dx
  end;
  _y:=yko;
end;

procedure nastav(x_,y_:integer);assembler;
  asm
   mov ax,$0004
   mov cx,x_
   mov dx,y_
   int 33h
  end;

Procedure reset_mys;assembler;
  asm
   mov ax,$0000
   int 33h
  end;

Procedure ukaz;assembler;
  asm
   mov ax,$0001
   int 33h
  end;

Procedure zrus;assembler;
  asm
   mov ax,$0002;
   int 33h
  end;

Procedure dookna(x1,y1,x2,y2 : integer); assembler;
  asm
    mov ax,$0007
    mov cx,x1
    mov dx,x2
    int $33
    mov ax,$0008
    mov cx,y1
    mov dx,y2
    int $33
  end;

function lave :boolean;
var r    : registers;
begin
     r.ax:=$0005;
     r.bx:=0;
     intr($33,r);
     if (r.ax and 1) = 1 then begin
        lave:=true;
        r.bx:=3
        end
      else lave:=false;
end;

{|Caka kym sa pohne mys|}
Procedure kym_mys;
Begin
  xo:=_x;
  yo:=_y;
  repeat
  until (_x<>xo) or (_y<>yo) or (lave);
  xo:=_x;
  yo:=_y;
End;


{---------------------------- D E L A Y -----------------------------------}

{Cakanie na zatemnenie obrazovky.Na VGA adrese 3DAH precita ci je a caka nan}
{Frekvencia Horizontalnej je priblizne 31 kH}
procedure retracia ; assembler ;
 asm
  mov dx,3DAh
  @@1: in al,dx
  and  al,09h  {08h- vertikalne 09h- horizontalne}
  jnz @@1
  @@2: in al,dx
  and  al,09h  {08h- vertikalne 09h- horizontalne}
  jz  @@2
 end ;


{Vyuzitie zatemnenia VGA ako delay kedze je na kazdom PC pomerne rovnake}
{Pre jednu sekundu treba priblizne 31 000}
procedure ret_delay(ms : longint) ;
begin
 while (ms<>0) and (lave=false) do
 begin
  retracia;
  dec(ms);
 end;
end;

{-------------------------- G R A F I K A ---------------------------------}

Procedure do2pamate(x1,y1,x2,y2:word);
Begin
 with okno do
 begin
  bajtov2:=ImageSize(x1,y1,x2,y2);
  GetMem(pamat2,bajtov2);
  zrus;
  GetImage(x1,y1,x2,y2,pamat2^);
  ukaz;
 end;
End;


Procedure z2pamate(x1,y1:word);
Begin
 with okno do
 begin
  zrus;
  PutImage(x1,y1,pamat2^,NormalPut);
  FreeMem(pamat2,bajtov2);
  ukaz;
 end;
End;

Procedure dopamate(x1,y1,x2,y2:word);
Begin
 with okno do
 begin
  bajtov:=ImageSize(x1,y1,x2,y2);
  GetMem(pamat,bajtov);
  zrus;
  GetImage(x1,y1,x2,y2,pamat^);
  ukaz;
 end;
End;


Procedure zpamate(x1,y1:word);
Begin
 with okno do
 begin
  zrus;
  PutImage(x1,y1,pamat^,NormalPut);
  FreeMem(pamat,bajtov);
  ukaz;
 end;
End;


Procedure pozadie;
Begin
  SetFillStyle(9,8);
  bar(0,0,GetMaxX,GetMaxY);
  SetFillStyle(1,6);
  bar(0,0,GetMaxX,15);
  bar(0,GetMaxY-25,GetMaxX,GetMaxY);

  line(0,15,GetMaxX,15);
  line(0,GetMaxY-25,GetMaxX,GetMaxY-25);

  setcolor(15);
  SetFillStyle(1,7);
  bar(465,460,605,475);
  SetLineStyle(0,0,2);
  RecTangle(465,460,605,475);
  OutTextXY(512,465,'Pomoc?');
End;


Procedure hlavicka;
Begin
  Setcolor(7);
  Settextstyle(0,0,7);
  OutTextXY(178,58,'ZIVOT');

  Setcolor(8);
  Settextstyle(0,0,7);
  OutTextXY(185,62,'ZIVOT');

  Setcolor(white);
  Settextstyle(0,0,7);
  OutTextXY(180,60,'ZIVOT');

  Settextstyle(0,0,1);
  OutTextXY(100,400,'Program na simulaciu zivota spolocenstva mikroorganizmov');

  Settextstyle(0,0,0);
End;


Procedure mriezka;
Begin
  SetFillStyle(1,0);
  bar(16,16,426,453);
  SetColor(8);
  x:=10;
  y:=10;
  for i:=2 to 41 do
  for j:=2 to 41 do
  rectangle(i*x+2,j*y+2,(i*x)+x,(j*y)+y);
  SetColor(7);
End;

Procedure button_menu_normal(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  setcolor(7);
  SetFillStyle(1,8);
  bar(x1,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);

  SetFillStyle(1,8);
  bar(x2-15,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x2-15,y1,x2,y2);
  setcolor(white);
  OutTextXY(x2-11,y1+7,chr(25));

  setcolor(7);
  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  ukaz;
end;


Procedure button_menu_hover(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  SetFillStyle(0,9);
  setcolor(15);
  bar(x1,y1,x2,y2);
  setcolor(15);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);

  SetFillStyle(1,7);
  bar(x2-15,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x2-15,y1,x2,y2);
  setcolor(white);
  OutTextXY(x2-11,y1+7,chr(25));

  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  SetFillStyle(1,8);
  ukaz;
end;

Procedure button_menu_click(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  setcolor(15);
  SetFillStyle(1,7);
  bar(x1,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);

  SetFillStyle(1,15);
  bar(x2-15,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x2-15,y1,x2,y2);
  setcolor(7);
  OutTextXY(x2-11,y1+7,chr(25));

  setcolor(15);
  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  ukaz;
end;

Function button_menu_klik(x,y,x2,y2:integer;text:string):Boolean;
Begin
 button_menu_klik:=false;
 if (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) then
 begin
  button_menu_hover(x,y,x2,y2,text);
  while (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) do
  begin
   if lave then
   begin
    button_menu_klik:=true;
    button_menu_click(x,y,x2,y2,text);
    while lave do begin end;
    if not ((_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2)) then button_menu_klik:=false;
    break;
   end;
  end;
  button_menu_normal(x,y,x2,y2,text);
 end;
End;


Procedure button_normal(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  setcolor(7);
  SetFillStyle(1,8);
  bar(x1,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);

  setcolor(7);
  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  ukaz;
end;

Procedure button_hover(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  SetFillStyle(0,9);
  setcolor(15);
  bar(x1,y1,x2,y2);

  setcolor(15);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);
  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  SetFillStyle(1,8);
  ukaz;
end;

Procedure button_click(x1,y1,x2,y2:integer;text:string);
begin
  zrus;
  setcolor(15);
  SetFillStyle(1,7);
  bar(x1,y1,x2,y2);
  SetLineStyle(0,0,2);
  RecTangle(x1,y1,x2,y2);

  setcolor(15);
  OutTextXY((x1+((x2-x1) div 2))-(TextWidth(text) div 2),
            (y1+((y2-y1) div 2))-(TextHeight(text) div 2),text);
  setcolor(7);
  ukaz;
end;

Function button_klik(x,y,x2,y2:integer;text:string):Boolean;
Begin
 button_klik:=false;
 if (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) then
 begin
  button_hover(x,y,x2,y2,text);
  while (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) do
  begin
   if lave then
   begin
    button_klik:=true;
    button_click(x,y,x2,y2,text);
    while lave do begin end;
    if not ((_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2)) then button_klik:=false;
    break;
   end;
  end;
  button_normal(x,y,x2,y2,text);
 end;
End;


Function button_menu(x,y,x2,y2:integer;text:string;texty_spolu:string;pocet:byte):byte;
var
    i,kolko,k  : byte;
    podavanie  : boolean;
    vsetkych   : byte;

Begin
  kolko:=1;
  k:=0;
  podavanie:=false;

  for i:=1 to 100 do mena[i]:='';

  {rozdelenie vstupu <text1~text2~text3~...~> a zistenie poctu podmenu}
  for i:=1 to length(texty_spolu) do
  begin
   if texty_spolu[i]='~' then
   begin
    mena[kolko]:=copy(texty_spolu,i-k,k);
    inc(kolko);
    k:=0;
   end else inc(k);
  end;
  dec(kolko);
  vsetkych:=kolko;

  {Ak nevyjde na obrazovku zapnut podavanie}
  if (y2+(20*(kolko+1))>GetMaxY) or (pocet<>0) then podavanie:=true;

  if podavanie then
  begin
   yy:=i;

   {Ak by menu nevyslo na obrazovku vypocitat kolko tlacitok vyjde}
   while (y2+(20*kolko)>GetMaxY) do dec(kolko);
   dec(kolko);

   if pocet<>0 then kolko:=pocet+1;
   xx:=1;

   dopamate(x,y2,x2,y2+(20*(kolko+1)));

   button_menu_normal(x,y2,x2,y2+(20*(kolko+1)),'');
   for i:=1 to kolko do
   button_normal(x,y2+((20*(i+1))-20),x2,y2+(20*(i+1)),mena[i]);

   button_normal(x,y2+((20)-20),x2,y2+(20),'');
   button_normal(x,y2+((20*(kolko+1))-20),x2,y2+(20*(kolko+1)),'')
  end else
  begin
   dopamate(x,y2,x2,y2+(20*(kolko)));

   button_menu_normal(x,y2,x2,y2+(20*kolko),'');
   for i:=1 to kolko do
   button_normal(x,y2+((20*i)-20),x2,y2+(20*i),mena[i]);
  end;

  button_menu:=0;
  koniec:=false;

  if podavanie then
  repeat
       if button_klik(x,y2+((20)-20),x2,y2+(20),'') then
       if (xx>1) then
       begin
        dec(xx);

        xo:=xx;
        for i:=1 to kolko-1 do
        begin
         button_normal(x,y2+((20*(i+1))-20),x2,y2+(20*(i+1)),mena[xx]);
         inc(xx);
        end;
        xx:=xo;
       end;

       xo:=xx;
       for i:=1 to kolko-1 do
       begin
        if button_klik(x,y2+((20*(i+1))-20),x2,y2+(20*(i+1)),mena[xx]) then
        begin
         button_menu:=xx;
         koniec:=true;
        end;
        if lave then
        begin
         koniec:=true;
         break;
        end;
        inc(xx);
       end;
       xx:=xo;

       if button_klik(x,y2+((20*(kolko+1))-20),x2,y2+(20*(kolko+1)),'') then
       if (xx+kolko-2<vsetkych) then
       begin
        inc(xx);
        xo:=xx;
        for i:=1 to kolko-1 do
        begin
         button_normal(x,y2+((20*(i+1))-20),x2,y2+(20*(i+1)),mena[xx]);
         inc(xx);
        end;
        xx:=xo;
       end;

    if (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) then
    begin
     button_menu_click(x,y,x2,y2,text);
     while (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) do
     begin
      if lave then
      begin
       if lave then while lave do begin end;
       koniec:=true;
       break;
      end;
     end;
    end;

  until koniec
  else
  repeat
    for i:=1 to kolko do
    begin
     if button_klik(x,y2+((20*i)-20),x2,y2+(20*i),mena[i]) then
      begin
       button_menu:=i;
       koniec:=true;
      end;
     if lave then
      begin
       koniec:=true;
       break;
      end;
    end;

    if (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) then
    begin
     button_menu_click(x,y,x2,y2,text);
     while (_x>=x) and (_y>=y) and (_x<=x2) and (_y<=y2) do
     begin
      if lave then
      begin
       if lave then while lave do begin end;
       koniec:=true;
       break;
      end;
     end;
    end;
  until koniec;

  zpamate(x,y2);
  button_menu_normal(x,y,x2,y2,text);
End;


{Funkcia na vkladanie textu v grafike (dlzka je nastavena na 14)}
{Font a velkost treba nastavit pred volanim procedury}
Function Vloztext(x,y:integer):string;
var ret:string;
    i:byte;
    zn:char;
    integ,error,sirka:integer;
begin
  ret:='%';
  zn:='%';
  sirka:=textwidth(' ');
  while (ord(zn)<>13) do
  begin
    OutTextXY(x+(length(ret)*SIRKA),y,'_');
    zn:=readkey;
    bar(x+(length(ret)*SIRKA),y,x+(length(ret)*SIRKA)+SIRKA,y+textheight('I'));
    if ord(zn)=27 then
    begin
     Vloztext:='';
     exit;
    end else
    if (ord(zn)>31) and (length(ret)<=14) then
    begin
      OutTextXY(x+(length(ret)*SIRKA),y,zn);
      ret:=ret+zn;
    end
    else if (ord(zn)=8) and (length(ret)>1) then
    begin
      bar(x+(length(ret)*SIRKA)-SIRKA,y,x+(length(ret)*SIRKA){+SIRKA},y+textheight('I'));
      ret:=copy(ret,1,length(ret)-1);
    end;
  end;
  Vloztext:=copy(ret,2,length(ret));
end;


{--------------------------- P O M O C N I K ------------------------------}

Procedure _pomoc(aka:byte);
var an     : boolean;
    oo,ooo : byte;
    reto   : string;

    Procedure button_mini(x,y:integer;text:string);
    begin
     Setcolor(white);
     button_click(x-4,y-2,x+textwidth(text)+4,y+textheight(text)+1,text);
     Setcolor(7);
    end;

    Procedure zmen(na:byte);
    begin
     zrus;
     button_normal(150,100,480,380,'');
     button_menu_normal(180,145,450,165,'Vsetky temy pomocnika');
     button_normal(180,350,450,370,'Zatvorit');
     case na of
     1:
      begin
       button_click(150,100,480,120,'Pomocnik: Hlavne menu');

       button_mini(180+textwidth('Pomocou '),190,'Nacitanie zo suboru');

       OutTextXY(180,190,'Pomocou                      mozete');
       OutTextXY(180,200,'pracovat zo suborom v ktorom su');
       OutTextXY(180,210,'ulozene preddefinovane generacie.');

       button_mini(180+textwidth('Tlacidlom '),230,'Vytvorenie spolocenstva');

       OutTextXY(180,230,'Tlacidlom');
       OutTextXY(180,240,'sa vytvorite spolocenstvo, ktoreho');
       OutTextXY(180,250,'zivot chcete simulovat.');

       button_mini(180+textwidth('Tlacidlom '),270,'Informacie');

       OutTextXY(180,270,'Tlacidlom             sa dostanete');
       OutTextXY(180,280,'k informaciam o programe a o autorovi');

       button_mini(180+textwidth('Tlacidlo '),300,'Koniec');

       OutTextXY(180,300,'Tlacidlo         ukonci program.');
      end;
     2:
      begin
       button_click(150,100,480,120,'Pomocnik: Informacie o programe');

       button_mini(180+textwidth('Tlacidlami '),190,'O autorovi');
       button_mini(180+textwidth('Tlacidlami               '),190,'O programe');

       OutTextXY(180,190,'Tlacidlami             ,');
       OutTextXY(180,200,'menite obsah okna prislusnymi');
       OutTextXY(180,210,'informaciami.');

       button_mini(180,230,'Zrusit');

       OutTextXY(180,230,'        vrati do hlavneho menu');
      end;
     3:
      begin
       button_click(150,100,480,120,'Pomocnik: Vytvorenie spolocenstva');
       OutTextXY(180,190,'Kliknutim do mriezky vkladate a ');
       OutTextXY(180,200,'opatovnym kliknutim rusite organizmy');

       button_mini(180,220,'Generuj spolocenstvo');

       OutTextXY(180+textwidth('(Generuj spolocenstvo'),220,' vlozi');
       OutTextXY(180,230,'dany pocet organizmov do nahodnych');
       OutTextXY(180,240,'pozicii mriezky.');

       button_mini(180,250,'Pregeneruj');

       OutTextXY(180+textwidth('(Pregeneruj'),250,' nahodne zmeni dve');
       OutTextXY(180,260,'z predvolenych spolocenstiev vpravo,');
       OutTextXY(180,270,'ktore spolu s ostatnymi pevne danymi');
       OutTextXY(180,280,'vlozite KLIKNUTIM A PRENESENIM');
       OutTextXY(180,290,'NA LUBOVOLNE MIESTO MRIEZKY.');

       button_mini(180,300,'Zmazat');

       OutTextXY(180+textwidth('Zmazat '),300,' premaze cele spolocenstvo.');

       button_mini(180,320,'Simulacia');

       OutTextXY(180+textwidth('Simulacia '),320,' pre pokracovanie.');

       button_mini(180+textwidth('Navrat do menu tlacidlom '),330,'Zrusit');

       OutTextXY(180,330,'Navrat do menu tlacidlom');
      end;
     4:
      begin
       button_click(150,100,480,120,'Pomocnik: Simulacia vseobecne');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Vseobecne');

       OutTextXY(180,220,'Simulacia prebieha v mriezke,');
       OutTextXY(180,230,'v ktorej spolocenstvo zije.');
       OutTextXY(180,240,'Vznika historia spolocenstva.');

       OutTextXY(180,260,'Organizmus ktory prezil je');
       OutTextXY(180,270,'vizualne odliseny od narodeneho.');
       OutTextXY(180,280,'Organizmus, ktory hynie je zobrazeny');
       OutTextXY(180,290,'len vymedzeny cas, potom sa strati.');

       OutTextXY(180,310,'Vpravo hore je poradie generiacie.');
       OutTextXY(180,330,'Simulaciu zrusite stlacenim');

       button_mini(180+textwidth('Simulaciu zrusite stlacenim '),330,'Zrusit');
      end;
     5:
      begin
       button_click(150,100,480,120,'Pomocnik: Simulacia ovladanie');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Ovladanie');

       OutTextXY(180,220,'Priebeh simulacie zacnete stlacenim');
       OutTextXY(180,230,'tlacidla');

       button_mini(180+textwidth('tlacidla '),230,'Hraj');

       OutTextXY(180,240,'Pozastavite stlacenim');

       button_mini(180+textwidth('Pozastavite stlacenim '),240,'Zastav');

       OutTextXY(180,250,'V historii sa mozete pohybovat aj');
       OutTextXY(180,260,'po jednej generacii:');
       OutTextXY(180,270,'Tlacidlami');

       button_mini(180+textwidth('Tlacidlami '),270,'>');

       OutTextXY(180+textwidth('Tlacidlami    '),270,'vpred');

       button_mini(180+textwidth('Tlacidlami '),290,'<');

       OutTextXY(180+textwidth('Tlacidlami    '),290,'vzad');

       OutTextXY(180,310,'V pamati je ulozenych poslednych');
       OutTextXY(180,320,'desat generacii.');
      end;
     6:
      begin
       button_click(150,100,480,120,'Pomocnik: Simulacia ukladanie');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Ukladanie');

       OutTextXY(180,220,'Aktualny snimok z historie mozete');
       OutTextXY(180,230,'ulozit do typoveho suboru a neskor');
       OutTextXY(180,240,'otvorit priamo na simulaciu,');
       OutTextXY(180,250,'alebo na upravenie.');

       OutTextXY(180,270,'Stlacenim');

       button_mini(180+textwidth('Stlacenim '),270,'Ulozit');

       OutTextXY(180,280,'Otvorite roletove menu v ktorom');
       OutTextXY(180,290,'vyberiete kategoriu, snimok ulozite');
       OutTextXY(180,300,'ako novy, alebo prepisete stary.');
       OutTextXY(180,320,'Menu zrusite kliknutim na lubovolne');
       OutTextXY(180,330,'miesto obrazovky.');
      end;
     7:
      begin
       button_click(150,100,480,120,'Pomocnik: Simulacia rychlost');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Rychlost');

       OutTextXY(180,220,'Mozete ovplyvnovat rychlost procesu');
       OutTextXY(180,230,'simulacie a to tlacidlom');

       button_mini(180+textwidth('simulacie a to tlacidlom '),230,'Rychlost');

       OutTextXY(180,250,'Rychlost');

       button_mini(180+textwidth('Rychlost '),250,' 1x ');

       OutTextXY(180+textwidth('Rychlost       '),250,'by mala na na kazdom');
       OutTextXY(180+textwidth('Rychlost       '),260,'pocitaci zodpovedat');
       OutTextXY(180+textwidth('Rychlost       '),270,'priblizne sekundovej');
       OutTextXY(180+textwidth('Rychlost       '),280,'pauze po kazdom snimku');

       button_mini(180+textwidth('Rychlost '),300,' max');

       OutTextXY(220,300,'Pri');
       OutTextXY(180+textwidth('Rychlost       '),300,'je rychlost zavisla');
       OutTextXY(180+textwidth('Rychlost       '),310,'len od pocitaca.');
      end;
     8:
      begin
       button_click(150,100,480,120,'Pomocnik: Nacitanie zo suboru');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Nacitavanie');

       OutTextXY(180,220,'Tlacidlami ');
       button_mini(180+textwidth('Tlacidlami '),220,'Nacitat cyklicke');
       button_mini(180+textwidth('Tlacidlami '),235,'Nacitat staticke');
       button_mini(180+textwidth('Tlacidlami '),250,'   Nacitat ine  ');

       OutTextXY(180,270,'otvorite menu s nazvami spolocenstiev');
       OutTextXY(180,280,'z kategorie pod ktorou su ulozene a ');
       OutTextXY(180,290,'vybratim spolocenstvo otvorite.');

       OutTextXY(180,310,'V roletovom menu sa posuvate pomocou:');

       button_mini(250,325,'    ');
       button_mini(350,325,'    ');
      end;
     9:
      begin
       button_click(150,100,480,120,'Pomocnik: Praca zo suborom');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Praca zo suborom');

       OutTextXY(180,220,'Program pracuje s typovym suborom,');
       OutTextXY(180,230,'ktory ma vzdy nazov <zivot.dat>');

       OutTextXY(180,250,'Cestu k nemu nastavite tlacidlom');

       button_mini(180,265,'Nastavenit cestu');

       OutTextXY(180,280,'Aktualna cesta je vypisana v pravo');
       OutTextXY(180,290,'hore spolu s velkostou daneho suboru.');

       OutTextXY(180,310,'Novy prazdny subor vytvorite v');
       OutTextXY(180,320,'nastavenej ceste pomocou tlacidla');

       button_mini(270,333,'Novy subor');
      end;
     10:
      begin
       button_click(150,100,480,120,'Pomocnik: Cesta k suboru');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Cesta k suboru');

       OutTextXY(180,220,'Po stlaceni tlacidla ');

       button_mini(180+textwidth('Po stlaceni tlacidla '),220,'Nastavit cestu');

       OutTextXY(180,230,'mozete menit cestu k suboru a to');
       OutTextXY(180,243,'tlacidlom');

       button_mini(180+textwidth('tlacidlom '),243,'Zmenit cestu');

       OutTextXY(180,260,'Ak zadate platnu cestu bude');
       OutTextXY(180,270,'zivot.dat automaticky otvoreny.');

       OutTextXY(180,280,'Ak sa v danom adresary nenachadza');
       OutTextXY(180,290,'mozete ho v nom vytvorit tlacidlom');

       button_mini(270,305,'Vytvorit');

       OutTextXY(180,325,'Menu zrusite tlacidlom');

       button_mini(180+textwidth('Menu zrusite tlacidlom '),325,'Zrusit');
      end;
     11:
      begin
       button_click(150,100,480,120,'Pomocnik: Otvorene spolocenstvo');

       setcolor(white);
       OutTextXY(170,190,'Okruh pomoci:');
       setcolor(7);

       button_menu_normal(280,185,470,205,'Otvorene spolocenstvo');

       OutTextXY(180,220,'Po vybere spolocenstva z menu');
       OutTextXY(180,230,'mozete dane spolocenstvo premenovat');
       OutTextXY(180,243,'tlacidlom');

       button_mini(180+textwidth('tlacidlom '),243,'Premenovat');

       OutTextXY(350,243,' alebo ho');
       OutTextXY(180,263,'zo suboru definitivne vymazat');

       OutTextXY(180,273,'a to tlacidlom');
       button_mini(180+textwidth('a to tlacidlom '),273,'Vymazat');

       OutTextXY(180,293,'Tlacidlom');

       button_mini(180+textwidth('Tlacidlom '),293,'Editovat');

       OutTextXY(340,293,'ho editujete a');

       OutTextXY(180,303,'jeho simulaciu zacnete stlacenim');

       OutTextXY(180,316,'Tlacidla');
       button_mini(180+textwidth('Tlacidla '),316,'Simulacia');

       OutTextXY(180,330,'Navrat do hlavneho menu');

       button_mini(180+textwidth('Navrat do hlavneho menu '),330,'Zrusit');
      end;
     end;
     ukaz;
    End;
Begin
  an:=false;

  if (_x>=465) and (_y>=460) and (_x<=605) and (_y<=475) then
  begin
    zrus;
    setcolor(7);
    SetFillStyle(1,15);
    bar(465,460,605,475);
    SetLineStyle(0,0,2);
    RecTangle(465,460,605,475);
    OutTextXY(512,465,'Pomoc?');
    ukaz;

   while (_x>=465) and (_y>=460) and (_x<=605) and (_y<=475) do
   begin
    if lave then
    begin
     an:=true;
      zrus;
      setcolor(15);
      SetFillStyle(1,8);
      bar(465,460,605,475);
      SetLineStyle(0,0,2);
      RecTangle(465,460,605,475);
      OutTextXY(512,465,'Pomoc?');
      ukaz;
     while lave do begin end;
     if not ((_x>=465) and (_y>=460) and (_x<=605) and (_y<=475)) then an:=false;
     break;
    end;
   end;
    zrus;
    setcolor(15);
    SetFillStyle(1,7);
    bar(465,460,605,475);
    SetLineStyle(0,0,2);
    RecTangle(465,460,605,475);
    OutTextXY(512,465,'Pomoc?');
    ukaz;
  end;

 if an then
 begin
  dookna(0,0,GetMaxX,GetMaxY);
  zrus;
  do2pamate(150,100,480,380);
  ukaz;

  oo:=aka;
  zmen(aka);
  repeat
   if button_menu_klik(180,145,450,165,'Vsetky temy pomocnika') then
   begin
    reto:='Hlavne menu~Informacie o programe~Vytvorenie spolocenstva~Simulacia-vseobecne~';
    reto:=reto+'Simulacia-ovladanie~Simulacia-ukladanie~Simulacia-rychlost~';
    reto:=reto+'Praca zo suborom-nacitavanie~Praca zo suborom-subor~Praca zo suborom-cesta~';
    reto:=reto+'Praca zo suborom-spolocenstvo~';
    ooo:=button_menu(180,145,450,165,'Vsetky temy pomocnika',reto,0);
    if ooo<>0 then
    begin
     oo:=ooo;
     zmen(oo);
    end;
   end;

   if (oo=4) then
   if (button_menu_klik(280,185,470,205,'Vseobecne')) then
   begin
    ooo:=button_menu(280,185,470,205,'Vseobecne','Vseobecne~Ovladanie~Ukladanie~Rychlost~',0);
    if ooo<>0 then
    begin
     inc(ooo,3);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=5) then
   if (button_menu_klik(280,185,470,205,'Ovladanie')) then
   begin
    ooo:=button_menu(280,185,470,205,'Ovladanie','Vseobecne~Ovladanie~Ukladanie~Rychlost~',0);
    if ooo<>0 then
    begin
     inc(ooo,3);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=6) then
   if (button_menu_klik(280,185,470,205,'Ukladanie')) then
   begin
    ooo:=button_menu(280,185,470,205,'Ukladanie','Vseobecne~Ovladanie~Ukladanie~Rychlost~',0);
    if ooo<>0 then
    begin
     inc(ooo,3);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=7) then
   if (button_menu_klik(280,185,470,205,'Rychlost')) then
   begin
    ooo:=button_menu(280,185,470,205,'Rychlost','Vseobecne~Ovladanie~Ukladanie~Rychlost~',0);
    if ooo<>0 then
    begin
     inc(ooo,3);
     zmen(ooo);
     oo:=ooo;
    end;
   end;


   if (oo=8) then
   if (button_menu_klik(280,185,470,205,'Nacitavanie')) then
   begin
    ooo:=button_menu(280,185,470,205,'Nacitavanie',
    'Nacitavanie~Praca zo suborom~Cesta k suboru~Otvorene spolocenstvo~',0);
    if ooo<>0 then
    begin
     inc(ooo,7);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=9) then
   if (button_menu_klik(280,185,470,205,'Praca zo suborom')) then
   begin
    ooo:=button_menu(280,185,470,205,'Praca zo suborom',
    'Nacitavanie~Praca zo suborom~Cesta k suboru~Otvorene spolocenstvo~',0);
    if ooo<>0 then
    begin
     inc(ooo,7);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=10) then
   if (button_menu_klik(280,185,470,205,'Cesta k suboru')) then
   begin
    ooo:=button_menu(280,185,470,205,'Cesta k suboru',
    'Nacitavanie~Praca zo suborom~Cesta k suboru~Otvorene spolocenstvo~',0);
    if ooo<>0 then
    begin
     inc(ooo,7);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

   if (oo=11) then
   if (button_menu_klik(280,185,470,205,'Otvorene spolocenstvo')) then
   begin
    ooo:=button_menu(280,185,470,205,'Otvorene spolocenstvo',
    'Nacitavanie~Praca zo suborom~Cesta k suboru~Otvorene spolocenstvo~',0);
    if ooo<>0 then
    begin
     inc(ooo,7);
     zmen(ooo);
     oo:=ooo;
    end;
   end;

  until button_klik(180,350,450,370,'Zatvorit');;

  if aka=4 then dookna(424,0,GetMaxX,GetMaxY);

  zrus;
  z2pamate(150,100);
  ukaz;
 end;

 koniec:=false;
End;


{----------------------------- S U B O R ----------------------------------}

Procedure chyba;
Begin
  dookna(0,0,GetMaxX,GetMaxY);
  dopamate(100,200,400,340);

  zrus;
  button_normal(100,210,400,340,'');
  button_click(100,210,400,230,'Chyba!');
  setcolor(white);
  OutTextXY(155,253,'CHYBA PRACE ZO SUBOROM!');

  button_normal(155,280,355,300,'Pokracovat');

  ukaz;
  repeat
   kym_mys;
  until button_klik(155,280,355,300,'Pokracovat');

  zrus;
  zpamate(100,200);
  ukaz;
End;


{vytvorenie noveho suboru}
Procedure novy_subor;
begin
 {$I-}
  assign(subor,'zivot.dat');
  rewrite(subor,1);
  close(subor);
 {$I+}
 if IOresult<>0 then chyba;
end;


{nahratie mien danej kategorie}
Procedure nahraj_mena(ake:byte);
var  aka   : byte;
     err   : word;
     c     : byte;
begin
{$I-}
 assign(subor,'zivot.dat');
 reset(subor,1);

 for c:=1 to 100 do mena[c]:='';

 c:=1;
 while not eof(subor) do
 begin
  blockread(subor,aka,sizeof(aka),err);
  if err<>0 then
  begin
   if c>100 then
   begin
    seek(subor,filepos(subor)-1);
    break;
   end else
   if (c<100) and (aka=ake) then
      begin
       blockread(subor,mena[c],sizeof(mena[c]));
       inc(c);
       seek(subor,filepos(subor)+sizeof(historia[1]));
      end
   else seek(subor,filepos(subor)+sizeof(historia[1])+sizeof(mena[c]));
  end else
  begin
   seek(subor,filesize(subor));
   break;
  end;
 end;
 close(subor);
{$I+}
if IOresult<>0 then chyba;
end;

Procedure vymaz(ktoru:byte;snazvom:string);
var vel   : integer;
    ktora : byte;
    err   : word;
    nazov : string;

    akk   : byte;
    nazovv: string;
    co    : generacia;


Begin
{$I-}
 assign(subor,'zivot.dat');
 reset(subor,1);

 while (not eof(subor)) do
 begin
  blockread(subor,ktora,sizeof(ktora),err);

  {Ak bolo nieco vycitane}
  if err<>0 then
  begin
   blockread(subor,nazov,sizeof(nazov),err);

   {porovnanie s hladanym}
   if (err<>0) and (ktora=ktoru) and (nazov=snazvom)
   then
   begin
    {vypocitanie o kolko bajtov sa bude subor posuvat}
    vel:=sizeof(nazov)+sizeof(ktora)+sizeof(co);

    seek(subor,filepos(subor)+sizeof(co));

    {posunutie vsetkych od najdeneho}
    while (err<>0) do
    begin
     blockread(subor,ktora,sizeof(ktora),err);
     if err<>0 then
     begin
      blockread(subor,nazov,sizeof(nazov));
      blockread(subor,co,sizeof(co));

      seek(subor,filepos(subor)-(2*vel));

      blockwrite(subor,ktora,sizeof(ktora));
      blockwrite(subor,nazov,sizeof(nazov));
      blockwrite(subor,co,sizeof(co));

      seek(subor,filepos(subor)+vel);
     end else
     begin
      seek(subor,filesize(subor));
      break;
     end;
    end;

    {odstrihnutie konca suboru}
    seek(subor,filesize(subor)-vel);
    truncate(subor);
    break;
   end
   else seek(subor,filepos(subor)+sizeof(co));
  end else
  begin
   seek(subor,filesize(subor));
   break;
  end;
 end;
 close(subor);
{$I+}
if IOresult<>0 then chyba;
End;


Procedure uloz(co: generacia;ktoru:byte;snazvom:string;novy:string);
var vel   : byte;
    ktora : byte;
    err   : word;
    nazov : string;

Begin
{$I-}
 assign(subor,'zivot.dat');
 reset(subor,1);

 while not eof(subor) do
 begin
  blockread(subor,ktora,sizeof(ktora),err);
  if err<>0 then
  begin
   blockread(subor,nazov,sizeof(nazov));

   if (ktora=ktoru) and (nazov=snazvom)
   then
   begin
    seek(subor,filepos(subor)-sizeof(nazov));
    blockwrite(subor,novy,sizeof(novy));
    blockwrite(subor,co,sizeof(co));
    break;
   end
   else seek(subor,filepos(subor)+sizeof(co));
  end else
  begin
   seek(subor,filesize(subor));
   break;
  end;
 end;
 close(subor);
{$I+}
if IOresult<>0 then chyba;
End;


Procedure nahraj(var co: generacia;ktoru:byte;snazvom:string);
var vel   : byte;
    ktora : byte;
    err   : word;
    nazov : string;

Begin
{$I-}
 assign(subor,'zivot.dat');
 reset(subor,1);

 while not eof(subor) do
 begin
  blockread(subor,ktora,sizeof(ktora),err);
  if err<>0 then
  begin
   blockread(subor,nazov,sizeof(nazov));

   if (ktora=ktoru) and (nazov=snazvom)
   then blockread(subor,co,sizeof(co))
   else seek(subor,filepos(subor)+sizeof(co));
  end else
  begin
   seek(subor,filesize(subor));
   break;
  end;
 end;
 close(subor);
{$I+}
if IOresult<>0 then chyba;
End;


Procedure uloz_nove(co: generacia;ako:byte;nazov:string);
Begin
{$I-}
 assign(subor,'zivot.dat');
 reset(subor,1);

 if filesize(subor)>0 then
 begin
  seek(subor,filesize(subor));
 end;

 blockwrite(subor,ako,sizeof(ako));
 blockwrite(subor,nazov,sizeof(nazov));
 blockwrite(subor,co,sizeof(co));

 close(subor);
{$I+}
if IOresult<>0 then chyba;
end;


{------------------------ S I M U L A C I A -------------------------------}

Procedure gulicka(x,y:integer);
Begin
 SetFillStyle(1,6);
 SetColor(14);
 FillEllipse((x*10-10)+26,(y*10-10)+26,3,3);
 SetFillStyle(1,0);
End;

Procedure prazdne(x,y:integer);
Begin
 SetFillStyle(1,0);
 x:=(x*10-10)+23;
 y:=(y*10-10)+23;
 Bar(x,y,x+6,y+6);
End;

Procedure hynie(m,n:byte);
Begin
 prazdne(m,n);
 SetColor(14);
 SetFillStyle(1,6);
 FillEllipse((m*10-10)+26,(n*10-10)+26,2,2);
 SetColor(14);
End;

Procedure rodi(m,n:byte);
Begin
 SetColor(14);
 SetFillStyle(1,14);
 FillEllipse((m*10-10)+26,(n*10-10)+26,3,3);
End;

Procedure popis;
Begin
 SetFillStyle(1,6);
 SetColor(14);
 FillEllipse(70,438,3,3);
 SetFillStyle(1,0);
 Setcolor(white);
 OutTextXY(78,435,'- prezil');

 SetColor(14);
 SetFillStyle(1,14);
 FillEllipse(170,438,3,3);
 Setcolor(white);
 OutTextXY(178,435,'- narodil sa');

 SetColor(14);
 SetFillStyle(1,6);
 FillEllipse(305,438,2,2);
 SetColor(14);
 Setcolor(white);
 OutTextXY(313,435,'- uhynul');
End;

Procedure simulacia(prva:generacia);

  {funkcie na porovnanie generacii}
  Function s_prvou(ktora:byte):Boolean;
  begin
   for i:=1 to 40 do
   for j:=1 to 40 do
   if (historia[ktora][j,i]=prva[j,i]) then s_prvou:=true else
   begin
    s_prvou:=false;
    exit;
    if lave then play:=false;
   end;
  End;

  Function rovna(k,l:byte):boolean;
  Begin
    for i:=1 to 40 do
    for j:=1 to 40 do
    if (historia[k][j,i]=historia[l][j,i]) then rovna:=true else
    begin
     rovna:=false;
     exit;
     if lave then play:=false;
    end;
  End;

  Function posunulo(k,l:byte):boolean;
  Begin
    for i:=1 to 40 do
    for j:=1 to 40 do
    if historia[k][j,i]=historia[l][j-1,i-1] then posunulo:=true else
    begin
     posunulo:=false;
     exit;
     if lave then play:=false;
    end;
  End;

  Function vyhynie(k:byte):boolean;
  Begin
   for i:=1 to 40 do
   for j:=1 to 40 do
   if (historia[k][j,i]=false) then vyhynie:=true else
   begin
    vyhynie:=false;
    exit;
    if lave then play:=false;
   end;
  End;

Begin
 historia[1]:=prva;
 h:=0;
 v:=0;
 koniec:=false;
 uz:=false;
 play:=false;
 raz:=false;

 rychlost:=4;

 popis;

 for i:=1 to 40 do
 for j:=1 to 40 do
 if historia[h+1][j,i]=true then
 begin
  gulicka(j,i);
 end;

 Setcolor(white);

 Settextstyle(0,0,5);
 OutTextXY(495,60,'0.');

 Settextstyle(0,0,1);
 OutTextXY(500,110,'Generacia');
 OutTextXY(470,410,'<Esc> pre koniec');
 Setcolor(7);

 SetFillStyle(1,0);
 Bar(425,140,GetMaxX,360);
 Button_normal(500,260,560,300,'Zastav');
 Button_normal(500,310,560,350,'Hraj');
 Button_normal(475,260,495,350,' <');
 Button_normal(565,260,585,350,' >');

 Setcolor(15);
 OutTextXY(440,180,'Ulozenie do suboru:');
 OutTextXY(440,235,'Ovladanie simulacie:');


 rych:=' 8x';
 Button_menu_normal(450,150,610,170,'Rychlost:  '+rych);

 Button_menu_normal(450,200,610,220,'Ulozit');

 button_normal(450,425,620,445,'Zrusit');
 ukaz;

repeat
if play or raz then
 begin
  inc(h);
  inc(v);
  Setcolor(white);
  Settextstyle(0,0,5);
  SetFillStyle(9,8);

  str(v,s);
  bar(460,55,GetMaxX,100);
  if v>=1000 then
  OutTextXY(455,60,s+'.')
  else
  if v>=100 then
   OutTextXY(470,60,s+'.')
  else
  if v>=10 then
   OutTextXY(480,60,s+'.')
  else
   OutTextXY(495,60,s+'.');

  Settextstyle(0,0,1);
  Setcolor(7);

  {podanie cache pamati pre pripad prezerania spat}
  if h=10 then
  begin
   for i:=2 to 10 do historia[i-1]:=historia[i];
   h:=9;
  end else historia[h+1]:=historia[h];

  for i:=1 to 40 do
  for j:=1 to 40 do
  if historia[h+1][j,i]=true then
  begin
   gulicka(j,i);
   if lave then play:=false;
  end;

  ret_delay(RYCHLOSTI[rychlost]);

  if keypressed then if readkey=chr(27) then exit;

  for y:=1 to 40 do
  for x:=1 to 40 do
  begin
   susedov:=0;
   if lave then play:=false;

   if historia[h][x-1,y-1] then inc(susedov);
   if historia[h][x-1,y]   then inc(susedov);
   if historia[h][x-1,y+1] then inc(susedov);

   if historia[h][x,y+1]   then inc(susedov);
   if historia[h][x,y-1]   then inc(susedov);

   if historia[h][x+1,y-1] then inc(susedov);
   if historia[h][x+1,y]   then inc(susedov);
   if historia[h][x+1,y+1] then inc(susedov);

   if historia[h+1][x,y] and (susedov>=4) then
   begin
    historia[h+1][x,y]:=false;
    hynie(x,y);
   end;
   if historia[h+1][x,y] and (susedov<=1) then
   begin
    historia[h+1][x,y]:=false;
    hynie(x,y);
   end;
   if (not historia[h+1][x,y]) and (susedov=3) then
   begin
    historia[h+1][x,y]:=true;
    rodi(x,y);
   end;
  end;

  {dvojnasobne cakanie aby bolo vidno ktore uhynu}
  if raz then ret_delay(RYCHLOSTI[rychlost]*2) else ret_delay(RYCHLOSTI[rychlost]*2);

  {zmazanie uhynutych}
  xo:=0;
  for i:=1 to 40 do
  for j:=1 to 40 do
  if (historia[h][j,i]=true) and (historia[h+1][j,i]=false) then
  begin
   prazdne(j,i);
   if lave then play:=false;
  end;

  {delay aby ked simulacia nezrychlovala ked bude menej hynut}
  if rychlost<>6 then ret_delay(1000);
  {Ak maximalna rychlost tak bez delay}

 {porovnavanie}
 if uz=false then
 begin
  If vyhynie(h+1) then
   begin
    SetFillStyle(1,6);
    Bar(0,460,GetMaxX,GetMaxY);
    SetFillStyle(1,0);
    Bar(25,425,415,450);

    koniec:=true;
    str(v,s);
    OutTextXY(10,465,'Vo '+s+'. generacii spolocenstvo vyhynulo');
    Setcolor(white);
    Settextstyle(0,0,2);
    OutTextXY(50,430,'Spolocenstvo vyhynulo');
    Settextstyle(0,0,1);
    uz:=true;
   end
  else

  if rovna(h,h+1) then
   Begin
    SetFillStyle(1,6);
    Bar(0,460,GetMaxX,GetMaxY);
    SetFillStyle(1,0);
    Bar(25,425,415,450);

    koniec:=true;
    str(v,s);
    OutTextXY(10,465,'V '+s+'. generacii sa spolocenstvo stalo staticke!');
    Setcolor(white);
    Settextstyle(0,0,2);
    OutTextXY(50,430,'Staticke spolocenstvo');
    Settextstyle(0,0,1);
    uz:=true;
   End
  else

  if s_prvou(h+1) then
   begin
    SetFillStyle(1,6);
    Bar(0,460,GetMaxX,GetMaxY);
    SetFillStyle(1,0);
    Bar(25,425,415,450);

    str(v,s);
    OutTextXY(10,465,'V '+s+'. generacii sa spolocenstvo dostalo na uroven prvej generacie a opakuje sa!');
    Setcolor(white);
    Settextstyle(0,0,2);
    OutTextXY(50,430,'Cyklicke spolocenstvo');
    Settextstyle(0,0,1);
    uz:=true;
   end else

  If rovna(h+1,h-1) then
   Begin
    SetFillStyle(1,6);
    Bar(0,460,GetMaxX,GetMaxY);
    SetFillStyle(1,0);
    Bar(25,425,415,450);

    str(v,s);
    OutTextXY(10,465,'Spolocenstvo sa zacalo cyklit od '+s+'. generacie!');
    Setcolor(white);
    Settextstyle(0,0,2);
    OutTextXY(50,430,'Cyklicke spolocenstvo');
    Settextstyle(0,0,1);
    uz:=true;
   End
  else

  for xx:=h downto 1 do
  begin
   if posunulo(h+1,xx) then
   begin
    SetFillStyle(1,6);
    Bar(0,460,GetMaxX,GetMaxY);
    SetFillStyle(1,0);
    Bar(25,425,415,450);

    str(v,s);
    OutTextXY(10,465,'Od '+s+'. generacie sa spolocenstvo posuva pravo dole!');
    Setcolor(white);
    Settextstyle(0,0,2);
    OutTextXY(50,430,'Klzajuce spolocenstvo');
    Settextstyle(0,0,1);
    uz:=true;
   end
  end;
 end;

 {znulovanie ak bolo dane iba o jednu generaciu}
 if raz then
 begin
  play:=false;
  raz:=false;
 end;

end
else
 repeat
  _pomoc(4);

  if keypressed then if readkey=chr(27) then exit;

  if button_menu_klik(450,150,610,170,'Rychlost:  '+rych) then
  begin
   button_menu_click(546,150,610,170,rych+' ');
   rychlost:=button_menu(546,150,610,170,rych+' ','1x~2x~4x~8x~16x~Max~',0);

   case rychlost of
   1:rych:=' 1x';
   2:rych:=' 2x';
   3:rych:=' 4x';
   4:rych:=' 8x';
   5:rych:='16x';
   6:rych:='Max';
   end;

   Button_menu_normal(450,150,610,170,'Rychlost:  '+rych);
   koniec:=false;
  end;

  if button_klik(500,260,560,300,'Zastav') then
  begin
   play:=false;
   raz:=false;
  end else

  if button_klik(500,310,560,350,'Hraj') then
  begin
   play:=true;
   raz:=false;
  end else

  if button_klik(475,260,495,350,' <') and (h>=1) then
  begin
   dec(h);
   dec(v);

   Setcolor(7);
   SetFillStyle(1,0);
   for i:=1 to 40 do
   for j:=1 to 40 do
   if historia[h+1][j,i]=true then gulicka(j,i)
                              else prazdne(j,i);

   Setcolor(white);
   Settextstyle(0,0,5);
   SetFillStyle(9,8);

   if v>=100 then
   begin
    str(v,s);
    bar(460,55,GetMaxX,100);
    OutTextXY(470,60,s+'.');
    Settextstyle(0,0,1);
    Setcolor(7);
   end else
   if v>=10 then
   begin
    str(v,s);
    bar(460,55,GetMaxX,100);
    OutTextXY(480,60,s+'.');
    Settextstyle(0,0,1);
    Setcolor(7);
   end else
   begin
    str(v,s);
    bar(460,55,GetMaxX,100);
    OutTextXY(495,60,s+'.');
    Settextstyle(0,0,1);
    Setcolor(7);
   end;

   play:=false;
  end else

  if button_klik(565,260,585,350,' >') then
  begin
   raz:=true;
  end else

  if button_menu_klik(450,200,610,220,'Ulozit') then
  begin
   nb:=0;
   mb:=button_menu(450,200,610,220,'Ulozit','Ako cyklicke~Ako staticke~Ako ine~',0);
   case mb of
    1:
    begin
     nahraj_mena(1);
     button_menu_click(450,200,610,220,'Ako cyklicke:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>'' then ret:=ret+mena[xx]+'~'
                     else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako cyklicke:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako cyklicke:',ret,0);
    end;
    2:
    begin
     nahraj_mena(2);
     button_menu_click(450,200,610,220,'Ako staticke:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>'' then ret:=ret+mena[xx]+'~'
                     else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako staticke:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako staticke:',ret,0);
    end;
    3:
    begin
     nahraj_mena(3);
     button_menu_click(450,200,610,220,'Ako ine:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>''      then ret:=ret+mena[xx]+'~'
                          else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako ine:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako ine:',ret,0);
    end;
   end;

   if (nb<>0) and (mb<>0) then
   begin
    nahraj_mena(mb);
    if mena[nb]='' then
    begin
     dopamate(450,220,610,340);

     zrus;
     button_normal(450,220,610,340,'');
     button_click(450,230,610,250,'Vytvorit?');
     OutTextXY(455,260,'Zadajte meno pre');
     OutTextXY(455,270,'novu generaciu:');
     button_hover(460,292,600,315,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(460,325,'<Esc> pre zrusenie');
     ret:=VlozText(460,300);

     if ret<>'' then
     uloz_nove(historia[h+1],mb,ret);
     ukaz;

     zpamate(450,220);
    end else
    if mena[nb]<>'' then
    begin
     dopamate(450,220,610,340);

     zrus;
     button_normal(450,220,610,340,'');
     button_click(450,230,610,250,'Prepisat?');
     setcolor(white);
     OutTextXY(460,260,mena[nb]);
     setcolor(7);
     OutTextXY(455,273,'nove meno:');
     button_hover(460,292,600,315,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(460,325,'<Esc> pre zrusenie');
     ret:=VlozText(460,300);

     if ret<>'' then
     uloz(historia[h+1],mb,mena[nb],ret);
     ukaz;

     zpamate(450,220);
    end;
   end;

   button_menu_normal(450,200,610,220,'Ulozit');
   koniec:=false;
  end else


  if button_klik(450,425,620,445,'Zrusit') then
  begin
   koniec:=true;
  end;

 until (play) or (raz) or (koniec);

 if (koniec) then
 begin
  koniec:=false;
  zrus;

  SetFillStyle(1,0);
  Bar(425,150,GetMaxX,360);

  SetFillStyle(9,8);
  Bar(428,360,GetMaxX,400);

  Setcolor(15);
  OutTextXY(440,180,'Ulozenie do suboru');
  ukaz;

  Button_menu_normal(450,200,610,220,'Ulozit povodnu');
  Button_normal(450,400,620,420,'Znovu');
  button_normal(450,425,620,445,'Koniec');

  repeat
   kym_mys;

  if button_menu_klik(450,200,610,220,'Ulozit povodnu') then
  begin
   nb:=0;
   mb:=button_menu(450,200,610,220,'Ulozit povodnu','Ako cyklicke~Ako staticke~Ako ine~',0);
   case mb of
    1:
    begin
     nahraj_mena(1);
     button_menu_click(450,200,610,220,'Ako cyklicke:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>'' then ret:=ret+mena[xx]+'~'
                     else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako cyklicke:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako cyklicke:',ret,0);
    end;
    2:
    begin
     nahraj_mena(2);
     button_menu_click(450,200,610,220,'Ako staticke:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>'' then ret:=ret+mena[xx]+'~'
                     else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako staticke:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako staticke:',ret,0);
    end;
    3:
    begin
     nahraj_mena(3);
     button_menu_click(450,200,610,220,'Ako ine:');
     ret:='';
     for xx:=1 to 100 do
     if mena[xx]<>''      then ret:=ret+mena[xx]+'~'
                          else break;

     ret:=ret+'VYTVORIT~';

     Setcolor(7);
     if xx>4 then nb:=button_menu(450,200,610,220,'Ako ine:',ret,4)
             else nb:=button_menu(450,200,610,220,'Ako ine:',ret,0);
    end;
   end;

   if (nb<>0) and (mb<>0) then
   begin
    nahraj_mena(mb);
    if mena[nb]='' then
    begin
     dopamate(450,220,610,340);

     zrus;
     button_normal(450,220,610,340,'');
     button_click(450,230,610,250,'Vytvorit?');
     OutTextXY(455,260,'Zadajte meno pre');
     OutTextXY(455,270,'novu generaciu:');
     button_hover(460,292,600,315,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(460,325,'<Esc> pre zrusenie');
     ret:=VlozText(460,300);

     if ret<>'' then
     uloz_nove(prva,mb,ret);
     ukaz;

     zpamate(450,220);
    end else
    if mena[nb]<>'' then
    begin
     dopamate(450,220,610,340);

     zrus;
     button_normal(450,220,610,340,'');
     button_click(450,230,610,250,'Prepisat?');
     setcolor(white);
     OutTextXY(460,260,mena[nb]);
     setcolor(7);
     OutTextXY(455,273,'nove meno:');
     button_hover(460,292,600,315,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(460,325,'<Esc> pre zrusenie');
     ret:=VlozText(460,300);

     if ret<>'' then
     uloz(prva,mb,mena[nb],ret);
     ukaz;

     zpamate(450,220);
    end;
   end;

   button_menu_normal(450,200,610,220,'Ulozit povodnu');
   koniec:=false;
  end else

   if button_klik(450,425,620,445,'Koniec') then
   begin
    koniec:=true;
   end else

   if button_klik(450,400,620,420,'Znovu') then
   begin

    button_normal(450,425,620,445,'Zrusit');
    Button_normal(500,260,560,300,'Zastav');
    Button_normal(500,310,560,350,'Hraj');
    Button_normal(475,260,495,350,' <');
    Button_normal(565,260,585,350,' >');
    button_normal(450,200,610,220,'Ulozit');

    for xx:=1 to 10 do
    for i:=0 to 41 do
    for j:=0 to 41 do historia[xx][j,i]:=false;

    for i:=1 to 40 do
    for j:=1 to 40 do
    prazdne(j,i);



    h:=0;
    v:=0;
    historia[1]:=prva;

    uz:=false;
    raz:=true;
   end;

  until (koniec) or (raz);
 end;
until koniec;
End;


{---------------- V Y T V O R E N I E   E D I T O V A N I E  --------------}

Function edituj(var co:generacia):boolean;
begin
  pozadie;
  mriezka;

  Setcolor(black);
  Setlinestyle(0,0,3);
  line(530,17,530,400);
  line(425,100,GetMaxX,100);
  line(425,200,GetMaxX,200);
  line(425,300,GetMaxX,300);
  line(425,399,GetMaxX,399);
  Setcolor(7);
  Setlinestyle(0,0,0);

  koniec:=false;

  SetFillStyle(1,0);
  Bar(425,400,GetMaxX,453);

  button_normal(450,400,620,420,'Simulacia');
  button_normal(450,425,620,445,'Zrusit');

  button_normal(30,428,200,448,'Generuj spolocentvo');
  button_normal(216,428,316,448,'Pregeneruj');
  button_normal(332,428,415,448,'Zmazat');


  Setcolor(14);
  SetFillStyle(1,6);
  {1,1}
  for i:=1 to 10 do
  for j:=1 to 10 do
  if CYKLICKA2[j,i] then FillEllipse((i*10-10)+432,(j*10-10)+15,3,3);

  {2,1}
  for i:=1 to 2 do
  for j:=1 to 2 do
  if STABILNA[j,i] then FillEllipse((i*10-10)+575,(j*10-10)+50,4,4);

  {1,2}
  for i:=1 to 5 do
  for j:=1 to 5 do
  if VYHYNIE1[j,i] then FillEllipse((i*10-10)+455,(j*10-10)+130,4,4);

  {2,2}
  for i:=1 to 5 do
  for j:=1 to 5 do
  if VYHYNIE2[j,i] then FillEllipse((i*10-10)+565,(j*10-10)+130,4,4);

  {1,3}
  for i:=1 to 3 do
  for j:=1 to 3 do
  if CYKLICKA1[j,i] then FillEllipse((i*10-10)+465,(j*10-10)+240,4,4);

  {2,3}
  for i:=1 to 3 do
  for j:=1 to 3 do
  if POSUVAJUCA1[j,i] then FillEllipse((i*10-10)+570,(j*10-10)+240,4,4);

  randomize;
  for i:=1 to 8 do
  for j:=1 to 8 do
  begin
   if random(100)>=85 then RANDOM1[j,i]:=true else RANDOM1[j,i]:=false;
   if random(100)>=85 then RANDOM2[j,i]:=true else RANDOM2[j,i]:=false;
  end;

  {1,4}
  {2,4}
  SetFillStyle(9,8);
  Bar(432,304,522,394);
  Bar(542,304,GetMaxX,394);

  SetFillStyle(1,6);
  for i:=1 to 8 do
  for j:=1 to 8 do
  begin
   if RANDOM1[j,i] then FillEllipse((i*10-10)+442,(j*10-10)+314,4,4);
   if RANDOM2[j,i] then FillEllipse((i*10-10)+552,(j*10-10)+314,4,4);
  end;

  SetColor(14);

  SetFillStyle(1,0);
  for i:=1 to 40 do
  for j:=1 to 40 do
  if co[j,i] then gulicka(j,i) else prazdne(j,i);

  ukaz;
  repeat
    kym_mys;

    _pomoc(3);

    x:=0;
    y:=0;

    if (_x>=430) and (_x<=530) then x:=1 else if (_x>530) then x:=2;
    if (_y>=17)  and (_y<=100) then y:=1 else
    if (_y>100)  and (_y<=200) then y:=2 else
    if (_y>200)  and (_y<=300) then y:=3 else
    if (_y>300)  and (_y<=400) then y:=4;

    if (lave) and (x<>0) and (y<>0) then
    begin
      zrus;
      while lave do
      begin
       xx:=((_x-10) div 10);
       yy:=((_y-10) div 10);
       if xx=0 then inc(xx);
       if yy=0 then inc(yy);

       if (x=1) and (y=1) then
       begin
        for i:=4 to 10 do
        for j:=1 to 10 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and CYKLICKA2[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=2) and (y=1) then
       begin
        for i:=1 to 2 do
        for j:=1 to 2 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and STABILNA[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=1) and (y=2) then
       begin
        for i:=1 to 5 do
        for j:=1 to 5 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and VYHYNIE1[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=2) and (y=2) then
       begin
        for i:=1 to 5 do
        for j:=1 to 5 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and VYHYNIE2[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=1) and (y=3) then
       begin
        for i:=1 to 3 do
        for j:=1 to 3 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and CYKLICKA1[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=2) and (y=3) then
       begin
        for i:=1 to 3 do
        for j:=1 to 3 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and POSUVAJUCA1[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=1) and (y=4) then
       begin
        for i:=1 to 8 do
        for j:=1 to 8 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and RANDOM1[i,j]
         then rodi(xx+j,yy+i);
       end else

       if (x=2) and (y=4) then
       begin
        for i:=1 to 8 do
        for j:=1 to 8 do
         if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and RANDOM2[i,j]
         then rodi(xx+j,yy+i);
       end;

       repeat
        xo:=((_x-10) div 10);
        yo:=((_y-10) div 10);
        if xo=0 then inc(xo);
        if yo=0 then inc(yo);
       until (xo<>xx) or (yo<>yy) or not(lave);


       SetFillStyle(1,0);
       for i:=1 to 40 do
       for j:=1 to 40 do
       begin
        if co[j,i] then gulicka(j,i) else prazdne(j,i);
       end;
      end;

      xo:=xx;
      yo:=yy;

      if (x=1) and (y=1) then
       for i:=3 to 10 do
       for j:=1 to 10 do
       if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and CYKLICKA2[i,j]
        then
        begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

      if (x=2) and (y=1) then
       for i:=1 to 2 do
       for j:=1 to 2 do
       if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and STABILNA[i,j]
        then
        begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

      if (x=1) and (y=2) then
       for i:=1 to 5 do
       for j:=1 to 5 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and VYHYNIE1[i,j]
        then
        begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

      if (x=2) and (y=2) then
       for i:=1 to 5 do
       for j:=1 to 5 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and VYHYNIE2[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

       if (x=2) and (y=2) then
       for i:=1 to 5 do
       for j:=1 to 5 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and VYHYNIE2[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

       if (x=1) and (y=3) then
       for i:=1 to 3 do
       for j:=1 to 3 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and CYKLICKA1[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

       if (x=2) and (y=3) then
       for i:=1 to 3 do
       for j:=1 to 3 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and POSUVAJUCA1[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

       if (x=1) and (y=4) then
       for i:=1 to 8 do
       for j:=1 to 8 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and RANDOM1[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

       if (x=2) and (y=4) then
       for i:=1 to 8 do
       for j:=1 to 8 do
        if (xx+j<=40) and (xx+j>=1) and (yy+i>=1) and (yy+i<=40) and RANDOM2[i,j]
        then begin
         gulicka(xx+j,yy+i);
         co[xx+j,yy+i]:=true;
        end;

      x:=0;
      y:=0;
      ukaz;
    end else

    if lave then
     while lave do
     begin
      xx:=((_x-10) div 10);
      yy:=((_y-10) div 10);
      if xx=0 then inc(xx);
      if yy=0 then inc(yy);

      if co[xx,yy]=false then
      begin
        if (xx<=40) and (xx>=1) and (yy>=1) and (yy<=40) then
        begin
         zrus;
         rodi(xx,yy);
         ukaz;
          xo:=_x;
          yo:=_y;
          repeat
           x:=((_x-10) div 10);
           y:=((_y-10) div 10);
           if x=0 then inc(x);
           if y=0 then inc(y);
          until (x<>xx) or (y<>yy) or not(lave);
         zrus;
         gulicka(xx,yy);
         ukaz;
         co[xx,yy]:=true;
        end
      end
                         else
      if (xx<=40) and (xx>=1) and (yy>=1) and (yy<=40) then
      begin
       zrus;
       hynie(xx,yy);
       ukaz;
        xo:=_x;
        yo:=_y;
        repeat
         x:=((_x-10) div 10);
         y:=((_y-10) div 10);
         if x=0 then inc(x);
         if y=0 then inc(y);
        until (x<>xx) or (y<>yy) or not(lave);
       zrus;
       prazdne(xx,yy);
       ukaz;
       co[xx,yy]:=false;
      end;
     end;

    if button_klik(450,400,620,420,'Simulacia') then
    begin
     edituj:=true;
     exit;
    end else

    if button_klik(450,425,620,445,'Zrusit') then
    begin
     edituj:=false;
     exit;
    end else

    if button_klik(30,428,200,448,'Generuj spolocentvo') then
    begin
     dopamate(150,200,400,340);

     zrus;
     button_normal(150,210,400,340,'');
     button_click(150,210,400,230,'Generovat?');
     setcolor(7);
     OutTextXY(155,253,'Zadajte kolko sa ma narodit:');
     button_hover(200,272,340,295,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(200,325,'<Esc> pre zrusenie');

     setcolor(white);
     OutTextXY(200,305,'<1..1000>');

     ret:=VlozText(205,280);


     if ret<>'' then
     begin
      val(ret,h,v);

      if (v<>0) or (h<1) or (h>1000) then
      while (v<>0) or ((h<1) or (h>1000)) do
      begin

       zrus;
       button_normal(150,210,400,340,'');
       button_click(150,210,400,230,'Generovat?');
       setcolor(white);
       OutTextXY(200,305,'<1..1000>');

       setcolor(white);
       if v<>0 then
       OutTextXY(155,253,'Zadajte prosim cislo!')
       else
       if ((h<1) or (h>1000)) then
       OutTextXY(155,253,'Prosim z intervalu <1..1000> !');

       button_hover(200,272,340,295,'');
       setcolor(white);
       setfillstyle(0,0);

       ret:=VlozText(205,280);
       ukaz;

       val(ret,h,v);
      end;

      zpamate(150,200);
      ukaz;


      for i:=0 to 41 do
      for j:=0 to 41 do
      co[j,i]:=false;


      randomize;

      for h:=h downto 1 do
      begin
       i:=0;
       j:=0;
       while (i=0) do i:=random(41);
       while (j=0) do j:=random(41);

       if co[j,i] then
       while co[j,i] do
       begin
        i:=0;
        j:=0;
        while (i=0) do i:=random(41);
        while (j=0) do j:=random(41);
       end;

       co[j,i]:=true;
      end;

      SetFillStyle(1,0);
      zrus;
      for i:=1 to 40 do
      for j:=1 to 40 do
      if co[j,i] then gulicka(j,i)
                 else prazdne(j,i);
      ukaz;
     end else
     begin
      zpamate(150,200);
      ukaz;
     end;
    end else

    if button_klik(216,428,316,448,'Pregeneruj') then
    begin
     randomize;
     for i:=1 to 8 do
     for j:=1 to 8 do
     begin
      if random(100)>=85 then RANDOM1[j,i]:=true else RANDOM1[j,i]:=false;
      if random(100)>=85 then RANDOM2[j,i]:=true else RANDOM2[j,i]:=false;
     end;

     SetFillStyle(9,8);
     Bar(432,304,522,394);
     Bar(542,304,GetMaxX,394);

     SetFillStyle(1,6);
     SetColor(14);
     for i:=1 to 8 do
     for j:=1 to 8 do
     begin
      if RANDOM1[j,i] then FillEllipse((i*10-10)+442,(j*10-10)+314,4,4);
      if RANDOM2[j,i] then FillEllipse((i*10-10)+552,(j*10-10)+314,4,4);
     end;
    end else

    if button_klik(332,428,415,448,'Zmazat') then
    begin
     for i:=1 to 40 do
     for j:=1 to 40 do
     begin
      co[j,i]:=false;
      prazdne(j,i);
     end;
    end;
  until koniec;
end;


{-------------------------- Z O   S U B O R U -----------------------------}

Function nacitaj(var gen:generacia):Boolean;

         Procedure nastav(ao:byte);
         Begin
          zrus;
          SetFillStyle(9,8);
          Bar(425,16,GetMaxX,453);
          SetFillStyle(1,0);
          Bar(425,100,GetMaxX,360);

          button_normal(440,110,620,230,'');
          case ao of
          0:button_click(440,110,620,150,'zivot.dat sa nenaslo!');
          1:button_click(440,110,620,150,'Cesta k zivot.dat');
          end;

          GetDir(h,ret);

          ret:=ret+'\';

          if length(ret)>=16 then ret:='...'+copy(ret,length(ret)-15,16);

          Textcolor(white);
          OutTextXY(445,160,'Aktualna cesta:');
          button_hover(445,180,600,200,ret);
          OutTextXY(445,210,'Napr. D:\Pascal   ...');

          button_normal(440,260,620,280,'Vytvorit');
          button_normal(440,290,620,310,'Zmenit cestu');
          button_normal(440,320,620,340,'Zrusit');

          koniec:=false;
          ukaz;
          repeat
           kym_mys;

           _pomoc(10);

           if button_klik(440,260,620,280,'Vytvorit') then
           begin
            novy_subor;
            koniec:=true;
           end else
           if button_klik(440,320,620,340,'Zrusit') then koniec:=true else
           if button_klik(440,290,620,310,'Zmenit cestu') then
           begin
            repeat
             button_hover(445,180,600,200,'');
             setcolor(white);
             setfillstyle(0,0);
             ret:=Vloztext(450,187);

             {$I-}
             chdir(ret);
             {$I+}
            until IOresult=0;

            {$I-}
            assign(subor,'zivot.dat');
            reset(subor);
            close(subor);
            {$I+}

            if IOresult=0 then koniec:=true;
           end;
          until koniec;

          zrus;
          SetFillStyle(9,8);
          bar(425,100,GetMaxX,360);
          ukaz;

          {$I-}
          assign(subor,'zivot.dat');
          reset(subor);
          close(subor);
          {$I+}
         End;

         Procedure pozadie;
         Begin
          zrus;
          SetFillStyle(1,0);
          Bar(425,400,GetMaxX,453);
          Bar(425,240,GetMaxX,453);
          Bar(425,16,GetMaxX,100);

          button_hover(440,30,GetMaxX-20,90,'');
          ukaz;

          GetDir(h,ret);
          if length(ret)>3 then ret:=ret+'\';

          if length(ret)>=8 then ret:='...'+copy(ret,length(ret)-7,8);

          button_click(440,30,GetMaxX-20,45,ret+'zivot.dat');

          {$I-}
          assign(subor,'zivot.dat');
          reset(subor);
          long:=Filesize(subor);
          close(subor);
          {$I+}

          str(long,ret);
          button_hover(440,45,620,90,ret+' B');
          OutTextXY(445,50,'Velkost suboru:');

          button_normal(440,75,620,90,'Nastavit cestu');
          button_normal(445,345,620,365,'Novy subor');
          button_normal(445,375,620,395,'Editovat');
          button_normal(445,400,620,420,'Simulacia');
          button_normal(445,425,620,445,'Zrusit');
          button_menu_normal(450,120,610,140,'Nacitat cyklicke');
          button_menu_normal(450,160,610,180,'Nacitat staticke');
          button_menu_normal(450,200,610,220,'Nacitat ine');
         End;

Begin
 nacitaj:=false;
 if lave then while lave do begin end;

 {$I-}
 assign(subor,'zivot.dat');
 reset(subor);
 close(subor);
 {$I+}

{Ak sa po skuske otvorenia zivot.dat nenaslo otvor menu s nastavenim cesty}
if (IOresult<>0) then nastav(0);

{Ak sa naslo alebo ak bola nastavena spravna cesta v procedure nastav}
if IOresult=0 then
begin
 pozadie;

 koniec:=false;
 play:=false;
 nb:=0;
 mb:=0;
 kb:=0;

 repeat
   kym_mys;
   _pomoc(8);

   if button_klik(440,75,620,90,'Nastavit cestu') then
   begin
    nastav(1);
    pozadie;

    {Ak uz bola nejaka generacia otvorena prekresli menu}
    if play then
    begin
     button_normal(445,260,620,335,'');
     button_click(445,260,620,280,mena[nb]);
     button_normal(465,285,600,305,'Premenovat');
     button_normal(465,310,600,330,'Vymazat');
    end;

    koniec:=false;
   end else

   if button_menu_klik(450,120,610,140,'Nacitat cyklicke') then
    begin
     ret:='';
     nahraj_mena(1);
     for xx:=1 to 100 do if mena[xx]<>'' then ret:=ret+mena[xx]+'~';
     if ret<>'' then
     begin
      nb:=button_menu(450,120,610,140,'Nacitat cyklicke',ret,5);
      if mena[nb]<>'' then
      begin
       nahraj_mena(1);
       nahraj(gen,1,mena[nb]);

       mb:=1;
       kb:=nb;
      end;
    end;
    koniec:=false;
   end else

   if button_menu_klik(450,160,610,180,'Nacitat staticke') then
   begin
    ret:='';
    nahraj_mena(2);
    for xx:=1 to 100 do if mena[xx]<>'' then ret:=ret+mena[xx]+'~';
    if ret<>'' then
    begin
     nb:=button_menu(450,160,610,180,'Nacitat staticke',ret,5);
     nahraj_mena(2);
     if mena[nb]<>'' then
     begin
      nahraj_mena(2);
      nahraj(gen,2,mena[nb]);

      mb:=2;
      kb:=nb;
     end;
    end;
    koniec:=false;
   end else

   if button_menu_klik(450,200,610,220,'Nacitat ine') then
   begin
    ret:='';
    nahraj_mena(3);
    for xx:=1 to 100 do if mena[xx]<>'' then ret:=ret+mena[xx]+'~';
    if ret<>'' then
    begin
     nb:=button_menu(450,200,610,220,'Nacitat ine',ret,5);
     nahraj_mena(3);
     if mena[nb]<>'' then
     begin
      nahraj_mena(3);
      nahraj(gen,3,mena[nb]);

      mb:=3;
      kb:=nb;
     end;
    end;
    koniec:=false;
   end;

   if kb>0 then
   begin
    zrus;
    button_normal(445,260,620,335,'');
    button_click(445,260,620,280,mena[nb]);
    button_normal(465,285,600,305,'Premenovat');
    button_normal(465,310,600,330,'Vymazat');

    for i:=1 to 40 do
    for j:=1 to 40 do
    if gen[j,i] then gulicka(j,i) else prazdne(j,i);

    ukaz;

    kb:=0;
    koniec:=false;
    play:=true;
   end;


  {Ak uz je nejaka generacia otvorena vypis menu}
  if play then
  begin
   if button_klik(465,285,600,305,'Premenovat') then
   begin
     nahraj_mena(mb);
     dopamate(450,220,610,340);

     zrus;
     button_normal(450,230,610,340,'');
     button_click(450,230,610,250,'Premenovat?');
     setcolor(white);
     OutTextXY(460,260,mena[nb]);
     setcolor(7);
     OutTextXY(455,273,'nove meno:');
     button_hover(460,292,600,315,'');
     setcolor(white);
     setfillstyle(0,0);

     OutTextXY(460,325,'<Esc> pre zrusenie');
     ret:=VlozText(460,300);

     if ret<>'' then
     begin
      uloz(gen,mb,mena[nb],ret);
      nahraj_mena(mb);
     end;

     ukaz;
     zpamate(450,220);
     button_click(445,260,620,280,mena[nb]);
   end else

   if button_klik(465,310,600,330,'Vymazat') then
   begin
     k:=button_menu(465,310,600,330,'Vymazat?','Ano~Nie~',0);
     if k=1 then
     begin
      nahraj_mena(mb);
      vymaz(mb,mena[nb]);

      pozadie;

      for i:=1 to 40 do
      for j:=1 to 40 do
      begin
       prazdne(j,i);
       gen[j,i]:=false;
      end;

      ukaz;

      play:=false;
     end;

     if play then button_normal(465,310,600,330,'Vymazat');
     koniec:=false;
   end;
  end;

   if button_klik(445,345,620,365,'Novy subor') then
   begin
    k:=button_menu(445,345,620,365,'Novy subor?','Ano~Nie~',0);
    if k=1 then
    begin
     novy_subor;

     pozadie;

     for i:=0 to 41 do
     for j:=0 to 41 do
     gen[j,i]:=false;

     for i:=1 to 40 do
     for j:=1 to 40 do
     prazdne(j,i);

     ukaz;
     play:=false;
    end;

    button_normal(445,345,620,365,'Novy subor');
    koniec:=false;
   end else

   if button_klik(445,425,620,445,'Zrusit') then
   begin
    koniec:=true;
    nacitaj:=false;
   end else

   if button_klik(445,375,620,395,'Editovat') then
   begin
    zrus;
    if edituj(gen) then nacitaj:=true;
    koniec:=true;
   end else

   if button_klik(445,400,620,420,'Simulacia') then
   begin
    nacitaj:=true;
    koniec:=true;
   end;

 until koniec;
end;
End;


{Vypis informacii o simulacii a o autorovi}
Procedure informacie;
  Procedure prog;
  begin
   zrus;
   SetFillStyle(1,0);
   Bar(100,201,GetMaxX-100,390);
   OutTextXY(111,230,'Program je ukazkou biologickeho deja:');

   OutTextXY(111,250,' Zivota spolocenstva mikroorganizmov v prostredi.');
   OutTextXY(111,270,' -Zivot kazdeho zavisi od jeho susedov (maximalne 8)');
   OutTextXY(111,280,' -Simulacia prebieha v etapach, generacnych obdobiach');

   OutTextXY(111,300,' Preziju len tie, ktore maju 2, alebo 3 susedov.');
   OutTextXY(111,320,' Ak maju 4 a viac susedov hynu nedostatkom potravy');
   OutTextXY(111,330,' tak isto ako ked maju jedneho, alebo ziadneho.');
   OutTextXY(111,350,' Novy organizmus sa moze aj narodit a to prave');
   OutTextXY(111,360,' vtedy ak by potom boli v spolocenstve prave traja.');
   ukaz;
  end;

  Procedure autor;
  Begin
   zrus;
   SetFillStyle(1,0);
   Bar(100,201,GetMaxX-100,390);
   OutTextXY(111,230,'Autor: Michal Cisarik 4.E Gymnazium J.M Hurbana Cadca');
   ukaz;
  End;

Begin
 zrus;
 pozadie;
 hlavicka;
 button_normal(90,170,GetMaxX-90,415,'');
 button_normal(100,180,250,200,'O programe');
 button_normal(250,180,400,200,'O autorovi');
 button_normal(400,180,GetMaxX-100,200,'Zrusit');

 SetFillStyle(1,0);
 Bar(100,201,GetMaxX-100,390);
 ukaz;
 prog;

 repeat
  kym_mys;
  _pomoc(2);
  if button_klik(100,180,250,200,'O programe') then prog else
  if button_klik(250,180,400,200,'O autorovi') then autor;
 until button_klik(400,180,GetMaxX-100,200,'Zrusit');
End;


{Hlavne menu programu}
Procedure Menu;
var vyber:byte;
Begin
 repeat
  button_normal(180,150,450,190,'Nacitanie zo suboru');
  button_normal(180,210,450,250,'Vytvorenie spolocenstva');
  button_normal(180,270,450,310,'Informacie');
  button_normal(180,330,450,370,'Koniec');

  if lave then while lave do begin end;

  vyber:=0;
  repeat
    kym_mys;
    _pomoc(1);
    if button_klik(180,150,450,190,'Nacitanie zo suboru') then vyber:=1 else
    if button_klik(180,210,450,250,'Vytvorenie spolocenstva') then vyber:=2 else
    if button_klik(180,270,450,310,'Informacie') then vyber:=3 else
    if button_klik(180,330,450,370,'Koniec') then exit;
  until (vyber<>0);

  case vyber of
  1:
  begin
   zrus;
   pozadie;
   mriezka;
   ukaz;

   for i:=0 to 41 do
   for j:=0 to 41 do vstup[j,i]:=false;

   if nacitaj(vstup) then
   begin
    zrus;
    pozadie;
    mriezka;
    dookna(424,0,GetMaxX,GetMaxY);
    simulacia(vstup);
    dookna(0,0,GetMaxX,GetMaxY)
   end;
  end;
  2:
  begin
   zrus;
   for i:=0 to 41 do
   for j:=0 to 41 do vstup[j,i]:=false;

   if edituj(vstup) then
   begin
    zrus;
    pozadie;
    mriezka;
    dookna(424,0,GetMaxX,GetMaxY);
    simulacia(vstup);
    dookna(0,0,GetMaxX,GetMaxY)
   end;
  end;
  3:
  begin
   informacie;
  end;
 end;
 vyber:=0;
 zrus;
 pozadie;
 hlavicka;
 ukaz;
until false;
End;


{-------------------- H L A V N Y    P R O G R A M ------------------------}

Begin
  Init;
  pozadie;
  hlavicka;
  ukaz;
  dookna(0,0,GetMaxX,GetMaxY);
  Menu;
  CloseGraph;
End.