unit userscript;

var
	ePath, eCond, eCond2: IInterface;

function Initialize: integer;
begin

end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	ePath := ElementByPath(e, 'Conditions');
	
	eCond := ElementByIndex(ePath, 1);
	SetElementEditValues(eCond, 'CTDA - \Run On', 'Package Data');
	SetElementEditValues(eCond, 'CTDA - \Parameter #3', '0');
	
	eCond2 := ElementByIndex(ePath, 2);
	SetElementEditValues(eCond2, 'CTDA - \Run On', 'Package Data');
	SetElementEditValues(eCond2, 'CTDA - \Parameter #3', '0');
	
end;


function Finalize: integer;
begin

end;

end.