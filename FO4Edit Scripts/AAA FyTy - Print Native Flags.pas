unit userscript;

function Initialize: integer;
begin
  Result := 0;
end;

function Process(e: IInterface): integer;
var
	strFlags: string;
begin
  if Signature(e) <> 'NPC_' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	strFlags := GetEditValue(ElementByPath(e, 'ACBS - Configuration\Flags'));
  SetLength(strFlags, 30);
	
  AddMessage(strFlags);
		
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.