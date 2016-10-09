unit userscript;

function Initialize: integer;
begin
end;


function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'INFO' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'RNAM - Prompt') then
		Remove(ElementBySignature(e, 'RNAM'));
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.
