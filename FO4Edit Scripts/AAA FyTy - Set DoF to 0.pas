unit userscript;

function Initialize: integer;
begin
	
	
	
end;


function Process(e: IInterface): integer;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	SetEditValue(ElementByPath(e, 'DNAM - Depth of Field\Strength'), 0);

end;


function Finalize: integer;
begin
	
	
	
end;

end.