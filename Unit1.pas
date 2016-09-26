unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math;

type
  TForm1 = class(TForm)
    d1: TEdit;
    d2: TEdit;
    d3: TEdit;
    d4: TEdit;
    d5: TEdit;
    d6: TEdit;
    d7: TEdit;
    d8: TEdit;
    d9: TEdit;
    d10: TEdit;
    d11: TEdit;
    d12: TEdit;
    d13: TEdit;
    d14: TEdit;
    d15: TEdit;
    d16: TEdit;
    Rozwiazanie: TButton;
    l1: TEdit;
    l2: TEdit;
    m1: TEdit;
    m2: TEdit;
    d17: TEdit;
    d18: TEdit;
    d19: TEdit;
    d20: TEdit;
    d21: TEdit;
    d22: TEdit;
    d23: TEdit;
    d24: TEdit;
    l15: TEdit;
    l25: TEdit;
    m15: TEdit;
    m25: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    l16: TEdit;
    l26: TEdit;
    m16: TEdit;
    m26: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    Label10: TLabel;
    daned: TLabel;
    szukaned: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    l176: TEdit;
    l276: TEdit;
    m176: TEdit;
    m276: TEdit;
    l175: TEdit;
    l275: TEdit;
    m175: TEdit;
    m275: TEdit;
    Label21: TLabel;
    sz: TEdit;
    wynik: TEdit;
    Label22: TLabel;
    szj: TEdit;
    d25: TEdit;
    d26: TEdit;
    d27: TEdit;
    d28: TEdit;
    d29: TEdit;
    d30: TEdit;
    d31: TEdit;
    d32: TEdit;
    Label23: TLabel;
    odp2: TLabel;
    Button1: TButton;
    procedure RozwiazanieClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Const

k = 13 ;      { liczba zmiennych w wzorach }

c = 1200 ;       { liczba wzorów }

da = 37 ;    { liczba danych ze stalymi }

da1 = 32 ;   { liczba danych }

Type

jednostki = ARRAY[1..1500] of string ;

tablica = ARRAY[ 1..7 , 1..k , 1..c ]  of string ; {wlasnosc,element wzoru,numer wzoru}

dane = ARRAY[ 1..da ]  of string ;

danel = ARRAY[ 1..da ]  of Real ;

numery = ARRAY[ 1..c ]  of Integer ;

wyr_dane = ARRAY[ 1..2 , 1..2000 ] of string ;

wyr_szukane = ARRAY[ 1..100 ] of string ;

var

szukane : string ;

aa : 0..1 ;

uzywane : ShortInt ;   {liczba wpisanych wzorów}


Procedure zamiana1( n , m : integer ; var P : tablica ) ;
begin
    if (P[1,m,n]=szukane) and (aa=0) then
         begin
         P[ 3 , m , n ] := 'licznik' ;
         aa := 1 ;
         end
    else
    begin
               if P[3,m,n]='mianownik' then
                     P[3,m,n]:='licznik'
                     else P[3,m,n]:='mianownik';
    end;
end;


Procedure zamiana( var t : integer ; n , m : integer ; var P : tablica ) ;

begin
    if (P[1,m,n]=szukane) and (aa=0) then
    begin
    aa:=1;
    if P[2,m,n]='prawa' then
         begin
               P[2,m,n] := 'lewa' ;
               if P[3,m,n]='mianownik' then
                     P[3,m,n] := 'licznik'
               else
                          begin
                          P[3,m,n] := 'mianownik' ;
                          t := 1 ;
                          end;
         end
         else
         begin
               if P[3,m,n]='mianownik' then
                     t := 1 ;
         end;
    end
    else
    begin
    if P[2,m,n]='lewa' then
             begin
                 P[2,m,n]:='prawa';
                 if P[3,m,n]='mianownik' then
                      P[3,m,n] := 'licznik'
                 else P[3,m,n] := 'mianownik' ;
             end;
    end;
end;

Procedure przeksztalcenie( var T : tablica ) ;

var

i , i1 , i2 , z : integer ;

begin
   z := 0 ;
   for i:=1 to uzywane do
   begin
   z := 0 ;
   aa:=0;
   for i1:=1 to k do
   zamiana( z , i , i1 , T ) ;
             if z=1 then
             begin
             aa:=0;
             for i2:=1 to k do
             zamiana1( i , i2 , T ) ;
             z:=0;
             end;
   end;
end;

Procedure przeksztalcenie1( var T : tablica ) ;

var

i , i1 , i2 , z : integer ;

begin
   z := 0 ;
   for i:=1 to c do
   begin
   z := 0 ;
   aa:=0;
   for i1:=1 to k do
   zamiana( z , i , i1 , T ) ;
             if z=1 then
             begin
             aa:=0;
             for i2:=1 to k do
             zamiana1( i , i2 , T ) ;
             z := 0 ;
             end;
   end;
end;

Procedure wyszukaj( S : tablica ; X : dane ; var U : numery ) ;

var

i , i1 , i2 , i3 , j , d , h , l , z , t : integer ;

begin
U[1] := 0 ;
d := 0 ;
for i:=1 to da1 do
      begin
      if X[i]<>'' then
      d := d + 1 ;
      end;
if d<>0 then
    begin
    h := 0 ;
       for i:=1 to c do
         begin
         l := - 1 ;
         z := 0 ;
         for i3:=1 to k do
                       begin
                       if S[1,i3,i]<>'' then
                       l := l + 1 ;
                       end;
         j := 0 ;
         t:=0;
         for i1:=1 to k do
              begin
              if (S[2,i1,i]='lewa') and (S[1,i1,i]=szukane) then
              z := 1 ;
                   for i2:=1 to da do
                        begin
                        if (S[2,i1,i]='prawa') and (X[i2]<>'') then
                                      begin
                                      if S[1,i1,i]=X[i2] then
                                            begin
                                            j := j + 1 ;
                                            if i2>32 then
                                            t:=t+1;
                                            end;
                                      end;
                        end;
              end;
              if (j=l) and (d+t=j) and (z=1) then
                    begin
                    h := h + 1 ;
                    U[h] := i ;
                    end;
         end;
    end;
end;

Procedure wczytaj_wzory( var F : tablica ) ;

var i : integer ;

