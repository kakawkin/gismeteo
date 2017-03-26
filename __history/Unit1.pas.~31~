unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry, Vcl.StdCtrls, Vcl.ExtCtrls,jpeg,PNGImage,
  winsock,Unit2, Vcl.ExtDlgs, MSXML, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.Samples.Spin, Vcl.ComCtrls, inifiles;

type
  TMyArray = Array of String;
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Memo1: TMemo;
    Timer1: TTimer;
    XMLDocument: TXMLDocument;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Timer2: TTimer;
    ColorBox1: TColorBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function ImageText(var Image:TImage;x,y:integer;text:array of string):boolean;
    function GetWeatherFile(number:integer): TMyArray;
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    function check_file_and_folder():string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  WindowsWallpaper, mypicture: string;
  x0,y0,fontt: integer;
  move: boolean;
  tod: array [0..3] of string=('Ночь','Утро','День','Вечер');
  cloudiness: array[0..3] of string=('Ясно','Малооблачно','Облачно','Пасмурно');
  precipitation: array[4..10] of string=('дождь','ливень','снег','снег','гроза','нет данных','без осадков');
  direction: array [0..7] of string=('Северный','Северо-восточный','Восточный','Юго-восточный','Южный','Юго-западный','Западный','Северо-западный');
  week: array [0..6] of string=('воскресенье','понедельник','вторник','среда','четверг','пятница','суббота');
implementation

{$R *.dfm}

function GetAspect(): string; // соотношение сторон
var
  Aspect:single;
  W,H:integer;
  i:string;
