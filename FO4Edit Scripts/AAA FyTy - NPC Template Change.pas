unit userscript;

function Initialize: integer;
begin
	
	
	
end;


function Process(e: IInterface): integer;
begin

  AddMessage('Processing: ' + FullPath(e));

end;


function Finalize: integer;
begin
	
	
	
end;

end.