{ zmienne we wzorach w potedze wy¿szej ni¿ 1 musz¹ byc wypisywane oddzielnie }
{ wpisujac nowe wzory musisz zrobic zmiany w proc. wczytaj_wzory,wypelnij_wyrazy,wypelnij_jednostki oraz funkcji sj }

begin
F[1,1,1] := 'F' ;
F[2,1,1] := 'lewa' ;
F[3,1,1] := 'licznik' ;

F[1,2,1] := '4*PI*e0' ;
F[2,2,1] := 'prawa' ;
F[3,2,1] := 'mianownik' ;

F[1,3,1] := 'er' ;
F[2,3,1] := 'prawa' ;
F[3,3,1] := 'mianownik' ;

F[1,4,1] := 'R' ;
F[2,4,1] := 'prawa' ;
F[3,4,1] := 'mianownik' ;

F[1,5,1] := 'q' ;
F[2,5,1] := 'prawa' ;
F[3,5,1] := 'licznik' ;

F[1,6,1] := 'q1' ;
F[2,6,1] := 'prawa' ;
F[3,6,1] := 'licznik' ;

F[1,7,1] := 'R' ;
F[2,7,1] := 'prawa' ;
F[3,7,1] := 'mianownik' ;



F[1,1,2] := 'E' ;
F[2,1,2] := 'lewa' ;
F[3,1,2] := 'licznik' ;

F[1,2,2] := 'F' ;
F[2,2,2] := 'prawa' ;
F[3,2,2] := 'licznik' ;

F[1,3,2] := 'q1' ;
F[2,3,2] := 'prawa' ;
F[3,3,2] := 'mianownik' ;



F[1,1,6] := 'E' ;
F[2,1,6] := 'lewa' ;
F[3,1,6] := 'licznik' ;

F[1,2,6] := 'F' ;
F[2,2,6] := 'prawa' ;
F[3,2,6] := 'licznik' ;

F[1,3,6] := 'q' ;
F[2,3,6] := 'prawa' ;
F[3,3,6] := 'mianownik' ;



F[1,1,3] := 'En' ;
F[2,1,3] := 'lewa' ;
F[3,1,3] := 'licznik' ;

F[1,2,3] := '4*PI*e0' ;
F[2,2,3] := 'prawa' ;
F[3,2,3] := 'mianownik' ;

F[1,3,3] := 'er' ;
F[2,3,3] := 'prawa' ;
F[3,3,3] := 'mianownik' ;

F[1,4,3] := 'R' ;
F[2,4,3] := 'prawa' ;
F[3,4,3] := 'mianownik' ;

F[1,5,3] := 'q1' ;
F[2,5,3] := 'prawa' ;
F[3,5,3] := 'licznik' ;

F[1,6,3] := 'q' ;
F[2,6,3] := 'prawa' ;
F[3,6,3] := 'licznik' ;



F[1,1,4] := 'V' ;
F[2,1,4] := 'lewa' ;
F[3,1,4] := 'licznik' ;

F[1,2,4] := 'En' ;
F[2,2,4] := 'prawa' ;
F[3,2,4] := 'licznik' ;

F[1,3,4] := 'q' ;
F[2,3,4] := 'prawa' ;
F[3,3,4] := 'mianownik' ;



F[1,1,5] := 'F' ;
F[2,1,5] := 'lewa' ;
F[3,1,5] := 'licznik' ;

F[1,2,5] := 'm' ;
F[2,2,5] := 'prawa' ;
F[3,2,5] := 'licznik' ;

F[1,3,5] := 'a' ;
F[2,3,5] := 'prawa' ;
F[3,3,5] := 'licznik' ;



F[1,1,13] := 'F1' ;
F[2,1,13] := 'lewa' ;
F[3,1,13] := 'licznik' ;

F[1,2,13] := 'm1' ;
F[2,2,13] := 'prawa' ;
F[3,2,13] := 'licznik' ;

F[1,3,13] := 'a' ;
F[2,3,13] := 'prawa' ;
F[3,3,13] := 'licznik' ;



F[1,1,14] := 'F1' ;
F[2,1,14] := 'lewa' ;
F[3,1,14] := 'licznik' ;

F[1,2,14] := 'm' ;
F[2,2,14] := 'prawa' ;
F[3,2,14] := 'licznik' ;

F[1,3,14] := 'a1' ;
F[2,3,14] := 'prawa' ;
F[3,3,14] := 'licznik' ;



F[1,1,15] := 'F' ;
F[2,1,15] := 'lewa' ;
F[3,1,15] := 'licznik' ;

F[1,2,15] := 'm1' ;
F[2,2,15] := 'prawa' ;
F[3,2,15] := 'licznik' ;

F[1,3,15] := 'a1' ;
F[2,3,15] := 'prawa' ;
F[3,3,15] := 'licznik' ;



F[1,1,7] := 'V' ;
F[2,1,7] := 'lewa' ;
F[3,1,7] := 'licznik' ;

F[1,2,7] := 'En' ;
F[2,2,7] := 'prawa' ;
F[3,2,7] := 'licznik' ;

F[1,3,7] := 'q1' ;
F[2,3,7] := 'prawa' ;
F[3,3,7] := 'mianownik' ;



F[1,1,8] := 'Vp' ;
F[2,1,8] := 'lewa' ;
F[3,1,8] := 'licznik' ;

F[1,2,8] := 'R' ;
F[2,2,8] := 'prawa' ;
F[3,2,8] := 'licznik' ;

F[1,3,8] := 't' ;
F[2,3,8] := 'prawa' ;
F[3,3,8] := 'mianownik' ;



F[1,1,16] := 'Vp1' ;
F[2,1,16] := 'lewa' ;
F[3,1,16] := 'licznik' ;

F[1,2,16] := 'R1' ;
F[2,2,16] := 'prawa' ;
F[3,2,16] := 'licznik' ;

F[1,3,16] := 't' ;
F[2,3,16] := 'prawa' ;
F[3,3,16] := 'mianownik' ;



F[1,1,17] := 'Vp1' ;
F[2,1,17] := 'lewa' ;
F[3,1,17] := 'licznik' ;

F[1,2,17] := 'R' ;
F[2,2,17] := 'prawa' ;
F[3,2,17] := 'licznik' ;

