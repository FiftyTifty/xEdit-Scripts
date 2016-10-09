unit userscript;
var
	fValue: float;

function Initialize: integer;
begin
	fValue := 1.0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'GMST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'Data - Value\Float', FloatToStr(fValue));

end;


function Finalize: integer;
begin
	
	
	
end;

end.
