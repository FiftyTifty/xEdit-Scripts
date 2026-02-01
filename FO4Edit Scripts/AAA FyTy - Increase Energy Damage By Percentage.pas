unit userscript;
var
	strEnergyDamage: string;
	fPercentIncrease: float;

	
function Initialize(): integer;
begin

	strEnergyDamage := 'dtEnergy [DMGT:00060A81]';
	fPercentIncrease := 1.4;
	
end;


function Process(e: IInterface): integer;
var
	eDamageTypes, eDamageType, eAmount, eType: IInterface;
	strDamage: string;
	iDamage, iCounter: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eDamageTypes := ElementBySignature(e, 'DAMA');
	
	for iCounter := 0 to ElementCount(eDamageTypes) - 1 do begin
		
		eDamageType := ElementByIndex(eDamageTypes, iCounter);
		eType := ElementByName(eDamageType, 'Type');
		eAmount := ElementByName(eDamageType, 'Amount');
		
		strDamage := GetEditValue(eAmount);
		iDamage := StrToInt(strDamage);
		
		if GetEditValue(eType) = strEnergyDamage then
			SetEditValue(eAmount, IntToStr( Round(iDamage * fPercentIncrease) ) );
		
	end;
	
	
end;

end.