F[1,3,17] := 't1' ;
F[2,3,17] := 'prawa' ;
F[3,3,17] := 'mianownik' ;



F[1,1,18] := 'Vp' ;
F[2,1,18] := 'lewa' ;
F[3,1,18] := 'licznik' ;

F[1,2,18] := 'R1' ;
F[2,2,18] := 'prawa' ;
F[3,2,18] := 'licznik' ;

F[1,3,18] := 't1' ;
F[2,3,18] := 'prawa' ;
F[3,3,18] := 'mianownik' ;



F[1,1,9] := 'En' ;
F[2,1,9] := 'lewa' ;
F[3,1,9] := 'licznik' ;

F[1,2,9] := 'Vp' ;
F[2,2,9] := 'prawa' ;
F[3,2,9] := 'licznik' ;

F[1,3,9] := 'Vp' ;
F[2,3,9] := 'prawa' ;
F[3,3,9] := 'licznik' ;

F[1,4,9] := 'm' ;
F[2,4,9] := 'prawa' ;
F[3,4,9] := 'licznik' ;

F[1,5,9] := '2' ;
F[2,5,9] := 'prawa' ;
F[3,5,9] := 'mianownik' ;



F[1,1,10] := 'En' ;
F[2,1,10] := 'lewa' ;
F[3,1,10] := 'licznik' ;

F[1,2,10] := 'R' ;
F[2,2,10] := 'prawa' ;
F[3,2,10] := 'licznik' ;

F[1,3,10] := 'F' ;
F[2,3,10] := 'prawa' ;
F[3,3,10] := 'licznik' ;



F[1,1,11] := 'F' ;
F[2,1,11] := 'lewa' ;
F[3,1,11] := 'licznik' ;

F[1,2,11] := 'm' ;
F[2,2,11] := 'prawa' ;
F[3,2,11] := 'licznik' ;

F[1,3,11] := 'g' ;
F[2,3,11] := 'prawa' ;
F[3,3,11] := 'licznik' ;


F[1,1,12] := 'R' ;
F[2,1,12] := 'lewa' ;
F[3,1,12] := 'licznik' ;

F[1,2,12] := '2' ;
F[2,2,12] := 'prawa' ;
F[3,2,12] := 'mianownik' ;

F[1,3,12] := 'a' ;
F[2,3,12] := 'prawa' ;
F[3,3,12] := 'licznik' ;

F[1,4,12] := 't' ;
F[2,4,12] := 'prawa' ;
F[3,4,12] := 'licznik' ;

F[1,5,12] := 't' ;
F[2,5,12] := 'prawa' ;
F[3,5,12] := 'licznik' ;



F[1,1,20] := 'p' ;
F[2,1,20] := 'lewa' ;
F[3,1,20] := 'licznik' ;

F[1,2,20] := 'n' ;
F[2,2,20] := 'prawa' ;
F[3,2,20] := 'licznik' ;

F[1,3,20] := 'Rg' ;
F[2,3,20] := 'prawa' ;
F[3,3,20] := 'licznik' ;

F[1,4,20] := 'T' ;
F[2,4,20] := 'prawa' ;
F[3,4,20] := 'licznik' ;

F[1,5,20] := 'Vo' ;
F[2,5,20] := 'prawa' ;
F[3,5,20] := 'mianownik' ;



F[1,1,21] := 'p1' ;
F[2,1,21] := 'lewa' ;
F[3,1,21] := 'licznik' ;

F[1,2,21] := 'n' ;
F[2,2,21] := 'prawa' ;
F[3,2,21] := 'licznik' ;

F[1,3,21] := 'Rg' ;
F[2,3,21] := 'prawa' ;
F[3,3,21] := 'licznik' ;

F[1,4,21] := 'T1' ;
F[2,4,21] := 'prawa' ;
F[3,4,21] := 'licznik' ;

F[1,5,21] := 'Vo' ;
F[2,5,21] := 'prawa' ;
F[3,5,21] := 'mianownik' ;



F[1,1,22] := 'p' ;
F[2,1,22] := 'lewa' ;
F[3,1,22] := 'licznik' ;

F[1,2,22] := 'n' ;
F[2,2,22] := 'prawa' ;
F[3,2,22] := 'licznik' ;

F[1,3,22] := 'Rg' ;
F[2,3,22] := 'prawa' ;
F[3,3,22] := 'licznik' ;

F[1,4,22] := 'T1' ;
F[2,4,22] := 'prawa' ;
F[3,4,22] := 'licznik' ;

F[1,5,22] := 'Vo1' ;
F[2,5,22] := 'prawa' ;
F[3,5,22] := 'mianownik' ;



F[1,1,23] := 'p1' ;
F[2,1,23] := 'lewa' ;
F[3,1,23] := 'licznik' ;

F[1,2,23] := 'n' ;
F[2,2,23] := 'prawa' ;
F[3,2,23] := 'licznik' ;

F[1,3,23] := 'Rg' ;
F[2,3,23] := 'prawa' ;
F[3,3,23] := 'licznik' ;

F[1,4,23] := 'T' ;
F[2,4,23] := 'prawa' ;
F[3,4,23] := 'licznik' ;

F[1,5,23] := 'Vo1' ;
F[2,5,23] := 'prawa' ;
F[3,5,23] := 'mianownik' ;



F[1,1,24] := 'En' ;
F[2,1,24] := 'lewa' ;
F[3,1,24] := 'licznik' ;

F[1,2,24] := 'm' ;
F[2,2,24] := 'prawa' ;
F[3,2,24] := 'licznik' ;

F[1,3,24] := 'g' ;
F[2,3,24] := 'prawa' ;
F[3,3,24] := 'licznik' ;

F[1,4,24] := 'R' ;
F[2,4,24] := 'prawa' ;
F[3,4,24] := 'licznik' ;



F[1,1,19] := 'En' ;
F[2,1,19] := 'lewa' ;
F[3,1,19] := 'licznik' ;

F[1,2,19] := 'q' ;
F[2,2,19] := 'prawa' ;
F[3,2,19] := 'licznik' ;

F[1,3,19] := 'U' ;
F[2,3,19] := 'prawa' ;
F[3,3,19] := 'licznik' ;



F[1,1,25] := 'F' ;
F[2,1,25] := 'lewa' ;
F[3,1,25] := 'licznik' ;

