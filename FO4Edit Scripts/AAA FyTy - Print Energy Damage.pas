unit userscript;
var
	tstrlistRawWeaponDamage: TStringList;


function Initialize: integer;
begin
  tstrlistRawWeaponDamage := TStringList.Create;
	tstrlistRawWeaponDamage.Sorted := true;
end;


function Process(e: IInterface): integer;
var
	eDAMA, eDamageType: IInterface;
	strEnergyDamage: string;
	iCounter: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	//strEnergyDamage := GetElementEditValues(e, 'DAMA - Damage Types\Damage Type #0\Amount');
	//AddMessage(strDamageAmount);
	
	eDAMA := ElementBySignature(e, 'DAMA');
	
	for iCounter := 0 to ElementCount(eDAMA) - 1 do begin
		eDamageType := ElementByIndex(eDAMA, iCounter);
		
		if GetElementEditValues(eDamageType, 'Type') = 'dtEnergy [DMGT:00060A81]' then
			strEnergyDamage := GetElementEditValues(eDamageType, 'Amount');
	end;
	
	if strEnergyDamage = '' then begin
		AddMessage(strEnergyDamage);
		AddMessage('Quitting');
		exit;
	end;
	
	AddMessage(strEnergyDamage);
	
	if StrToFloat(strEnergyDamage) > 0.0 then
		tstrlistRawWeaponDamage.Add(strEnergyDamage);
	

end;


function Finalize: integer;
var
	iCounter: integer;
begin
	
	for iCounter := 0 to tstrlistRawWeaponDamage.Count - 1 do begin
		AddMessage(tstrlistRawWeaponDamage[iCounter]);
	end;
	
  tstrlistRawWeaponDamage.Free();
	
end;

end.