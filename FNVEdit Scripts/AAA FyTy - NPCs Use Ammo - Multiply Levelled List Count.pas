unit userscript;

const
	fMult = 1.5;

function Process(e: IInterface): integer;
var
	eEntries, eEntry: IInterface;
	iCounter, iAmount: integer;
begin

	if Signature(e) <> 'LVLI' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	eEntries := ElementByPath(e, 'Leveled List Entries');
	
	for iCounter := 0 to ElementCount(eEntries) - 2 do begin
		
		eEntry := ElementByIndex(eEntries, iCounter);
		
		if Signature(LinksTo(ElementByPath(eEntry, 'LVLO - Base Data\Reference'))) <> 'AMMO' then
			exit;
	
		iAmount := round((StrToInt(GetElementEditValues(eEntry, 'LVLO - Base Data\Count')) + (iCounter)) * fMult);
		
		SetElementEditValues(eEntry, 'LVLO - Base Data\Count', IntToStr(iAmount));
	
	end;
	

end;

end.