F[1,2,25] := 'G' ;
F[2,2,25] := 'prawa' ;
F[3,2,25] := 'licznik' ;

F[1,3,25] := 'R' ;
F[2,3,25] := 'prawa' ;
F[3,3,25] := 'mianownik' ;

F[1,4,25] := 'R' ;
F[2,4,25] := 'prawa' ;
F[3,4,25] := 'mianownik' ;

F[1,5,25] := 'm1' ;
F[2,5,25] := 'prawa' ;
F[3,5,25] := 'licznik' ;

F[1,6,25] := 'm' ;
F[2,6,25] := 'prawa' ;
F[3,6,25] := 'licznik' ;



F[1,1,26] := 'E' ;
F[2,1,26] := 'lewa' ;
F[3,1,26] := 'licznik' ;

F[1,2,26] := 'F' ;
F[2,2,26] := 'prawa' ;
F[3,2,26] := 'licznik' ;

F[1,3,26] := 'm' ;
F[2,3,26] := 'prawa' ;
F[3,3,26] := 'mianownik' ;



F[1,1,27] := 'E' ;
F[2,1,27] := 'lewa' ;
F[3,1,27] := 'licznik' ;

F[1,2,27] := 'F' ;
F[2,2,27] := 'prawa' ;
F[3,2,27] := 'licznik' ;

F[1,3,27] := 'm1' ;
F[2,3,27] := 'prawa' ;
F[3,3,27] := 'mianownik' ;

{ 27 }



uzywane := 0 ;
while F[1,1,uzywane+1]<>'' do
uzywane := uzywane + 1 ;
for i:=1 to uzywane do
F[5,1,i]:=IntToStr(i);
end;

Procedure nowe_wzory( var Q : tablica ) ;
var
h , i , i1 , i2 , i3 , i4 , s : integer ;
begin
h := uzywane + 1 ;
for i:=1 to uzywane do
      begin
      for i1:=1 to uzywane do
             begin
             if i1<>i then
                   begin
                   for i2:=1 to k do
                          begin
                          for i3:=1 to k do
                                 begin
                                 if (Q[1,i2,i1]=Q[1,i3,i]) and (Q[1,i2,i1]<>'') then
                                        begin
                                        szukane := Q[1,i2,i1] ;
                                        przeksztalcenie(Q);
                                        s := 0 ;
                                        Q[5,1,h] := IntToStr( i ) ;
                                        Q[6,1,h] := IntToStr( i1 ) ;
                                        Q[7,1,h] := Q[1,i2,i1] ;
                                        for i4:=1 to k do
                                                    begin
                                                    if Q[2,i4,i]='prawa' then
                                                          begin
                                                          s := s + 1 ;
                                                          Q[1,s,h] := Q[1,i4,i] ;
                                                          Q[2,s,h] := Q[2,i4,i] ;
                                                          Q[3,s,h] := Q[3,i4,i] ;
                                                          end;
                                                    end;
                                                          for i4:=1 to k do
                                                                   begin
                                                                   if Q[2,i4,i1]='prawa' then
                                                                            begin
                                                                            s := s + 1 ;
                                                                            Q[1,s,h] := Q[1,i4,i1] ;
                                                                            Q[2,s,h] := 'lewa' ;
                                                                            Q[3,s,h] := Q[3,i4,i1] ;
                                                                            end;
                                                                   end;
                                        h := h + 1 ;
                                        end;
                                 end;
                          end;
                   end;
             end;
      end;
end;

procedure uprosc_wzory( var L : tablica ) ;

var

i , i1 , i2 : integer ;

begin
for i:=1 to c do
       begin
       for i1:=1 to k do
               begin
               for i2:=1 to k do
                       begin
                       if i2<>i1 then
                               begin
                               if (L[1,i1,i]=L[1,i2,i]) and (L[1,i1,i]<>'') then
                                        begin
                                        if L[4,i1,i]='' then
                                        L[4,i1,i]:='1';
                                        if L[4,i2,i]='' then
                                        L[4,i2,i]:='1';
                                        if L[2,i2,i]=L[2,i1,i] then       {strona równa}
                                                begin
                                                if L[3,i2,i]=L[3,i1,i] then    {polozenie równe}
                                                         begin
                                                            L[1,i2,i] := '' ;
                                                            L[2,i2,i] := '' ;
                                                            L[3,i2,i] := '' ;
                                                            L[4,i1,i] := IntToStr(StrToInt(L[4,i1,i]) + StrToInt(L[4,i2,i]));
                                                            L[4,i2,i] := '' ;
                                                            if L[4,i1,i]='0' then
                                                                begin
                                                                L[1,i1,i] := '' ;
                                                                L[2,i1,i] := '' ;
                                                                L[3,i1,i] := '' ;
                                                                L[4,i1,i] := '' ;
                                                                end;
                                                         end
                                                         else                  {polozenie ró¿ne}
                                                             begin
                                                                  L[1,i2,i] := '' ;
                                                                  L[2,i2,i] := '' ;
                                                                  L[3,i2,i] := '' ;
                                                                  if (L[4,i1,i]<>'') and (L[4,i2,i]<>'') then
                                                                  L[4,i1,i] := IntToStr(StrToInt(L[4,i1,i]) - StrToInt(L[4,i2,i]));
                                                                  L[4,i2,i] := '' ;
                                                                  if L[4,i1,i]='0' then
                                                                      begin
                                                                      L[1,i1,i] := '' ;
                                                                      L[2,i1,i] := '' ;
                                                                      L[3,i1,i] := '' ;
                                                                      L[4,i1,i] := '' ;
                                                                      end;
                                                             end;
                                                end
                                                else                    {strona ró¿na}
                                                begin
                                                if L[3,i2,i]=L[3,i1,i] then    {polozenie równe}
                                                            begin
                                                                        L[1,i2,i] := '' ;
                                                                        L[2,i2,i] := '' ;
                                                                        L[3,i2,i] := '' ;
                                                                        if (L[4,i1,i]<>'') and (L[4,i2,i]<>'') then
                                                                        L[4,i1,i] := IntToStr(StrToInt(L[4,i1,i]) - StrToInt(L[4,i2,i]));
                                                                        L[4,i2,i] := '' ;
                                                                        if L[4,i1,i]='0' then
                                                                            begin
                                                                            L[1,i1,i] := '' ;
                                                                            L[2,i1,i] := '' ;
                                                                            L[3,i1,i] := '' ;
                                                                            L[4,i1,i] := '' ;
                                                                            end;
                                                            end
                                                            else            {polozenie ró¿ne}
                                                                 begin
                                                                       L[1,i2,i] := '' ;
                                                                       L[2,i2,i] := '' ;
                                                                       L[3,i2,i] := '' ;
                                                                       if (L[4,i1,i]<>'') and (L[4,i2,i]<>'') then
                                                                       L[4,i1,i] := IntToStr(StrToInt(L[4,i1,i]) + StrToInt(L[4,i2,i]));
                                                                       L[4,i2,i] := '' ;
                                                                       if L[4,i1,i]='0' then
                                                                               begin
                                                                               L[1,i1,i] := '' ;
                                                                               L[2,i1,i] := '' ;
                                                                               L[3,i1,i] := '' ;
                                                                               L[4,i1,i] := '' ;
                                                                               end;
                                                                 end;
                                                end;
                                        end;
                               end;
                       end;
               end;
       end;
