unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, MaskEdit, Spin,
  EditBtn, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    EFactorA: TFloatSpinEdit;
    EFactorB: TFloatSpinEdit;
    EFactorC: TFloatSpinEdit;
    EResultX1: TFloatSpinEdit;
    EResultX2: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LResultX1: TLabel;
    LResultX2: TLabel;
    procedure Button1Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, c, D, x1, x2, ca: real;
  hasRoots: (hrNone, hrSingle, hrDouble);
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
  //Input
  a := EFactorA.Value;
  b := EFactorB.Value;
  c := EFactorC.Value;

  //Determine a kind of equation
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
        hasRoots := hrNone;
      end
      else if D = 0 then
      begin
        hasRoots := hrSingle;
        x1 := -b / (2 * a);
      end
      else if D > 0 then
      begin
        hasRoots := hrDouble;
        x1 := (-b - sqrt(D)) / (2 * a);
        x1 := (-b + sqrt(D)) / (2 * a);
      end;

    end;

    //ax^2 = 0
    ekBAndCAreZeroes:
    begin
      hasRoots := hrSingle;
      x1 := 0;
    end;

    //ax^2 + bx = 0
    ekCIsZero:
    begin
      hasRoots := hrDouble;
      x1 := 0;
      x2 := -b / a;
    end;

    //ax^2 + c = 0
    ekBIsZero:
    begin
      ca := -c / a;
      if ca < 0 then
      begin
        hasRoots := hrNone;
      end
      else if ca = 0 then
      begin
        hasRoots := hrSingle;
        x1 := 0;
      end
      else
      begin
        hasRoots := hrDouble;
        x1 := sqrt(ca);
        x2 := -x1;
      end;
    end;
  end;

  //Display the results
  case (hasRoots) of
    hrNone:
    begin
      LResultX1.Visible := False;
      LResultX2.Visible := False;
      EResultX1.Visible := False;
      EResultX2.Visible := False;
    end;
    hrSingle:
    begin
      LResultX1.Visible := True;
      LResultX2.Visible := False;
      EResultX1.Visible := True;
      EResultX2.Visible := False;

      EResultX1.Value := x1;
    end;
    hrDouble:
    begin
      LResultX1.Visible := True;
      LResultX2.Visible := True;
      EResultX1.Visible := True;
      EResultX2.Visible := True;

      EResultX1.Value := x1;
      EResultX2.Value := x2;
    end;
  end;

end;


end.
