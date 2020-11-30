unit utils;

interface

uses
  generics.collections,
  sysutils;

function PathToNamespace(const aPath: string): string;
function GetDbType(const aType: string): string;

implementation

var
  DbTypes: TDictionary<string,string>;

function PathToNamespace(const aPath: string): string;
var
  charArray : Array[0..0] of Char;
  parts: TArray<string>;
begin
  charArray[0] := '\';
  parts := aPath.Split(charArray);
  result := parts[2] + '.' + parts[4] + '.';
end;

function GetDbType(const aType: string): string;
begin
  if not Assigned(DbTypes) then
  begin
    DbTypes := TDictionary<string,string>.Create;
    DbTypes.Add('Integer','Integer');
    DbTypes.Add('Currency','Numeric(10,4)');
    DbTypes.Add('String','Varchar(255)');
    DbTypes.Add('Boolean','SmallInt');
    DbTypes.Add('DateTime','TIMESTAMP');
  end;

  Result := DbTypes[aType];
end;

end.