end;

procedure wyswietl( M : tablica ; N : numery ; var ll1 , mm1 , ll2 , mm2 : Tedit ) ;

var

i : integer ;

begin

ll1.text := '' ;
ll2.text := '' ;
mm1.text := '' ;
mm2.text := '' ;

if N[1]<>0 then
      begin
         for i:=1 to k do
            begin
            if M[2,i,N[1]]='prawa' then
                  begin
                  if M[3,i,N[1]]='licznik' then
                           begin
                           if (M[4,i,N[1]]='') or (M[4,i,N[1]]='1') then
                           ll2.text := ll2.text + '*' + M[1,i,N[1]]
                           else
                               begin
                               if M[4,i,N[1]]<>'0' then
                               ll2.text := ll2.text + '*' + M[1,i,N[1]]+'^'+M[4,i,N[1]];
                               end;

                           end
                  else
                       begin
                           if (M[4,i,N[1]]='') or (M[4,i,N[1]]='1') then
                           mm2.text := mm2.text + '*' + M[1,i,N[1]]
                           else
                               begin
                               if M[4,i,N[1]]<>'0' then
                               mm2.text := mm2.text + '*' + M[1,i,N[1]]+'^'+M[4,i,N[1]];
                               end;

                       end;           {mm2}
                  end
                  else
                       begin
                            if M[2,i,N[1]]='lewa' then
                            begin
                                  if M[3,i,N[1]]='licznik' then
                                      begin
                                      if (M[4,i,N[1]]='') or (M[4,i,N[1]]='1') then
                                      ll1.text := ll1.text + '*' + M[1,i,N[1]]
                                          else
                                             begin
                                             if M[4,i,N[1]]<>'0' then
                                             ll1.text := ll1.text + '*' + M[1,i,N[1]]+'^'+M[4,i,N[1]];
                                             end;
                                  end        {ll1}
                                  else
                                     begin
                                     if (M[4,i,N[1]]='') or (M[4,i,N[1]]='1') then
                                     ll2.text := ll2.text + '*' + M[1,i,N[1]]
                                       else
                                          begin
                                          if M[4,i,N[1]]<>'0' then
                                          mm1.text := mm1.text + '*' + M[1,i,N[1]]+'^'+M[4,i,N[1]];
                                          end;
                                     end;      { mm1}
                            end;
                       end;
            end;
      end;
end;

procedure wypelnij_wyrazy( var D : wyr_dane ; var S : wyr_szukane ) ;

var

i , i1 , i2 : integer ;

begin
for i:=1 to 2000 do
D[1,i] := '' ;


D[1,1] := 'potencjal' ;
D[2,1] := 'V' ;

D[1,2] := 'energi' ;
D[2,2] := 'En' ;

D[1,3] := 'ladunek' ;
D[2,3] := 'q' ;

D[1,4] := 'ladunk' ;
D[2,4] := 'q' ;

D[1,5] := 'sil' ;
D[2,5] := 'F' ;

D[1,6] := 'ciezar' ;
D[2,6] := 'F' ;

D[1,7] := 'wzgledna przenikalnosc dielektryczna' ;
D[2,7] := 'er' ;

D[1,8] := 'przenikalnosc' ;
D[2,8] := 'er' ;

D[1,9] := 'er' ;
D[2,9] := 'er' ;

D[1,10] := 'mas' ;
D[2,10] := 'm' ;

D[1,11] := 'wag' ;
D[2,11] := 'm' ;

D[1,12] := 'waz' ;
D[2,12] := 'm' ;

D[1,13] := 'przyspieszeni' ;
D[2,13] := 'a' ;

D[1,14] := 'natezeni' ;
D[2,14] := 'E' ;

D[1,15] := 'predkosc' ;
D[2,15] := 'Vp' ;

D[1,16] := 'szybkosc' ;
D[2,16] := 'Vp' ;

D[1,17] := 'drog' ;
D[2,17] := 'R' ;

D[1,18] := 'glebokosc' ;
D[2,18] := 'R' ;

D[1,19] := 'drodz' ;
D[2,19] := 'R' ;

D[1,20] := 'grubosc' ;
D[2,20] := 'R' ;

D[1,21] := 'wysokosc' ;
D[2,21] := 'R' ;

D[1,22] := 'odleglosc' ;
D[2,22] := 'R' ;

D[1,23] := 'czas' ;
D[2,23] := 't' ;

D[1,24] := 'prac' ;
D[2,24] := 'En' ;

D[1,25] := 'cisnieni' ;
D[2,25] := 'p' ;

D[1,26] := 'temperatur' ;
D[2,26] := 'T' ;

D[1,27] := 'mol' ;
D[2,27] := 'n' ;

D[1,28] := 'objetosc' ;
D[2,28] := 'Vo' ;

D[1,29] := 'napieci' ;
D[2,29] := 'U' ;

D[1,30] := 'napieci' ;
D[2,30] := 'U1' ;


{ 28 }

i := 0 ;
while D[1,i+1]<>'' do
i := i + 1 ;

i2 := i + 1 ;

