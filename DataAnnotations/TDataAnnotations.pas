unit TDataAnnotations;

interface

uses
  System.Classes,System.Rtti, Vcl.Controls;

type
Required=class(TCustomAttribute)
  private
    FErroMessage: string;
  public
    property ErroMessage: string read FErroMessage;

    procedure Validar(const AField : TRttiField; const Objeto : TObject);
    constructor Create(const AErroMessage : string);
end;

StringLenth=class(TCustomAttribute)
  private
    FErroMessage: string;
    FMinLenth: Integer;
    FMaxLenth: Integer;
  public
    property ErroMessage: string read FErroMessage;
    property MinLenth: Integer read FMinLenth;
    property MaxLenth: Integer read FMaxLenth;

    procedure Validar(const AField : TRttiField; const Objeto : TObject);
    constructor Create(const AMinLenth,AMaxLenth : Integer;  const AErroMessage : string);
end;

MaxMinValue=class(TCustomAttribute)
  private
    FErroMessage: string;
    FMaxValue: Double;
    FMinValue: Double;
  public
    property ErroMessage: string read FErroMessage write FErroMessage;
    property MaxValue: Double read FMaxValue;
    property MinValue: Double read FMinValue;

    procedure Validar(const AField : TRttiField; const Objeto : TObject);
    constructor Create(const AMinValue,AMaxValue : double; const AErroMessage : string);
end;

TObterValores = class
  public
    class function GetText(AComponent : TComponent):string;
end;

implementation

uses
  Vcl.StdCtrls, System.SysUtils, Vcl.Dialogs;

{ Required }

constructor Required.Create(const AErroMessage: string);
begin
    FErroMessage := AErroMessage;
end;

procedure Required.Validar(const AField: TRttiField; const Objeto: TObject);
var
  LComponent : TComponent;
begin
    LComponent := AField.GetValue(Objeto).AsObject as TComponent;
    if TObterValores.GetText(LComponent) = '' then
      raise Exception.Create(AField.Name+FErroMessage);
end;

{ StringLenth }

constructor StringLenth.Create(const AMinLenth, AMaxLenth: Integer;
  const AErroMessage: string);
begin
    FErroMessage := AErroMessage;
    FMinLenth := AMinLenth;
    FMaxLenth := AMaxLenth;
end;

procedure StringLenth.Validar(const AField: TRttiField; const Objeto: TObject);
var
  LComponent : TComponent;
begin
    LComponent := AField.GetValue(Objeto).AsObject as TComponent;
    if  (TObterValores.GetText(LComponent).Length < FMinLenth)
    or (TObterValores.GetText(LComponent).Length > FMaxLenth) then
      raise Exception.Create(AField.Name+FErroMessage);
end;


{ MaxMinValue }

constructor MaxMinValue.Create(const AMinValue, AMaxValue: double;
  const AErroMessage: string);
begin
    ErroMessage := AErroMessage;
    FMaxValue := AMaxValue ;
    FMinValue := AMinValue ;
end;

procedure MaxMinValue.Validar(const AField: TRttiField; const Objeto: TObject);
var
  LComponent : TComponent;
begin
    LComponent := AField.GetValue(Objeto).AsObject as TComponent;
    if  (StrToFloat(TObterValores.GetText(LComponent)) < FMinValue)
    or (StrToFloat(TObterValores.GetText(LComponent)) > FMaxValue) then
      raise Exception.Create(AField.Name+' Valor informado deve ficar entre "'+FloatToStr(FMinValue)
      +' e '+FloatToStr(FMaxValue));
end;

{ TObterValores }

class function TObterValores.GetText(AComponent: TComponent): string;
begin
    Result := '';
    if AComponent is TEdit then
       Result := TEdit(AComponent).Text;

    if AComponent is TMemo then
       Result := TMemo(AComponent).Text;

    if AComponent is TComboBox then
       Result := TComboBox(AComponent).Text;
end;

end.
