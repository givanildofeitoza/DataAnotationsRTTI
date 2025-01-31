unit RTTICustomDataAnnotaions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, TDataAnnotations;

type
  TForm2 = class(TForm)
   [MaxMinValue(1,9,': O valor deve ser entre 1 e 9')]
    txt01: TEdit;
   [Required(': N�o pode ser vazio!')]
    txt03: TEdit;

   [StringLenth(2,5,': tamanho da string deve ficar entre 2 e 5')]
    Txt02: TEdit;

    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  System.Rtti;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  LRTTI : TRttiContext;
  LRTTIType : TRttiType;
  LRttiFields : TArray<TRttiField>;
  LField : TRttiField;
  LCustomAttribute : TCustomAttribute;
begin
   LRTTI := TRttiContext.Create;
   LRTTIType := LRTTI.GetType(TForm2);
   LRttiFields :=  LRTTIType.GetFields;

   for LField in LRttiFields do
   begin
       for LCustomAttribute in LField.GetAttributes do
       begin
            if LCustomAttribute is Required then
               Required(LCustomAttribute).Validar(LField,self);

            if LCustomAttribute is StringLenth then
               StringLenth(LCustomAttribute).Validar(LField,self);

            if LCustomAttribute is MaxMinValue then
               MaxMinValue(LCustomAttribute).Validar(LField,self);
       end;
   end;

end;

end.
