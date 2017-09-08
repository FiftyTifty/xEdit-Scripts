unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	iCounter, fHealthIndex, fArmourIndex: integer;
	fHealth, fArmour: float;
	eProperties, eProperty: IInterface;
	strAV: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eProperties := ElementBySignature(e, 'PRPS');
	
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
		
		eProperty := ElementByIndex(eProperties, iCounter);
		strAV := GetElementEditValues(eProperty, 'Actor Value');
		
		if strAV = 'Health "Health" [AVIF:000002D4]' then
			fHealthIndex := iCounter;
		
		if strAV = 'DamageResist "Damage Resistance" [AVIF:000002E3]' then
			fArmourIndex := iCounter;
	end;
	
	fHealth := StrToFloat(GetElementEditValues(ElementByIndex(eProperties, fHealthIndex), 'Value'));
	fArmour := StrToFloat(GetElementEditValues(ElementByIndex(eProperties, fArmourIndex), 'Value'));
	
	AddMessage('Health = ' + FloatToStr(fHealth));
	AddMessage('Damage Resist = ' + FloatToStr(fArmour));
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.