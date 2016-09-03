unit userscript;

var
  ePath: IInterface;
	eEDID, aString, PerkNumber: string;
	i, iPerkNumber: integer;
	
Function GetPerkNumberAsString(aString: string): string;
begin

	for i := 0 to Pos('0', aString) - 2 do begin
		aString := Delete(aString, 1, 1);
	end;
	
	iPerkNumber := StrToInt(aString);
	AddMessage('Done procedure, aString is '+aString);
	Result := aString;
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'PERK' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
  ePath := ElementByPath(e, 'DATA - Data\Level');
	eEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	PerkNumber := GetPerkNumberAsString(eEDID);
	
	AddMessage('EDID is '+eEDID);
	AddMessage('PerkNumber is '+PerkNumber);
	
	if PerkNumber = '01' then
		SetEditValue(ePath, PerkNumber);
		
	if PerkNumber = '02' then
		SetEditValue(ePath, PerkNumber);
		
	if PerkNumber = '03' then
		SetEditValue(ePath, PerkNumber);
	
	if PerkNumber = '04' then
		SetEditValue(ePath, PerkNumber);
		
	if PerkNumber = '05' then
		SetEditValue(ePath, PerkNumber);
	
	if PerkNumber = '06' then
		SetEditValue(ePath, PerkNumber);
	
	
end;

end.
