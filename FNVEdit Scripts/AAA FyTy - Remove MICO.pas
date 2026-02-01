unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'ARMO' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	RemoveElement(e, 'MICO');


end;


function Finalize: integer;
begin
	
end;

end.