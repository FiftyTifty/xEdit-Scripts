unit userscript;

var
		strCombatArmor, strDCGuardArmor, strDisciplesHeavyArmor, strDisciplesHeavyMetalArmor, strDisciplesArmor, strHeavyTrapperArmor: string; 
		strLeatherArmor, strMarineArmor, strMetalArmor, strOperatorsHeavyArmor, strOperatorsArmor, strPackArmor, strPackHeavyArmor: string;
		strRaiderArmor, strRobotArmor, strSynthArmor, strTrapperArmor: string;
		
		arraystrArmors: array [0..16] of string;
		
		
function Initialize: integer;
var iCounter: integer;
begin

	//We could just type them into the array directly
	//But this makes it much more legible.
	
	AddMessage('Setting up our string array!');
	AddMessage('Length of array is '+IntToStr(Length(arraystrArmors)));
	
	strCombatArmor := 'Combat ';
	arraystrArmors[0] := strCombatArmor;
	
	strDCGuardArmor := 'DC Guard ';
	arraystrArmors[1] := strDCGuardArmor;
	
	strDisciplesHeavyArmor := 'Disciples Spiked ';
	arraystrArmors[2] := strDisciplesHeavyArmor;
	
	strDisciplesHeavyMetalArmor := 'Disciples Metal ';
	arraystrArmors[3] := strDisciplesHeavyMetalArmor;
	
	strDisciplesArmor := 'Disciples ';
	arraystrArmors[4] := strDisciplesArmor;
	
	strLeatherArmor := 'Leather ';
	arraystrArmors[5] := strLeatherArmor;
	
	strMarineArmor := 'Marine ';
	arraystrArmors[6] := strMarineArmor;
	
	strMetalArmor := 'Metal ';
	arraystrArmors[7] := strMetalArmor;
	
	strOperatorsHeavyArmor := 'Operators Heavy ';
	arraystrArmors[8] := strOperatorsHeavyArmor;
	
	strOperatorsArmor := 'Operators ';
	arraystrArmors[9] := strOperatorsArmor;
	
	strPackArmor := 'Pack Stuffed ';
	arraystrArmors[10] := strPackArmor;
	
	strPackHeavyArmor := 'Pack ';
	arraystrArmors[11] := strPackHeavyArmor;
	
	strRaiderArmor := 'Raider ';
	arraystrArmors[12] := strRaiderArmor;
	
	strRobotArmor := 'Robot ';
	arraystrArmors[13] := strRobotArmor;
	
	strSynthArmor := 'Synth ';
	arraystrArmors[14] := strSynthArmor;
	
	strHeavyTrapperArmor := 'Heavy Trapper ';
	arraystrArmors[15] := strHeavyTrapperArmor;
	
	strTrapperArmor := 'Trapper ';
	arraystrArmors[16] := strTrapperArmor;
	
	{
	for iCounter := 0 to Length(arraystrArmors) - 1 do begin
		AddMessage('Print the array at the beginning! - '+ arraystrArmors[iCounter]);
	end;
	}
	
end;


function GetTypeOfArmor(e: IInterface): string;
var
	strTypeOfArmor, strArmorName: string;
	iCounter: integer;
begin
	
	//AddMessage('The Name of the armor is: '+GetEditValue(ElementBySignature(e, 'FULL')));
	
	strTypeOfArmor := 'Not to be processed';
	
	strArmorName := GetEditValue(ElementByPath(e, 'FULL - Name'));
	
	for iCounter := 0 to Length(arraystrArmors) - 1 do begin
	
		//AddMessage(arraystrArmors[iCounter]);
	
		if pos(arraystrArmors[iCounter], strArmorName) = 1 then //if the beginning of strArmorName begins with one of the strings we defined in Initialize
			strTypeOfArmor := arraystrArmors[iCounter]; //We know what type of armour we're looking at (leather, raider, heavy trapper, etc.)
			
		if strTypeOfArmor = arraystrArmors[iCounter] then //Since we know what we're working with
			break; //Exit the "for" loop.
			
	end;
	
	//AddMessage('Got the armor: '+ strTypeOfArmor);
	Result := strTypeOfArmor; //Returns the type of armour we're dealing with; 'Synth ', 'Robot ', 'Raider ', etc.
	
