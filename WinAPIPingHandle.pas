unit WinAPIPingHandle;

interface

uses WinAPIICMPDeclare, Windows;

const
  INADDR_NONE: integer = -1;

procedure Ping(const Address, EchoString: PChar;
  var PingReply: TsmICMP_Echo_Reply; const PingTimeout: integer = 500);

function PingStatusToStr(StatusCode: integer): string;

function inet_addr(IPAddress: PChar): TipAddr; StdCall;

implementation

uses Dialogs, SysUtils;

procedure Ping(const Address, EchoString: PChar;
  var PingReply: TsmICMP_Echo_Reply; const PingTimeout: integer = 500);
var
  IPAddress: TipAddr;
  ICMPPort: THandle;
begin
  IPAddress := inet_addr(Address);
  if (IPAddress = INADDR_NONE) then
  begin
    raise Exception.Create('Function call inet_addr failed. ' +
      'The IP address is probably invalid.');
  end;
  ICMPPort := IcmpCreateFile();
  if (ICMPPort = INVALID_HANDLE_VALUE) then
  begin
    raise Exception.Create('Function call IcmpCreateFile failed.');
  end;
  IcmpSendEcho(ICMPPort, IPAddress, EchoString, Length(EchoString), nil,
    @PingReply, SizeOf(PingReply), PingTimeout);
  IcmpCloseHandle(ICMPPort);
end;

function PingStatusToStr(StatusCode: integer): string;
begin
  case (StatusCode) of
    IP_SUCCESS:
      Result := 'IP_SUCCESS';
    IP_BUF_TOO_SMALL:
      Result := 'IP_BUF_TOO_SMALL';
    IP_DEST_NET_UNREACHABLE:
      Result := 'IP_DEST_NET_UNREACHABLE';
    IP_DEST_HOST_UNREACHABLE:
      Result := 'IP_DEST_HOST_UNREACHABLE';
    IP_DEST_PROT_UNREACHABLE:
      Result := 'IP_DEST_PROT_UNREACHABLE';
    IP_DEST_PORT_UNREACHABLE:
      Result := 'IP_DEST_PORT_UNREACHABLE';
    IP_NO_RESOURCES:
      Result := 'IP_NO_RESOURCES';
    IP_BAD_OPTION:
      Result := 'IP_BAD_OPTION';
    IP_HW_ERROR:
      Result := 'IP_HW_ERROR';
    IP_PACKET_TOO_BIG:
      Result := 'IP_PACKET_TOO_BIG';
    IP_REQ_TIMED_OUT:
      Result := 'IP_REQ_TIMED_OUT';
    IP_BAD_REQ:
      Result := 'IP_BAD_REQ';
    IP_BAD_ROUTE:
      Result := 'IP_BAD_ROUTE';
    IP_TTL_EXPIRED_TRANSIT:
      Result := 'IP_TTL_EXPIRED_TRANSIT';
    IP_TTL_EXPIRED_REASSEM:
      Result := 'IP_TTL_EXPIRED_REASSEM';
    IP_PARAM_PROBLEM:
      Result := 'IP_PARAM_PROBLEM';
    IP_SOURCE_QUENCH:
      Result := 'IP_SOURCE_QUENCH';
    IP_OPTION_TOO_BIG:
      Result := 'IP_OPTION_TOO_BIG';
    IP_BAD_DESTINATION:
      Result := 'IP_BAD_DESTINATION';
    IP_ADDR_DELETED:
      Result := 'IP_ADDR_DELETED';
    IP_SPEC_MTU_CHANGE:
      Result := 'IP_SPEC_MTU_CHANGE';
    IP_MTU_CHANGE:
      Result := 'IP_MTU_CHANGE';
    IP_UNLOAD:
      Result := 'IP_UNLOAD';
    IP_GENERAL_FAILURE:
      Result := 'IP_GENERAL_FAILURE';
  else
    Result := '';
  end;
end;

function inet_addr; external 'WSock32.Dll';

end.
