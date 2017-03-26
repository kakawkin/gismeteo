unit Unit2;
 
interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Registry, Vcl.StdCtrls, Vcl.ExtCtrls,jpeg,PNGImage, winsock;
 
function HTTPGet(Query:string):string;

implementation

function HTTPGet(Query:string):string;

   //HTTPGet('site.ru','/index.php?id=123');
 var
   WSAData1: TWSAData;
   SockAddr1:TSockAddr;
   Socket1: TSocket;
   //Buffer1:string;
   Buffer1,Response:array [0..5000] of AnsiChar;
   i,d:integer;
   //Response:string;
   BytesRead: Integer;
   zapros:Ansistring;
   s:string;
 begin
 //Если при вызове, функция выдала значение не равное "0", то выходим из функции.
   if WSAStartup($101, WSAData1)<>0 then begin result:='ERROR'; exit; end;
   Socket1:=Socket(AF_INET,SOCK_STREAM,0); // Создаём Socket
   if Socket1=INVALID_SOCKET then begin result:='ERROR'; exit; end; // Если при создании возникла ошибка, то выходим из функции.
   SockAddr1.sin_family:=AF_INET; // Указываем спецификацию типа "AF_INET" для TCP/IP
   //SockAddr1.sin_addr:=pinaddr(gethostbyname(PAnsiChar(URL))^.h_addr^)^; // Тута мы вводим ссылку, получаем IP адрес сайта.
   SockAddr1.sin_port:=htons(80); //Ну порт с которым всегда работаем "80"
   SockAddr1.sin_addr.S_addr:= inet_addr('130.193.66.227');
   if Connect(Socket1,SockAddr1,SizeOf(SockAddr1))<>0 then begin result:='ERROR'; exit; end; //Если при подключении (не отправке), функция возвращает значение не равное "0", то выходим из функции.

   zapros:='GET /xml/'+Query+'_1.xml HTTP/1.1'+#13#10+
            'Host: informer.gismeteo.ru'+#13#10+
            'Connection: keep-alive'+#13#10+
            'Cache-Control: max-age=0'+#13#10+
            'Upgrade-Insecure-Requests: 1'+#13#10+
            'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36'+#13#10+
            'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'+#13#10+
            'Accept-Encoding: gzip, deflate, sdch'+#13#10+
            'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4'+#13#10+
            'X-Compress: null'+#13#10+
            #13#10;
            // Выше мы составили Header
   Move(zapros[1],Buffer1,length(zapros));
   if send(Socket1,Buffer1[0],SizeOf(Buffer1),0)=SOCKET_ERROR then begin result:='ERROR'; end;
   FillChar(Response, 5001, 0);
   //SetLength(Response,65536);
   //BytesRead := Recv(Socket1, PChar(Response)^, 65536, 0);
   recv(Socket1, Response[0], SizeOf(Response), 0);
   s:=Response;
   Delete(s,1,Pos('<?xml',s)-1); // удаляем HTTP ответ
   Delete(s,Pos('</MMWEATHER>',s)+12,Length(s)-Pos('</MMWEATHER>',s)+12);  // удаляем мусор после конца XML файла
   result:=s;
   CloseSocket(Socket1);
   WSACleanup;
 end;


 
end.