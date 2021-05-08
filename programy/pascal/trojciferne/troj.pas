{Antonia Cviklova, 4.F}
{VST:Dane su dlzky stran trojuholnika}
{VYS:Trojuholnik}

PROGRAM TROJUHOLNIK;
USES CRT;
VAR a,b,c:real;

BEGIN
 CLRSCR;
 WRITELN ('                          PROGRAM NA ZISTENIE TROJUHOLNIKA');
 WRITELN ('                          ________________________________');
 WRITELN;
 WRITELN;
 WRITELN;
 WRITE ('Zadaj stranu a: ');
 READ (a);
 WRITE ('Zadaj stranu b: ');
 READ (b);
 WRITE ('Zadaj stranu c: ');
 READ (c);
 CLRSCR;
 WRITELN ('                          PROGRAM NA ZISTENIE TROJUHOLNIKA');
 WRITELN ('                          ________________________________');
 WRITELN;
 WRITELN;
 IF ((a+b)>c) and ((a+c)>b) and ((b+c)>a) THEN
 IF (a=b) and (b=c) THEN
                        BEGIN
                        WRITELN('Trojuholnik s dlzkami stran a= ',a:2:2);
                        WRITELN('                            b= ',b:2:2);
                        WRITELN('                            c= ',c:2:2);
                        WRITE('                            je rovnostranny.');
                        END
 ELSE IF (a*a) + (b*b) = (c*c) THEN
                                    BEGIN
                                    WRITELN('Trojuholnik s dlzkami stran a= ',a:2:2);
                                    WRITELN('                            b= ',b:2:2);
                                    WRITELN('                            c= ',c:2:2);
                                    WRITE('                            je pravouhly.');
                                    END
 ELSE IF (a=b) or (b=c) or (c=a) THEN
                                     BEGIN
                                     WRITELN('Trojuholnik s dlzkami stran a= ',a:2:2);
                                     WRITELN('                            b= ',b:2:2);
                                     WRITELN('                            c= ',c:2:2);
                                     WRITE('                            je rovnoramenny.');
                                     END
                                 ELSE  BEGIN
                                       WRITELN('Trojuholnik s dlzkami stran a= ',a:2:2);
                                       WRITELN('                            b= ',b:2:2);
                                       WRITELN('                            c= ',c:2:2);
                                       WRITE('                            je vseobecny.');
                                       END
                                 ELSE  BEGIN
                                       WRITELN('Trojuholnik s dlzkami stran a= ',a:2:2);
                                       WRITELN('                            b= ',b:2:2);
                                       WRITELN('                            c= ',c:2:2);
                                       WRITE('                            sa neda zostrojit.');
                                        END;
 READLN;
 READLN;
END.
