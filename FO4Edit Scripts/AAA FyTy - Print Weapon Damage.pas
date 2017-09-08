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
	eDNAM, eDamage: IInterface;
	strDamageAmount: string;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	eDNAM := ElementBySignature(e, 'DNAM');
	eDamage := ElementByPath(eDNAM, 'Damage - Base');
	
	strDamageAmount := GetEditValue(eDamage);
	//AddMessage(strDamageAmount);
	
	if StrToFloat(strDamageAmount) > 0.0 then
		tstrlistRawWeaponDamage.Add(strDamageAmount);
	

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