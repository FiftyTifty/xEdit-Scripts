unit userscript;

function Initialize: integer;
begin
  
	
	
end;


function Process(e: IInterface): integer;
var
	iCounter: integer;
	eProperty: IInterface;
begin
	
  if Signature(e) <> 'OMOD' then
		exit;
	
	for iCounter := 0 to ElementCount(ElementByPath(e, 'DATA - Data\Properties')) - 1 do begin
	
		eProperty := ElementByIndex(ElementByPath(e, 'DATA - Data\Properties'), iCounter);
		
		if GetElementEditValues(eProperty, 'Property') = 'Keywords' then
			if GetElementEditValues(eProperty, 'Function Type') = 'REM' then begin
				AddMessage('Processing: ' + FullPath(e));
				AddMessage(GetElementEditValues(eProperty, 'Value 1 - FormID'));
			end;
	
	end;
	
  
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.