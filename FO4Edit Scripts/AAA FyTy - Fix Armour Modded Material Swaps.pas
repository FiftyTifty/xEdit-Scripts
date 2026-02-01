unit userscript;

function Process(e: IInterface): integer;
var
	eRecord, eProperties, eProperty, ePropertyOverride: IInterface;
	strProperty, strValue: string;
	iCounter: integer;
begin

	if Signature(e) <> 'OMOD' then
		exit;
		
	eRecord := MasterOrSelf(e);
	
	if OverrideCount(eRecord) = 0 then
		exit;
	
	if ElementExists(ElementByPath(eRecord, 'DATA - Data'), 'Properties') = false then
		exit;
		
	if OverrideCount(eRecord) > 1 then
		eRecord := OverrideByIndex(eRecord, OverrideCount(eRecord) - 2);
	
	//AddMessage(GetFileName(e));
	//AddMessage(GetFileName(eRecord));
	
	AddMessage('Processing: ' + FullPath(eRecord));
  AddMessage('Processing: ' + FullPath(e));
	
  eProperties := ElementByPath(eRecord, 'DATA - Data\Properties');
	
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
	
		//AddMessage('Iterating!');
		eProperty := ElementByIndex(eProperties, iCounter);
		
		strProperty := GetElementEditValues(eProperty, 'Property');
		AddMessage(strProperty);
		
		if (
				(strProperty = 'Keywords') or (strProperty = 'Enchantments') or
				(strProperty = 'OverrideProjectile') or (strProperty = 'ImpactDataSet') or 
				(strProperty = 'AttackSound') or (strProperty = 'IdleSound') or (strProperty = 'MaterialSwaps') or
				(strProperty = 'NPCAmmoList') or (strProperty = 'Ammo')
				)	then begin
		
			//AddMessage(GetElementEditValues(eProperty, 'Property'));
			
			strValue := GetElementEditValues(eProperty, 'Value 2 - Int');
			
			//AddMessage(strValue);
			
			ePropertyOverride := ElementByIndex(ElementByPath(e, 'DATA - Data\Properties'), iCounter);
			
			//AddMessage(GetElementEditValues(ePropertyOverride, 'Value2 - Int'));
			SetElementEditValues(ePropertyOverride, 'Value 2 - Int', strValue);
		
		end;
	
	end;

end;

end.