unit userscript;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'LVLI' then
		exit;
		
	if (pos('WithAmmo', GetElementEditValues(e, 'EDID')) > 0) or (pos('Cond', GetElementEditValues(e, 'EDID')) > 0) then
		exit;
	
	SetElementEditValues(e, 'LVLF - Flags\Calculate for each item in count', '1');

end;

end.
