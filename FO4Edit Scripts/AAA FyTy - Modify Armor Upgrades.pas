unit userscript;
interface
implementation

{$REGION}
var
	strLevel0, strLevel0B, strLevel1, strLevel1B, strLevel2, strLevel2B: string;
	strLevel3, strLevel3B, strLevel4, strLevel4B: string;
	
	strEDIDMarine, strEDIDTrapper, strEDIDDisciples, strEDIDOperators, strEDIDPack: string;
	strEDIDCombat, strEDIDLeather, strEDIDMetal, strEDIDRaider, strEDIDSynth: string;
	
	arraystrArmorTypes: array [0..9] of string;
	
	arraystrLevelA, arraystrLevelB: array [0..4] of string;
	
	strLight, strMedium, strHeavy: string;
{$ENDREGION}


function Initialize: integer;
begin
	
	//We check the EDID with the two sections below.
	//Check these second!
	strLevel0 := '_Material_0';
	strLevel1 := '_Material_1';
	strLevel2 := '_Material_2';
	strLevel3 := '_Material_3';
	strLevel4 := '_Material_4';
	
	arraystrLevelA[0] := strLevel0;
	arraystrLevelA[1] := strLevel1;
	arraystrLevelA[2] := strLevel2;
	arraystrLevelA[3] := strLevel3;
	arraystrLevelA[4] := strLevel4;
	
	//Check these first! As the below strings are literally the same as above, but with
	//a B at the end of it. If we do a Pos() search with the above first,
	//even if it's a "B" material, it will return true.
	//SO DO THESE ONES FIRST!
	strLevel0B := '_Material_0B';
	strLevel1B := '_Material_1B';
	strLevel2B := '_Material_2B';
	strLevel3B := '_Material_3B';
	strLevel4B := '_Material_4B';
	
	arraystrLevelB[0] := strLevel0B;
	arraystrLevelB[1] := strLevel1B;
	arraystrLevelB[2] := strLevel2B;
	arraystrLevelB[3] := strLevel3B;
	arraystrLevelB[4] := strLevel4B;
	
	//We check these against the record's "FULL - Name"
	//As it's easier (and safer!) to check against.
	
	strLight := 'Light Armor';
	strMedium := 'Medium Armor';
	strHeavy := 'Heavy Armor';
	
	
	//Now we set up our array of the various "types" of armour mods.
	{$region}
	strEDIDMarine := '_Marine_';
	arraystrArmorTypes[0] := strEDIDMarine;
	
	strEDIDTrapper := '_Trapper_';
	arraystrArmorTypes[1] := strEDIDTrapper;
	
	strEDIDDisciples := '_Disciples_';
	arraystrArmorTypes[2] := strEDIDDisciples;
	
	strEDIDOperators := '_Operators_';
	arraystrArmorTypes[3] := strEDIDOperators;
	
	strEDIDPack := '_Pack_';
	arraystrArmorTypes[4] := strEDIDPack;
	
	strEDIDCombat := '_Combat_';
	arraystrArmorTypes[5] := strEDIDCombat;
	
	strEDIDLeather := '_Leather_';
	arraystrArmorTypes[6] := strEDIDLeather;
	
	strEDIDMetal := '_Metal_';
	arraystrArmorTypes[7] := strEDIDMetal;
	
	strEDIDRaider := '_RaiderMod_';
	arraystrArmorTypes[8] := strEDIDRaider;
	
	strEDIDSynth := '_Synth_';
	arraystrArmorTypes[9] := strEDIDSynth;
	{$endregion}
	
end;

procedure ProcessResistance(eResist: IInterface; strValue: string;
														bIsUpgrade, bIsChest: boolean);
begin

	AddMessage('Processing Resistances!');
	AddMessage(Name(eResist));

	{$region}
	if bIsUpgrade then begin

		if bIsChest = false then
			strValue := IntToStr(StrToInt(strValue) div 3);
		
		if strValue = 0 then
			strValue := 1;
		
	end
	
	else begin
		
		if bIsChest = false then
			strValue := IntToStr(StrToInt(strValue) div 2);
		
		if strValue < 3 then
			strValue := 3;

	end;
  {$endregion}
	
	SetEditValue(eResist, strValue);
	
end;

procedure CompareAndProcessUpgrades(bIsChest: boolean;
																		strTypeOfArmor: string;
																		iUpgradeLevel: integer;
																		eDamageResist, eEnergyResist, eRadiationResist: IInterface);