for i1:=1 to i do
        begin
        D[1,i2] := D[1,i1] + 'e' ;
        D[2,i2] := D[2,i1] ;
        D[1,i2+1] := D[1,i1] + 'em' ;
        D[2,i2+1] := D[2,i1] ;
        D[1,i2+2] := D[1,i1] + 'om' ;
        D[2,i2+2] := D[2,i1] ;
        D[1,i2+3] := D[1,i1] + 'ii' ;
        D[2,i2+3] := D[2,i1] ;
        D[1,i2+4] := D[1,i1] + 'i' ;
        D[2,i2+4] := D[2,i1] ;
        D[1,i2+5] := D[1,i1] + 'a' ;
        D[2,i2+5] := D[2,i1] ;
        D[1,i2+6] := D[1,i1] + 'u' ;
        D[2,i2+6] := D[2,i1] ;
        D[1,i2+7] := D[1,i1] + 'owi' ;
        D[2,i2+7] := D[2,i1] ;
        D[1,i2+8] := D[1,i1] + 'ami' ;
        D[2,i2+8] := D[2,i1] ;
        D[1,i2+9] := D[1,i1] + 'y' ;
        D[2,i2+9] := D[2,i1] ;
        D[1,i2+10] := D[1,i1] + 'rze' ;
        D[2,i2+10] := D[2,i1] ;
        D[1,i2+11] := D[1,i1] + 'ie' ;
        D[2,i2+11] := D[2,i1] ;
        D[1,i2+12] := D[1,i1] + 'ia' ;
        D[2,i2+12] := D[2,i1] ;
        D[1,i2+13] := D[1,i1] + 'lo' ;
        D[2,i2+13] := D[2,i1] ;
        D[1,i2+14] := D[1,i1] + 'ylo' ;
        D[2,i2+14] := D[2,i1] ;
        D[1,i2+15] := D[1,i1] + 'onym' ;
        D[2,i2+15] := D[2,i1] ;
        D[1,i2+16] := D[1,i1] ;
        D[2,i2+16] := D[2,i1] ;
        i2 := i2 + 17 ;
        D[1,i2] := D[1,i2-17] + '1' ;
        D[2,i2] := D[2,i1] + '1' ;
        D[1,i2+16] := D[1,i2-16] + '1' ;
        D[2,i2+16] := D[2,i1] + '1' ;
        D[1,i2+1] := D[1,i2-15] + '1' ;
        D[2,i2+1] := D[2,i1] + '1' ;
        D[1,i2+2] := D[1,i2-14] + '1' ;
        D[2,i2+2] := D[2,i1] + '1' ;
        D[1,i2+3] := D[1,i2-13] + '1' ;
        D[2,i2+3] := D[2,i1] + '1' ;
        D[1,i2+4] := D[1,i2-12] + '1' ;
        D[2,i2+4] := D[2,i1] + '1' ;
        D[1,i2+5] := D[1,i2-11] + '1' ;
        D[2,i2+5] := D[2,i1] + '1' ;
        D[1,i2+6] := D[1,i2-10] + '1' ;
        D[2,i2+6] := D[2,i1] + '1' ;
        D[1,i2+7] := D[1,i2-9] + '1' ;
        D[2,i2+7] := D[2,i1] + '1' ;
        D[1,i2+8] := D[1,i2-8] + '1' ;
        D[2,i2+8] := D[2,i1] + '1' ;
        D[1,i2+9] := D[1,i2-7] + '1' ;
        D[2,i2+9] := D[2,i1] + '1' ;
        D[1,i2+10] := D[1,i2-6] + '1' ;
        D[2,i2+10] := D[2,i1] + '1' ;
        D[1,i2+11] := D[1,i2-5] + '1' ;
        D[2,i2+11] := D[2,i1] + '1' ;
        D[1,i2+12] := D[1,i2-4] + '1' ;
        D[2,i2+12] := D[2,i1] + '1' ;
        D[1,i2+13] := D[1,i2-3] + '1' ;
        D[2,i2+13] := D[2,i1] + '1' ;
        D[1,i2+14] := D[1,i2-2] + '1' ;
        D[2,i2+14] := D[2,i1] + '1' ;
        D[1,i2+15] := D[1,i2-1] + '1' ;
        D[2,i2+15] := D[2,i1] + '1' ;
        i2 := i2 + 17 ;
        end;


S[1] := 'oblicz' ;
S[2] := 'policz' ;
S[3] := 'znajdz' ;
S[4] := 'jaki' ;
S[5] := 'jaka' ;
S[6] := 'jake' ;
S[7] := 'wyszukaj' ;
S[8] := 'wylicz' ;
S[9] := 'jakiego' ;
S[10] := 'jakim' ;
S[11] := '?' ;
S[12] := 'podaj' ;


end;

procedure wyczysc_wzory( var W: tablica ) ;

var

i , i1 , i2 : integer ;

begin
for i:=1 to c do
      for i1:=1 to k do
            for i2:=1 to 7 do
            W[ i2 , i1 , i ] := '' ;
end;

procedure wypelnij_jednostki( var F : jednostki ) ;
begin
F[ 1 ] := 'kg' ;
F[ 2 ] := 'm' ;
F[ 3 ] := 's' ;
F[ 4 ] := 'N' ;
F[ 5 ] := 'C' ;
F[ 6 ] := 'V' ;
F[ 7 ] := 'm/s' ;
F[ 8 ] := 'm/s^2' ;
F[ 9 ] := 'J' ;
F[ 10 ] := 'N/C' ;
F[ 11 ] := 'nic' ;
F[ 12 ] := 'K' ;
F[ 13 ] := 'mol' ;
F[ 14 ] := 'Pa' ;
F[ 15 ] := 'm^3' ;

end;

procedure dane_szukane( var odp1 : string ; var Y : dane ; var DJ : jednostki ; var DL : danel ; dd1 , dd2 , dd3 , dd4 , dd5 , dd6 , dd7 , dd8 , dd9 , dd10 , dd11 , dd12 , dd13 , dd14 , dd15 , dd16 , dd17 , dd18 , dd19 , dd20 , dd21 , dd22 , dd23 , dd24 , dd25 , dd26 , dd27 , dd28 , dd29 , dd30 , dd31 , dd32 : TEdit ) ;

var

Z , wyrazy_Fg : dane ;

