unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eToFix: IInterface;
	
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eToFix := ElementByPath(e, 'Package Data\Data Input Values');
	eToFix := ElementByIndex(eToFix, 0);
	eToFix := ElementByPath(eToFix, 'PLDT - Location');
	
	SetElementEditValues(eToFix, 'Type', 'Near package start location');

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.