begin
	
	
	AddMessage('Comparing upgrades!');
	
	if strTypeOfArmor = strEDIDLeather then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDRaider then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDMetal then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDCombat then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDPack then begin
		ProcessResistance(eDamageResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDOperators then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDDisciples then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDTrapper then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDMarine then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDSynth then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
end;


procedure ProcessArmourTypes(bIsChest: boolean;
														 strTypeOfArmor: string;
														 iUpgradeLevel: integer;
														 eDamageResist, eEnergyResist, eRadiationResist: IInterface);
begin

	AddMessage('Processing armour types!');

	if strTypeOfArmor = strEDIDLeather then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(4 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDRaider then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDMetal then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDCombat then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDPack then begin
		ProcessResistance(eDamageResist, inttostr(1 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDOperators then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDDisciples then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDTrapper then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eRadiationResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDMarine then begin
		ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eDamageResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
	end;
	
	if strTypeOfArmor = strEDIDSynth then begin
		ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eEnergyResist) = 'dtEnergy [DMGT:00060A81]' then
			ProcessResistance(eEnergyResist, inttostr(3 * iUpgradeLevel), true, bIsChest);
		
		if GetEditValue(eRadiationResist) = 'dtRadiationExposure [DmGT:00060A85' then
			ProcessResistance(eDamageResist, inttostr(2 * iUpgradeLevel), true, bIsChest);
	end;
	
	AddMessage(strTypeOfArmor);
	
end;


function GetTypeOfArmour(strEDID: string): string;
var
	strTypeOfArmor: string;
	iCounter: integer;
begin

	//Set the default value, which we'll check against. If it = Invalid, exit.
	strTypeOfArmor := 'Invalid';
	//Get the type of armour (e.g, Synth, Raider, Metal, Combat, etc)
	for iCounter := 0 to Length(arraystrArmorTypes) - 1 do begin
		
		AddMessage(arraystrArmorTypes[iCounter]);
		
		if Pos(arraystrArmorTypes[iCounter], strEDID) > 0 then
			strTypeOfArmor := arraystrArmorTypes[iCounter];
		
		if strTypeOfArmor = arraystrArmorTypes[iCounter] then
			Break;
	end;
	
	Result := strTypeOfArmor;

end;


function Process(e: IInterface): integer;
var
	eProperties, eDamageResist, eEnergyResist, eRadiationResist: IInterface;
	iCounter, iUpgradeLevel: integer;
	bIsUpgrade, bIsChest: boolean;
	strName, strEDID, strTypeOfArmor: string;
begin

	if Signature(e) <> 'OMOD' then
		exit;
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	
	eProperties := ElementByPath(e, 'DATA - Data\Properties');
	strName := GetEditValue(ElementBySignature(e, 'FULL'));
	strEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	
	//Get our Damage, Energy & Radiation resist elements
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
	
		if 'Rating' = GetEditValue(ElementByPath(ElementByIndex(eProperties, iCounter), 'Property')) then
			eDamageResist := ElementByPath(ElementByIndex(eProperties, iCounter), 'Value 1 - Int');
		
		if 'DanageTypeValue' = GetEditValue(ElementByPath(ElementByIndex(eProperties, iCounter), 'Property')) then
			if 'dtEnergy [DMGT:00060A81]' = GetEditValue(ElementByPath(ElementByIndex(eProperties, iCounter), 'Value 1 - FormID')) then
				eEnergyResist := ElementByPath(ElementByIndex(eProperties, iCounter), 'Value 2 - Float');
		
		if 'DanageTypeValue' = GetEditValue(ElementByPath(ElementByIndex(eProperties, iCounter), 'Property')) then
			if 'dtRadiationExposure [DMGT:00060A85]' = GetEditValue(ElementByPath(ElementByIndex(eProperties, iCounter), 'Value 1 - FormID')) then
				eRadiationResist := ElementByPath(ElementByIndex(eProperties, iCounter), 'Value 2 - Float');
		
	end;
	
	
	//Check if we're modifying light/medium/heavy armor or an upgrade mod
	bIsUpgrade := true;
	
	if strName = strLight then
		bIsUpgrade := false;
	
	if strName = strMedium then
		bIsUpgrade := false;
	
	if strName = strHeavy then
		bIsUpgrade := false;
	//End
	
	
	//Check to see which upgrade level we're looking at (_4 is max, _0 is default)
	if bIsUpgrade then begin
		
		AddMessage('Is an upgrade!');
		
		iUpgradeLevel := 0; //Set it to default 0 as a failsafe
		
		for iCounter := 0 to Length(arrayStrLevelB) - 1 do begin
		
			if Pos(arrayStrLevelB[iCounter], strEDID) > 0 then //If it's an upgrade variant
				iUpgradeLevel := iCounter; //We get the level
		end;
		
		if iUpgradeLevel = 0 then //If it's not an upgrade variant, we'll check against the normal upgrade levels.
			for iCounter := 0 to Length(arrayStrLevelA) - 1 do begin
			
				if Pos(arrayStrLevelA[iCounter], strEDID) > 0 then
					iUpgradeLevel := iCounter;
			end;
	
		Inc(iUpgradeLevel); //Increase it by one, as we'll be multiplying with this value.
	end;
	
	
	//Are we modifying a chest piece?
	if Pos('_Torso_', strEDID) > 0 then
		bIsChest := true;
	
	
	strTypeOfArmor := GetTypeOfArmour(strEDID);
	
	if bIsUpgrade then
		CompareAndProcessUpgrades(bIsChest, strTypeOfArmor, iUpgradeLevel, eDamageResist, eEnergyResist, eRadiationResist)
		
	else if strName = strLight then
		ProcessArmourTypes(bIsChest, strTypeOfArmor, 1, eDamageResist, eEnergyResist, eRadiationResist)
		
	else if strName = strMedium then
		ProcessArmourTypes(bIsChest, strTypeOfArmor, 2, eDamageResist, eEnergyResist, eRadiationResist)
		
	else if strName = strHeavy then
		ProcessArmourTypes(bIsChest, strTypeOfArmor, 3, eDamageResist, eEnergyResist, eRadiationResist);

end;


function Finalize: integer;
begin
	

	
end;

end.