wyrazy_dane : wyr_dane ;

wyrazy_szukane : wyr_szukane ;

i , i1 , zs : integer ;

J : jednostki ;

begin
szukane := '' ;
for i:=1 to da do
   begin
   Y[i] := '' ;
   DJ[i] := '' ;
   DL[i] := 0 ;
   end;
wypelnij_wyrazy(wyrazy_dane,wyrazy_szukane) ;
wypelnij_jednostki( J ) ;

Z[1] := dd1.Text ;
Z[2] := dd2.Text ;
Z[3] := dd3.Text ;
Z[4] := dd4.Text ;
Z[5] := dd5.Text ;
Z[6] := dd6.Text ;
Z[7] := dd7.Text ;
Z[8] := dd8.Text ;
Z[9] := dd9.Text ;
Z[10] := dd10.Text ;
Z[11] := dd11.Text ;
Z[12] := dd12.Text ;
Z[13] := dd13.Text ;
Z[14] := dd14.Text ;
Z[15] := dd15.Text ;
Z[16] := dd16.Text ;
Z[17] := dd17.Text ;
Z[18] := dd18.Text ;
Z[19] := dd19.Text ;
Z[20] := dd20.Text ;
Z[21] := dd21.Text ;
Z[22] := dd22.Text ;
Z[23] := dd23.Text ;
Z[24] := dd24.Text ;
Z[31] := dd31.Text ;
Z[32] := dd32.Text ;
Z[25] := dd25.Text ;
Z[26] := dd26.Text ;
Z[27] := dd27.Text ;
Z[28] := dd28.Text ;
Z[29] := dd29.Text ;
Z[30] := dd30.Text ;


  { stale we wzorach }

  Y[ 33 ] := '2' ;
  DL[ 33 ] := 2 ;
  Y[ 34 ] := '4*PI*e0' ;
  DL[ 34 ] := 0.000000000111 ;
  Y[ 35 ] := 'g' ;
  DL[ 35 ] := 9.806 ;
  Y[ 36 ] := 'Rg' ;
  DL[ 36 ] := 8.31434 ;
   Y[ 37 ] := 'G' ;
  DL[ 37 ] := 0.0000000000667259 ;


  zs := 0 ;

  for i:=1 to da1 do
       begin
        if szukane<>'' then
        break;
          begin
          for i1:=1 to 100 do
                    begin
                    if (Z[i]=wyrazy_szukane[i1]) and (Z[i]<>'') and (zs=0) then
                            begin
                            Z[i]:='';
                            zs:=1;
                            break;
                            end;
                    end;
       for i1:=1 to 2000 do
               begin
               if (wyrazy_dane[1,i1]=Z[i]) and (Z[i]<>'') and (zs=1) then
                      begin
                      szukane := wyrazy_dane[ 2 , i1 ] ;
                      odp1 := wyrazy_dane[ 1 , i1 ] ;
                      Z[i] := '' ;
                      break;
                      end;
               end;
          end;
       end;

  zs := 0 ;
  aa := 0 ;

  for i:=1 to da1 do
      begin

      if aa=0 then
            begin
            for i1:=1 to 2000 do
                begin
                if (wyrazy_dane[1,i1]=Z[i]) and (Z[i]<>'') then
                        begin
                        zs := zs + 1 ;
                        Y[ zs ] := wyrazy_dane[ 2 , i1 ] ;
                        aa := 1 ;
                        break;
                        end;
                end;
            end;

      if aa=1 then
            begin
            for i1:=1 to 1500 do
                begin
                if (J[i1]=Z[i]) and (Z[i]<>'') then
                        begin
                        DJ[ zs ] := Z[ i ] ;
                        Z[i] := '' ;
                        DL[zs]:=StrToCurr(Z[i-1]) ;
                        Z[i-1] := '' ;
                        aa := 0 ;
                        break;
                        end;
                end;
            end;


      end;

  for i:=1 to da1 do
               begin
               if (Y[i]='a') then
               Y[ 26 ] := '' ;
               end;


end;

procedure uprosc_dane( var C : dane ) ;
var

i , i1 : integer ;

begin
      for i:=1 to da do
             for i1:=1 to da do
                     if (i<>i1) and (C[i]=C[i1]) and (C[i]<>'') then
                              C[i1]:='';
end;

function sj() : string ;
begin
if szukane='R' then
result:='m';
if szukane='F' then
result:='N';
if szukane='g' then
result:='m/s^2';
if szukane='E' then
result:='N/C';
if szukane='m' then
result:='kg';
if szukane='En' then
result:='J';
if szukane='q1' then
result:='C';
if szukane='q' then
result:='C';
if szukane='4*PI*e0' then
result:='F/m';
if szukane='V' then
result:='V';
if szukane='Vp' then
result:='m/s';
if szukane='a' then
result:='m/s^2';
if szukane='er' then
result:='nic';
if szukane='t' then
result:='s';
if szukane='t1' then
result:='s';
if szukane='R1' then
result:='m';
if szukane='Vp1' then
result:='m/s';
if szukane='a1' then
result:='m/s^2';
if szukane='m1' then
result:='kg';
if szukane='En1' then
result:='J';
if szukane='F1' then
result:='N';
if szukane='E1' then
result:='N/C';
if szukane='V1' then
result:='V';
if szukane='Vo' then
result:='m^3';
if szukane='Vo1' then
result:='m^3';
if szukane='p' then
result:='Pa';
if szukane='p1' then
result:='Pa';
if szukane='n' then
result:='mol';
if szukane='T' then
result:='K';
if szukane='T1' then
result:='K';
if szukane='U' then
result:='V';
if szukane='U1' then
result:='V';

end;

