unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'CREA' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'AIDT\Assistance', 'Helps Allies');
	SetElementEditValues(e, 'AIDT\Aggression', 'Unaggressive');


end;


function Finalize: integer;
begin
	
end;

end.