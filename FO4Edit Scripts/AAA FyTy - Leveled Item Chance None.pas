unit userscript;
const
	eChancePath = 'LVLO - Base Data\Chance None';
	strChance = '50';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eEntries, eEntry: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'LVLI' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eEntries := ElementByPath(e, 'Leveled List Entries');
	
	for iCounter := 0 to ElementCount(eEntries) - 1 do begin
		
		eEntry := ElementByIndex(eEntries, iCounter);
		SetElementEditValues(eEntry, eChancePath, strChance);
		
	end;

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.