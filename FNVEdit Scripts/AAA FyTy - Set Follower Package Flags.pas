unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'PACK' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'PKDT\General Flags\Allow Swimming', '1');	
	SetElementEditValues(e, 'PKDT\General Flags\Allow Falls', '1');	
	SetElementEditValues(e, 'PKDT\General Flags\Allow Continue During Combat', '1');	


end;


function Finalize: integer;
begin
	
end;

end.