function sj1() : string ;
begin
if szukane='R' then
result:='m';
if szukane='F' then
result:='N';
if szukane='g' then
result:='m/s^2';
if szukane='E' then
result:='m/s^2';
if szukane='m' then
result:='kg';
if szukane='En' then
result:='J';
if szukane='q1' then
result:='C';
if szukane='q' then
result:='C';
if szukane='4*PI*e0' then
result:='F/m';
if szukane='V' then
result:='V';
if szukane='Vp' then
result:='m/s';
if szukane='a' then
result:='m/s^2';
if szukane='er' then
result:='nic';
if szukane='t' then
result:='s';
if szukane='t1' then
result:='s';
if szukane='R1' then
result:='m';
if szukane='Vp1' then
result:='m/s';
if szukane='a1' then
result:='m/s^2';
if szukane='m1' then
result:='kg';
if szukane='En1' then
result:='J';
if szukane='F1' then
result:='N';
if szukane='E1' then
result:='m/s^2';
if szukane='V1' then
result:='V';
if szukane='Vo' then
result:='m^3';
if szukane='Vo1' then
result:='m^3';
if szukane='p' then
result:='Pa';
if szukane='p1' then
result:='Pa';
if szukane='n' then
result:='mol';
if szukane='T' then
result:='K';
if szukane='T1' then
result:='K';
if szukane='U' then
result:='V';
if szukane='U1' then
result:='V';

end;

procedure wyswietl_wynik( wynik1 , sz1 , szj1 : Tedit ; C : tablica ; B : numery ; LL : danel ; JJ : jednostki ; D1 : dane) ;
var
i , i1 , i2 , b1 : integer ;
wynik : Real ;
begin
wynik := 1 ;
for i:=1 to k do
     begin
     for i1:=1 to da do
           begin
           if (C[1,i,B[1]]=D1[i1]) and (C[2,i,B[1]]='prawa') and (D1[i1]<>'') then
                     begin
                     if C[4,i,B[1]]<>'' then
                     b1:=StrToInt(C[4,i,B[1]])
                     else
                     b1:=1;
                     for i2:=1 to b1 do
                            begin
                            if C[3,i,B[1]]='licznik' then
                            wynik:=wynik*LL[i1]
                            else
                            wynik:=wynik/LL[i1];
                            end;
                     end;
           end;
     end;
for i:=1 to k do
           if C[1,i,B[1]]=szukane then
                    if C[4,i,B[1]]<>'' then
                    wynik:=Power(wynik,(1/StrToInt(C[4,i,B[1]])));
sz1.Text := szukane;
wynik1.Text := CurrToStr(wynik) ;
i1:=0;
for i:=1 to da do
     if D1[i]='m' then
     i1:=1;
if i1=0 then
szj1.Text := sj() 
else
szj1.Text := sj1() ;
end;

procedure TForm1.RozwiazanieClick(Sender: TObject) ;

var

i : 1..da ;

P : tablica ;

NN : numery ;

DD : dane ;

DDJ : jednostki ;

a , odp : String ;

DDL : danel ;

begin
wyczysc_wzory( P ) ;
wczytaj_wzory( P ) ;
nowe_wzory( P ) ;
uprosc_wzory( P ) ;
dane_szukane( odp , DD , DDJ , DDL , d1 , d2 , d3 , d4 , d5 , d6 , d7 , d8 , d9 , d10 , d11 , d12 , d13 , d14 , d15 , d16 , d17 , d18 , d19 , d20 , d21 , d22 , d23 , d24 , d25 , d26 , d27 , d28 , d29 , d30 , d31 , d32 ) ;
uprosc_dane( DD ) ;
  { Wyswietlanie wzorów }

odp2.Caption := '' ;
szukaned.Caption := '' ;
daned.Caption := '' ;
wynik.Text := '' ;
szj.text := '' ;
sz.Text := '' ;


if szukane<>'' then
szukaned.Caption := szukane + ' = ?' ;
for i:=1 to da1 do
      begin
      if DD[i]<>'' then
            begin
            if daned.Caption='' then
            daned.Caption := DD[i] + '=' + CurrToStr(DDL[i]) + DDJ[i]
            else
            daned.Caption := daned.Caption + ',' + DD[ i ]+ '=' + CurrToStr(DDL[i]) + DDJ[i] ;
            end;
      end;
przeksztalcenie1( P ) ;
wyszukaj( P , DD , NN ) ;
if NN[1]<>0 then
wyswietl_wynik( wynik , sz , szj , P , NN , DDL , DDJ , DD ) ;
     a := P[ 7 , 1 , NN[ 1 ] ] ;
     if P[6,1,NN[1]]<>'' then
     NN[ 6 ] := StrToInt( P[ 6 , 1 , NN[ 1 ] ] )
        else
        NN[ 6 ] := 0 ;
     if P[5,1,NN[1]]<>'' then
     NN[ 5 ] := StrToInt( P[ 5 , 1 , NN[ 1 ] ] )
        else
        NN[ 5 ] := 0 ;
     wyswietl( P , NN , l1 , m1 , l2 , m2 ) ;
     wyczysc_wzory( P ) ;
     wczytaj_wzory( P ) ;
     uprosc_wzory( P ) ;
     NN[ 1 ] := NN[ 6 ] ;
     wyswietl( P , NN , l16 , m16 , l26 , m26 ) ;
     NN[ 1 ] := NN[ 5 ] ;
     wyswietl( P , NN , l15 , m15 , l25 , m25 ) ;
     if a='' then
     NN[1]:=0;
          szukane:=a;
          przeksztalcenie( P ) ;
          wyswietl( P , NN , l175 , m175 , l275 , m275 ) ;
          NN[ 1 ] := NN[ 6 ] ;
          wyswietl( P , NN , l176 , m176 , l276 , m276 ) ;
if sz.text<>'' then
odp2.Caption := odp + ' wynosi ' + wynik.Text + ' ' + szj.text + '.' ;    

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Showmessage('Zadanie nalezy pisac malymi literami bez polskich znakow. W kolejnych okienkach nalezy wpisac kolejne wyrazy tresci zadania. Oznaczenia wzorów sa juz przyjete . ');
Showmessage(' Jesli chcemy wprowadzic 2 rozne zmienne przedstawiajace ta sama wielkosc to do nazwy dodajemy bez odstepu cyfre 1 np. odleglosc odleglosc1 .' );
Showmessage('Po wpisaniu tresci nalezy wcisnac przycisk "rozwiaz zadanie" i sprawdzic czy dane i szukane zostaly poprawnie odczytane . Tresc zadania musi byc pelna z jednostkami' );
Showmessage('Jednostki  kg  m -metry  s -sekundy  N -niuton  C -coulomb  V -volt  m/s   m/s^2  J   N/C  nic -wielkosc bezwymiarowa   mol   Pa   m^3   m^2' );
end;

end.
