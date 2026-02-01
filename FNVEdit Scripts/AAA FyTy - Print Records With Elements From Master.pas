unit userscript;
const
	strMasterPrefix = ':0E'

function Initialize: integer;
begin
  Result := 0;
end;

function Process(e: IInterface): integer;
var
	iCounter: integer;
begin

  AddMessage('Processing: ' + FullPath(e));

end;

function Finalize: integer;
begin
  Result := 0;
end;

end.