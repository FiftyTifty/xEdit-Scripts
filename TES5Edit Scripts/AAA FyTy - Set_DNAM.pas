unit userscript;

function Process(e: IInterface): integer;
begin
	if Signature(e) <> 'ARMO' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'DNAM - Armor Rating', '300');

end;

end.