end;


function GetLimbOrChestPiece(e: IInterface): string;
var
	strArmorName: string;
	strResult: string;
begin
	
	//AddMessage('Getting limb or chest piece');
	
	strResult := 'Neither';
	
	strArmorName := GetEditValue(ElementByPath(e, 'FULL - Name'));
	
	if Pos('Left Leg', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Left Arm', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Left Bracer', strArmorName) > 0 then
		strResult := 'Limb';
		
	if Pos('Left Forearm', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Left Shoulder', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Right Leg', strArmorName) > 0 then
		strResult := 'Limb';
		
	if Pos('Right Arm', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Right Bracer', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Right Forearm', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos('Right Shoulder', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos(' Helmet', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos(' Mask', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos(' Helm', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos(' Head', strArmorName) > 0 then
		strResult := 'Limb';
	
	if Pos(' Chest Piece', strArmorName) > 0 then
		strResult := 'Chest';
	
	if Pos(' Chest Armor', strArmorName) > 0 then
		strResult := 'Chest';
	
	if Pos(' Umpire''s Pads', strArmorName) > 0 then
		strResult := 'Chest';
	
	AddMessage(strResult);
	
	Result := strResult;
end;


procedure ChangeDefenceStats(eArmorRating, eResistancesContainer: IInterface;
															bIsChestArmor: boolean;
															strArmorResist, strEnergyResist, strRadiationResist: string);

var
	iNumberOfResistances: integer;
	eCurrentResistance, eAddedResistance: IInterface;
	strCurrentResistanceName: string;
	bEnergyResistExists, bRadiationResistExists: boolean;
	iCounter: integer;
		
begin
	
	AddMessage('Changing stats!');
	
	bEnergyResistExists := false;
	bRadiationResistExists := false;
	
	iNumberOfResistances := ElementCount(eResistancesContainer);
	
	//Begin checking for present resistances. If there's an energy resist, we set bEnergyResistExists to true.
	//Same gig with radiation and bRadiationResistExists.
	
	//We'll use these variables further on in the procedure, to add any if they're missing (booleans will be false).
	
	//This is the first pass. The second pass will add any missing resists and set their values accordingly.
	
	if iNumberOfResistances > 0 then
		for iCounter := 0 to ElementCount(eResistancesContainer) - 1 do begin
			
			eCurrentResistance := ElementByIndex(eResistancesContainer, iCounter);
			strCurrentResistanceName := GetEditValue(ElementByIndex(eCurrentResistance, 0));
			
			if Pos('dtEnergy', strCurrentResistanceName) > 0 then
				if bIsChestArmor then begin //If it's chest armor, don't halve the resist value.
					SetEditValue(ElementByIndex(eCurrentResistance, 1), strEnergyResist);
					if bEnergyResistExists = false then //Since the "if Pos()" statement ran, we know that the energy resist exists.
						bEnergyResistExists := true;
				end;
				
			if Pos('dtEnergy', strCurrentResistanceName) > 0 then
				if (bIsChestArmor = false) then begin //Since it's not chest armor, halve the resist value.
					SetEditValue(ElementByIndex(eCurrentResistance, 1), inttostr(strtoint(strEnergyResist) div 2));
					if bEnergyResistExists = false then
						bEnergyResistExists := true;
				end;
				
			//Do the same checks for radiation resistance.
			if Pos('dtRadiation', strCurrentResistanceName) > 0 then
				if bIsChestArmor then begin
					SetEditValue(ElementByIndex(eCurrentResistance, 1), strRadiationResist);
					if bRadiationResistExists = false then //Since the "if Pos()" statement ran, we know that the radiation resist exists.
						bRadiationResistExists := true;
				end;
			
			if Pos('dtRadiation', strCurrentResistanceName) > 0 then
				if (bIsChestArmor = false) then begin
					SetEditValue(ElementByIndex(eCurrentResistance, 1), inttostr(strtoint(strRadiationResist) div 2));
					if bRadiationResistExists = false then
						bRadiationResistExists := true;
				end;
			
		end;
	
	if bEnergyResistExists = false then begin
		
		eAddedResistance := ElementAssign(eResistancesContainer, HighInteger, nil, false);
		SetEditValue(ElementByIndex(eAddedResistance, 0), 'dtEnergy [DMGT:00060A81]');
		
		if bIsChestArmor = false then
			SetEditValue(ElementByIndex(eAddedResistance, 1), inttostr(strtoint(strEnergyResist div 2)))
		else
			SetEditValue(ElementByIndex(eAddedResistance, 1), strEnergyResist);
		
		bEnergyResistExists := true;
	end;
	
	if bRadiationResistExists = false then begin
		
		eAddedResistance := ElementAssign(eResistancesContainer, HighInteger, nil, false);
		SetEditValue(ElementByIndex(eAddedResistance, 0), 'ddtRadiationExposure [DMGT:00060A85]');
		
		if bIsChestArmor = false then
			SetEditValue(ElementByIndex(eAddedResistance, 1), inttostr(strtoint(strRadiationResist div 2)))
		else
			SetEditValue(ElementByIndex(eAddedResistance, 1), strRadiationResist);
		
		bEnergyResistExists := true;
	end;
				
	
	if bIsChestArmor then
		SetEditValue(eArmorRating, strArmorResist) //If it's a piece of chest armor, we give it an un-molested armor rating.
	else
		SetEditValue(eArmorRating, inttostr(strtoint(strArmorResist) div 2)); //It's not chest armour, so halve it.
	
end;


procedure GetTypeOfArmorThenChangeDefenceStats(e: IInterface);
var
	bIsChestPiece: boolean;
	eArmorRating, eResistancesContainer: IInterface;
begin

	AddMessage('Getting the type of armor & changing the stats!');
	
	if ElementExists(e, 'DAMA - Resistances') = false then
		Add(e, 'DAMA - Resistances', false);
		
	eResistancesContainer := ElementBySignature(e, 'DAMA');
	
	eArmorRating := ElementByPath(e, 'FNAM - \Armor Rating');
	
	if GetLimbOrChestPiece(e) = 'Neither' then
		exit;
	
	if GetLimbOrChestPiece(e) = 'Chest' then
		bIsChestPiece := true
	else
		bIsChestPiece := false;
		
	if GetTypeOfArmor(e) = 'Not to be processed' then
		exit;
	
	
	if GetTypeOfArmor(e) = strCombatArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '6', '3');
	
	if GetTypeOfArmor(e) = strDCGuardArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '4', '2');
	
	if GetTypeOfArmor(e) = strDisciplesHeavyArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '10', '10', '6');
		
	if GetTypeOfArmor(e) = strDisciplesHeavyMetalArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '4', '10');
	
	if GetTypeOfArmor(e) = strDisciplesArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '8', '12', '4');
	
	if GetTypeOfArmor(e) = strLeatherArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '6', '12', '4');
	
	if GetTypeOfArmor(e) = strMarineArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '5', '11');
	
	if GetTypeOfArmor(e) = strMetalArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '2', '8');
	
	if GetTypeOfArmor(e) = strOperatorsHeavyArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '4', '6');
	
	if GetTypeOfArmor(e) = strOperatorsArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '6', '10', '6');
	
	if GetTypeOfArmor(e) = strPackArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '2', '16', '6');
		
	if GetTypeOfArmor(e) = strPackHeavyArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '8', '10', '2');
	
	if GetTypeOfArmor(e) = strRaiderArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '10', '6', '8');
	
	if GetTypeOfArmor(e) = strRobotArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '4', '12', '12');
	
	if GetTypeOfArmor(e) = strSynthArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '2', '16', '8');
	
	if GetTypeOfArmor(e) = strHeavyTrapperArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '2', '6');
	
	if GetTypeOfArmor(e) = strTrapperArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '6', '10', '6');
	
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	GetTypeOfArmorThenChangeDefenceStats(e);
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.