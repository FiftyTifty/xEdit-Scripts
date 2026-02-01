unit userscript;
var
	strHealth: string;


function Initialize: integer;
begin
  strHealth := '1200';
end;


function Process(e: IInterface): integer;
begin
	
	if (Signature(e) <> 'NPC_') and (Signature(e) <> 'CREA') then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'DATA - \Health', strHealth);


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.
