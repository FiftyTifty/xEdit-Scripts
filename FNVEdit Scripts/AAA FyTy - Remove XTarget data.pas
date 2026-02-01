unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'REFR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));

	if Assigned(ElementBySignature(e, 'XTRG')) then
		RemoveElement(e, 'XTRG');
	
end;


function Finalize: integer;
begin
	
end;

end.