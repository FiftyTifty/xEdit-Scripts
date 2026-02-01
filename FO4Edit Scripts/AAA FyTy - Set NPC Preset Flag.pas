unit userscript;

function Initialize: integer;
begin
  
	
	
end;


function Process(e: IInterface): integer;
begin
	
  if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  SetElementEditValues(e, 'ACBS - Configuration\Flags\Is CharGen Face Preset', '0');
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.