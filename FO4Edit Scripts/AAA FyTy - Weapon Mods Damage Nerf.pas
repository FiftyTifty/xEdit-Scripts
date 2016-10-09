unit userscript;
var
	fileDestination: IInterface;
	bCopyToFile: boolean;
	fPercentageReduction: float;

function Initialize: integer;
begin
	fileDestination := FileByIndex(9);
	bCopyToFile := true;
	fPercentageReduction := 60.0;
end;


function Process(e: IInterface): integer;
var
	eCopiedRecord, eProperties, eDamageMod, eDamageEnergyMod: IInterface;
	iCounter, iDamageModIndex, iDamageEnergyModIndex: integer;
	fDamageAddMultValue, fDamage, fDamageEnergy: float;
	strEDID, strFinalDamageMult: string;
	bHasDamageMod, bHasDamageEnergyMod: boolean;
begin
	
	AddMessage('========Checking if we should exit the script========');
	// Huge ass "Do we exit the script?" block
	if Signature(e) <> 'OMOD' then
		exit;
	
	if ElementExists(e, 'FULL') = false then
		exit;
	
	strEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	
	if Pos('modcol_', strEDID) = 1 then
		exit;
	
	if Pos('_TwoShot', strEDID) > 0 then
		exit;
	
	if GetEditValue(ElementByPath(e, 'Data - DATA\Form Type')) <> 'Weapon' then
		exit;
	
	eProperties := ElementByPath(e, 'DATA - Data\Properties');
	
	bHasDamageMod := false; // Our wee failsafe
	bHasDamageEnergyMod := false;
	
	AddMessage('Processing: ' + FullPath(e));
	AddMessage('========Beginning loop check========');
	
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
		
		
		if GetElementEditValues(ElementByIndex(eProperties, iCounter), 'Property') = 'AttackDamage' then begin
			AddMessage('Has attack damage!');
			
			eDamageMod := ElementByIndex(eProperties, iCounter);
			
			if GetElementEditValues(eDamageMod, 'Value Type') = 'Float' then begin // Make sure we're touching floats!
								
				fDamage := StrToFloat(GetElementEditValues(eDamageMod, 'Value 1 - Float'));
				
				AddMessage('AttackDamage is: '+FloatToStr(fDamage));
				
				if GetElementEditValues(eDamageMod, 'Function Type') = 'MUL+ADD' then
					if fDamage > 0.000000 then begin
						bHasDamageMod := true;
						iDamageModIndex := iCounter; // Might as well take note of where our damage doohickey is
					end;
					
			end;
			
		end;
		
		
		if GetElementEditValues(ElementByIndex(eProperties, iCounter), 'Property') = 'DamageTypeValues' then
			if GetElementEditValues(ElementByIndex(eProperties, iCounter), 'Value 1 - FormID') = 'dtEnergy [DMGT:00060A81]' then
				begin
				
					AddMessage('Has attack damage!');
					
					eDamageEnergyMod := ElementByIndex(eProperties, iCounter);
					
					if GetElementEditValues(eDamageMod, 'Value Type') = 'Float' then begin // Make sure we're touching floats!
					
						fDamageEnergy := StrToFloat(GetElementEditValues(eDamageEnergyMod, 'Value 2 - Float'));
						
						AddMessage('AttackDamage is: '+FloatToStr(fDamageEnergy));
						
						if GetElementEditValues(eDamageEnergyMod, 'Function Type') = 'REM' then
							if fDamageEnergy > 0.000000 then begin
								bHasDamageEnergyMod := true;
								iDamageEnergyModIndex := iCounter; // Might as well take note of where our damage doohickey is
							end;
							
					end;
			
				end;
		
	end;
	
	
	if bHasDamageMod = false then
		if bHasDamageEnergyMod = false then
			exit;
	// End of this monster
	AddMessage('========Done checking!========');
	// Fucking finally
	
	if bCopyToFile then
		eCopiedRecord := wbCopyElementToFile(e, fileDestination, false, true)
	else
		eCopiedRecord := e;
	
	
	if bHasDamageMod then begin
	
		eProperties := ElementByPath(eCopiedRecord, 'DATA - Data\Properties');
		eDamageMod := ElementByIndex(eProperties, iDamageModIndex);
		AddMessage('The property we will change is currently: ' + GetEditValue(ElementByPath(eDamageMod, 'Property')) );
		
		// Turn fDamage into a flat percentage, reduce it by (default) 70%, and then turn back into a decimal multiplier
		fDamageAddMultValue := ( ( (100.0 * fDamage) / fPercentageReduction) / 10); 
		
		strFinalDamageMult := FormatFloat('0.00', fDamageAddMultValue);
		SetElementEditValues(eDamageMod, 'Value 1 - Float', strFinalDamageMult);
		
	end;
	
	
	if bHasDamageEnergyMod then begin
	
		eProperties := ElementByPath(eCopiedRecord, 'DATA - Data\Properties');
		eDamageEnergyMod := ElementByIndex(eProperties, iDamageEnergyModIndex);
		AddMessage('The property we will change is currently: ' + GetEditValue(ElementByPath(eDamageMod, 'Property')) );
		
		// Turn fDamageEnergy into a flat percentage, reduce it by (default) 70%, and then turn back into a decimal multiplier
		fDamageAddMultValue := ( ( (100.0 * fDamageEnergy) / fPercentageReduction) / 10); 
		
		strFinalDamageMult := FormatFloat('0.00', fDamageAddMultValue);
		SetElementEditValues(eDamageEnergyMod, 'Value 2 - Float', strFinalDamageMult);
		
	end;
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.