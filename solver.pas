unit solver;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  RootsNumber = (rnNone, rnSingle, rnDouble);

  SquareEquationResult = record
    x1, x2: real;
    roots: RootsNumber;
  end;

function SolveSquareEqation(a, b, c: real): SquareEquationResult;


implementation


function SolveSquareEqation(a, b, c: real): SquareEquationResult;
var
  D, ca: real;
  equationKind: (
    //ax^2 = 0
    ekBAndCAreZeroes,
    //ax^2 + bx = 0
    ekCIsZero,
    //ax^2 + c = 0
    ekBIsZero,
    //complete
    ekComplete);
begin
  if (b = 0) and (c = 0) then equationKind := ekBAndCAreZeroes
  else if c = 0.0 then equationKind := ekCIsZero
  else if b = 0.0 then equationKind := ekBIsZero
  else
    equationKind := ekComplete;

  //Solve the equation
  case (equationKind) of
    ekComplete:
    begin
      D := sqr(b) - 4 * a * c;

      if D < 0 then
      begin
        SolveSquareEqation.roots := rnNone;
      end
      else if D = 0 then
      begin
        SolveSquareEqation.roots := rnSingle;
        SolveSquareEqation.x1 := -b / (2 * a);
      end
      else if D > 0 then
      begin
        SolveSquareEqation.roots := rnDouble;
        SolveSquareEqation.x1 := (-b - sqrt(D)) / (2 * a);
        SolveSquareEqation.x2 := (-b + sqrt(D)) / (2 * a);
      end;

    end;

    //ax^2 = 0
    ekBAndCAreZeroes:
    begin
      SolveSquareEqation.roots := rnSingle;
      SolveSquareEqation.x1 := 0;
    end;

    //ax^2 + bx = 0
    ekCIsZero:
    begin
      SolveSquareEqation.roots := rnDouble;
      SolveSquareEqation.x1 := 0;
      SolveSquareEqation.x2 := -b / a;
    end;

    //ax^2 + c = 0
    ekBIsZero:
    begin
      ca := -c / a;
      if ca < 0 then
      begin
        SolveSquareEqation.roots := rnNone;
      end
      else if ca = 0 then
      begin
        SolveSquareEqation.roots := rnSingle;
        SolveSquareEqation.x1 := 0;
      end
      else
      begin
        SolveSquareEqation.roots := rnDouble;
        SolveSquareEqation.x1 := sqrt(ca);
        SolveSquareEqation.x2 := -SolveSquareEqation.x1;
      end;
    end;
  end;

end;

end.
