unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, MaskEdit, Spin,
  StdCtrls, ExtCtrls, solver;

type

  { TForm1 }

  TForm1 = class(TForm)
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
    LResultNoRoots: TLabel;
    procedure Solve(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Solve(Sender: TObject);
var
  a, b, c: real;
  r: SquareEquationResult;
begin
  a := EFactorA.Value;
  b := EFactorB.Value;
  c := EFactorC.Value;

  r := SolveSquareEqation(a, b, c);

  LResultNoRoots.Visible := r.roots = rnNone;

  EResultX1.Visible := (r.roots = rnSingle) or (r.roots = rnDouble);
  LResultX1.Visible := EResultX1.Visible;

  EResultX2.Visible := (r.roots = rnDouble);
  LResultX2.Visible := EResultX2.Visible;

  if (r.roots = rnSingle) or (r.roots = rnDouble) then EResultX1.Value := r.x1;
  if r.roots = rnDouble then EResultX2.Value := r.x2;

end;


end.
