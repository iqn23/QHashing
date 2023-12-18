unit uQHMACSHA;

{$mode ObjFPC}{$H+}

interface

uses
  //Classes,
  SysUtils,
  fpsha256,
  basenenc
  ;

function QCreateHMACSHA256(AKey, AData: AnsiString): AnsiString;

implementation

function QCreateHMACSHA256(AKey, AData: AnsiString): AnsiString;
var
  aDigest: TSHA256Digest;
  S, K : TBytes;
begin
  S := TEncoding.UTF8.GetAnsiBytes(AData);
  K := TEncoding.UTF8.GetAnsiBytes(AKey);
  TSHA256.HMAC(PByte(K),Length(K), PByte(S), Length(S), aDigest);
  Result := Base64URL.Encode(aDigest, True);
  Result := StringReplace(Result, '_', '/', [rfReplaceAll]);      //look basenenc line 40
  Result := StringReplace(Result, '-', '+', [rfReplaceAll]);      //look basenenc line 40
end;

end.

