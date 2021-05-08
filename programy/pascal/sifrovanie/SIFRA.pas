{Martin Gajdos, trieda: 3.E, sk.r. 2015/2016}
{Martin Gajdos, trieda:3.E, sk. r. 2015/2016}
{Program na zasifrovanie daneho textu}
{VST: Dany je lubovolne dlhy text}
{VYS: Zasifrovany dany text}

PROGRAM ZASIFROVANIE;
USES CRT;
VAR i,POM_A,POM_B,POM_E: INTEGER;
    TEXT,POM_D: STRING;
    X,Y: CHAR;

BEGIN
REPEAT

 CLRSCR;
 TEXTCOLOR(GREEN);
 WRITE('            PROGRAM NA ZASIFROVANIE LUBOVOLNEHO TEXTU');
 TEXTCOLOR(CYAN);
 GOTOXY(1,3);
 WRITELN(' TENTO PROGRAM NAM UMOZNUJE ZASIFROVAT TEXT POMOCOU ASCII ');
 WRITELN(' KLUCA: PISMENO X[1]= X+1, X[2]=X+3, X[3]=X+5, X[4]=X+1...');
 WRITELN(' _____________________________________________________________');
 NORMVIDEO;
 GOTOXY(1,8);
 WRITE(' ZADAJ LUBOVOLNE DLHY TEXT: ');
 READ(TEXT);
 CLRSCR;
 TEXTCOLOR(GREEN);
 WRITE('            PROGRAM NA ZASIFROVANIE LUBOVOLNEHO TEXTU');
 TEXTCOLOR(CYAN);
 GOTOXY(1,3);
 WRITELN(' TENTO PROGRAM NAM UMOZNUJE ZASIFROVAT LUBOVOLNY TEXT POMOCOU ');
 WRITELN(' KLUCA: PISMENO X[1]= X+1, X[2]=X+3, X[3]=X+5, X[4]=X+1...');
 WRITELN(' _____________________________________________________________');
 NORMVIDEO;
 GOTOXY(1,8);
 WRITE(' ZASIFROVANY TEXT: ');
 POM_D:=TEXT;
 POM_A:=-1;
 FOR i:= 1 TO LENGTH(TEXT) DO
 BEGIN
 IF (TEXT[i]=CHR(32)) THEN WRITE(' ')
                   ELSE BEGIN
                         POM_A:=POM_A+2;
                         IF POM_A<=5 THEN BEGIN
                                      POM_B:=0;
                                      POM_E:=0;
                                      TEXT[i]:=CHR(ORD(TEXT[i])+POM_A);
                                      POM_B:=ORD(TEXT[i])-90;
                                      POM_E:=ORD(TEXT[i])-122;
                                      IF ORD(TEXT[i])>ORD('Z') THEN
                                      TEXT[i]:=CHR(64+POM_B)
                                                            ELSE
                                      IF ORD(TEXT[i])>ORD('z') THEN
                                      TEXT[i]:=CHR(96+POM_E);
                                      END
                                 ELSE BEGIN
                                      POM_A:=1;
                                      POM_B:=0;
                                      POM_E:=0;
                                      TEXT[i]:=CHR(ORD(TEXT[i])+POM_A);
                                      POM_B:=ORD(TEXT[i])-90;
                                      POM_E:=ORD(TEXT[i])-122;
                                      IF ORD(TEXT[i])>ORD('Z') THEN
                                      TEXT[i]:=CHR(64+POM_B)
                                                            ELSE
                                      IF ORD(TEXT[i])>ORD('z') THEN
                                      TEXT[i]:=CHR(96+POM_E);
                                      END
                        END;
 WRITE(TEXT[i]);
 END;
 GOTOXY(1,10);
 WRITE(' CHCES TVOJ TEXT ODSIFROVAT? AK ANO ZADAJ "A", AK NIE, ZADAJ "N" ');
 X:=READKEY;
 WHILE (X<>'A') AND (X<>'a') AND (X<>'N') AND (X<>'n') DO
  BEGIN
  WRITELN;
  WRITE(' ZADAL SI NESPRAVNY ZNAK, ZADAJ ZNOVA: ');
  X:=READKEY;
  END;
 IF (X='A') OR (X='a') THEN
 BEGIN
 GOTOXY(1,12);
 WRITE(' ODSIFROVANY TEXT: ',POM_D);
 END;
 GOTOXY(1,20);
 WRITE(' CHCETE POKRACOVAT? AK ANO ZADAJTE "A", AK NIE ZADAJTE "N" ');
 Y:=READKEY;
 WHILE (Y<>'A') AND (Y<>'a') AND (Y<>'N') AND (Y<>'n') DO
  BEGIN
  WRITELN;
  WRITE(' ZADAL SI NESPRAVNY ZNAK, ZADAJ ZNOVA: ');
  Y:=READKEY;
  END;
READLN;
UNTIL (Y='N') OR (Y='n');
END.