begin
  W := GetSystemMetrics(SM_CXSCREEN);
  H := GetSystemMetrics(SM_CYSCREEN);
  Aspect:= (W / H);
  {showmessage('16:10= '+FloatToStrF(16/10,ffFixed,9,2)+#13#10+
  '16:9= '+FloatToStrF(16/9,ffFixed,9,2)+#13#10+
  '5:4= '+FloatToStrF(5/4,ffFixed,9,2)+#13#10+
  '4:3= '+FloatToStrF(4/3,ffFixed,9,2)+#13#10);}  //ррр
  i:=FloatToStrF(Aspect,ffFixed,9,2);
  result:=i;
end;

procedure TForm1.FormCreate(Sender: TObject);
var s:string;
    Ini: Tinifile;
begin
  trackbar1.Position:=5;
  GetAspect();
  Form1.Position:=poScreenCenter; // форма по середине экрана
  check_file_and_folder();
  Image1.Picture.LoadFromFile(mypicture+'\Gismeteo\gismeteo.jpg'); // Картинка рабочего стола в Image1
  Image3.Height:=100; // соотношение сторон логотипа
  Image3.Width:=round(Image3.Height*1.3);
  Image3.Picture.LoadFromFile('logo.png'); // Логотип Gismeteo в Image3
  Form1.DoubleBuffered:=true; // убираем мерцания при передвижении виджета
  Ini:=TInifile.Create(extractfilepath(paramstr(0))+'MyIni.ini'); // ассоциация ini файла
  if FileExists(extractfilepath(paramstr(0))+'MyIni.ini') then
  begin // если есть файл - считываем данные
  end
  else
  begin // Если отсутствует файл - записываем данные
    Ini.WriteInteger('scale_Image','value',trackbar1.Position+1);
    Ini.WriteString('Aspect','value',GetAspect);
  end;
  Ini.Free;
end;

function TForm1.check_file_and_folder():string;
var R: TRegistry;
begin
  R:=TRegistry.Create(); // путь с реестра до картинки рабочего стола, и до папки Мои картинки
  R.OpenKeyReadOnly('Control Panel\Desktop');
  WindowsWallpaper:=R.ReadString('WallPaper');
  R.CloseKey;
  R.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders');
  mypicture:=R.ReadString('My Pictures');
  R.CloseKey;
  R.Free;
  if DirectoryExists(mypicture+'\Gismeteo')
    then
    else CreateDir(mypicture+'\Gismeteo');
  if FileExists(mypicture+'\Gismeteo\gismeteo.jpg')
    then
    else CopyFile(Pchar(WindowsWallpaper),PChar(mypicture+'\Gismeteo\gismeteo.jpg'), false);

end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  if button <> mbLeft then
    move:=false //если нажали не левой кнопкой, то перемещать не будем!
  else
  begin
    move:=true;
    x0:=x; //запоминаем начальные координаты
    y0:=y; //запоминаем начальные координаты
  end;
end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if move then
  begin
    image2.Left:=image2.Left+x-x0;
    image2.Top:=image2.Top+y-y0;
    image3.Left:=image3.Left+x-x0;
    image3.Top:=image3.Top+y-y0;
  end;
end;

procedure TForm1.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  move := false;
end;

function TForm1.ImageText(var Image:TImage;x,y:integer;text:array of string):boolean;
var
  bmp: TBitmap;
  var i:integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=image.Width;
  bmp.Height:=image.Height;
  bmp.Canvas.Brush.Style:=bsClear;
  bmp.Canvas.Font.Color:=ColorBOx1.Selected;
  bmp.Canvas.Font.Size:=TrackBar1.Position+6;
  bmp.Canvas.Font.Quality:=fqAntialiased;
  bmp.Canvas.Font.Name:='Calibri';
  for i:=0 to 6 do
    begin
      bmp.Canvas.TextOut(x,y+((TrackBar1.Position+6+3)*i),text[i]);
    end;
  image.Picture:=nil;
  image.Transparent:=true;
  image.Picture.Bitmap.Assign(bmp);
  bmp.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var data:TMyArray;
begin
  if length(data)>10 then ImageText(Image2,100,90,data);
  data:=GetWeatherFile(28722);
  //data[0]=дата | data[1]=облачность | data[2]=осадки | data[3]=давление | data[4]=температура | data[5]=ветер | data[6]=влажность
  ImageText(Image2,100,90,data);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var i:integer;
begin
  i:=timer1.Interval;
  timer1.Interval:=1;
  timer1.Interval:=i;
end;

function TForm1.GetWeatherFile(number:integer): TMyArray;
var query:string;
    Root: IXMLNode;
    day,month,year:string; // день, число, год
    i,j,k: integer; // для хранения
    text:string;
begin
  SetLength(result, 7);
  //Memo1.Text:=Unit2.HTTPGet(inttostr(number));
  //Memo1.Lines.SaveToFile('weather.xml');
  //XMLDocument.LoadFromFile(ExtractFileDir(ParamStr(0))+'\weather.xml');
  text:=Unit2.HTTPGet(inttostr(number));
  XMLDocument.LoadFromXML(text);
  XMLDocument.Active:=True;
  root:=XMLDocument.DocumentElement;
  day:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].GetAttribute('day');
  month:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].GetAttribute('month');
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].GetAttribute('tod');

  result[0]:= day+'.'+month+', '+tod[i];
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[0].GetAttribute('cloudiness');
  j:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[0].GetAttribute('precipitation');

  result[1]:=cloudiness[i];

  result[2]:=precipitation[j];
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[1].GetAttribute('min');
  j:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[1].GetAttribute('max');

  result[3]:='Давление: '+inttostr(round((i+j)/2))+' мм рт.ст.';
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[2].GetAttribute('min');
  j:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[2].GetAttribute('max');

  result[4]:='Температура: '+inttostr(i)+'..'+inttostr(j)+' C°';
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[3].GetAttribute('min');
  j:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[3].GetAttribute('max');
  k:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[3].GetAttribute('direction');

  result[5]:='Ветер: '+direction[k]+' '+inttostr(i)+'-'+inttostr(j)+' м/с';
  i:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[4].GetAttribute('min');
  j:=root.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[4].GetAttribute('max');

  result[6]:='Влажность: '+inttostr(round((i+j)/2))+'%';
end;


end.
