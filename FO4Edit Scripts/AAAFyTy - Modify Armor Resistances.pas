unit userscript;

var
		strCombatArmor, strDCGuardArmor, strDesciplesArmor, strHeavyTrapperArmor, strLeatherArmor: string; 
		strMarineArmor, strMetalArmor, strOperatorsArmor, strPackArmor, strRaiderArmor, strRobotArmor: string;
		strSynthArmor, strTrapperArmor: string;
		
		arraystrArmors: array [0...16] of string;
		
		
function Initialize: integer;
begin

	//We could just type them into the array directly
	//But this makes it much more legible.
	
	AddMessage('Setting up our string array!');
	
	strCombatArmor := 'Combat ';
	arraystrArmors[0] := strCombatArmor;
	
	strDCGuardArmor := 'DC Guard ';
	arraystrArmors[1] := strDCGuardArmor;
	
	strDesciplesArmor := 'Desciples Spiked ';
	arraystrArmors[2] := strDesciplesHeavyArmor;
	
	strDesciplesArmor := 'Desciples Metal ';
	arraystrArmors[3] := strDesciplesHeavyMetalArmor;
	
	strDesciplesArmor := 'Desciples ';
	arraystrArmors[4] := strDesciplesArmor;
	
	strLeatherArmor := 'Leather ';
	arraystrArmors[5] := strLeatherArmor;
	
	strMarineArmor := 'Marine ';
	arraystrArmors[6] := strMarineArmor;
	
	strMetalArmor := 'Metal ';
	arraystrArmors[7] := strMetalArmor;
	
	strOperatorsArmor := 'Operators Heavy ';
	arraystrArmors[8] := strOperatorsHeavyArmor;
	
	strOperatorsArmor := 'Operators ';
	arraystrArmors[9] := strOperatorsArmor;
	
	strPackArmor := 'Pack Stuffed ';
	arraystrArmors[10] := strPackArmor;
	
	strPackArmor := 'Pack ';
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
	
end;


function GetTypeOfArmor(e: IInterface): string;
var
	strTypeOfArmor, strArmorName: string = 'Not to be processed';
begin

	strArmorName := GetEditValue(ElementByPath(e, 'FULL - Name'));
	
	for i := 0 to Length(arraystrArmors) - 1 do begin
	
		if pos(arraystrArmors[i], strArmorName) = 1 then //if the beginning of strArmorName begins with one of the strings we defined in Initialize
			strTypeOfArmor := arraystrArmors[i]; //We know what type of armour we're looking at (leather, raider, heavy trapper, etc.)
			
		if strTypeOfArmor = arraystrArmors[i] then //Since we know what we're working with
			break; //Exit the "for" loop.
			
	end;
	
	Result := strTypeOfArmor; //Returns the type of armour we're dealing with; 'Synth ', 'Robot ', 'Raider ', etc.
	
end;


function GetLimbOrChestPiece(e: IInterface): string;
var
	strArmorName: string = 'Neither';
begin
	
	strArmorName := GetEditValue(ElementByPath(e, 'FULL - Name'));
	
	if Pos('Left Leg', strArmorName) > 0 then
		Result := 'Limb';
	
	if Pos('Right Leg', strArmorName) > 0 then
		Result := 'Limb';
	
	if Pos('Left Arm', strArmorName) > 0 then
		Result := 'Limb';
	
	if Pos('Right Arm', strArmorName) > 0 then
		Result := 'Limb';
	
	if Pos(' Helmet', strArmorName) > 0 then
		Result := 'Limb';
	
	if Pos(' Chest Piece', strArmorName) > 0 then
		Result := 'Chest';
		
end;


procedure ChangeDefenceStats(eArmorRating, eResistancesContainer: IInterface;
															bIsChestArmor: boolean;
															strArmorResist, strEnergyResist, strRadiationResist: string = '1');

var
	iNumberOfResistances: integer;
	eCurrentResistance: IInterface;
	strCurrentResistanceName: string;
	bEnergyResistExists, bRadiationResistExists: boolean = false;
		
begin
	
	iNumberOfResistances := ElementCount(eResistancesContainer);
	
	//Begin checking for present resistances. If there's an energy resist, we set bEnergyResistExists to true.
	//Same gig with radiation and bRadiationResistExists.
	
	//We'll use these variables further on in the procedure, to add any if they're missing (booleans will be false).
	
	if iNumberOfResistances > 0 then
		for iCounter := 0 to ElementCount(eResistancesContainer) - 1 do begin
			
			eCurrentResistance := eResistancesContainer[iCounter];
			strCurrentResistanceName := GetEditValues(eCurrentResistance[0]);
			
			if Pos('dtEnergy', strCurrentResistanceName) > 0 then
				if bIsChestArmor then begin //If it's chest armor, don't halve the resist value.
					SetEditValue(eCurrentResistance[1], strEnergyResist);
					if bEnergyResistExists = false then //Since the "if Pos()" statement ran, we know that the energy resist exists.
						bEnergyResistExists := true;
				end;
				
			if Pos('dtEnergy', strCurrentResistanceName) > 0 then
				if (bIsChestArmor = false) then begin //Since it's not chest armor, halve the resist value.
					SetEditValue(eCurrentResistance[1], inttostr(strtoint(strEnergyResist) div 2));
					if bEnergyResistExists = false then
						bEnergyResistExists := true;
				end;
				
			//Do the same checks for radiation resistance.
			if Pos('dtRadiation', strCurrentResistanceName) > 0 then
				if bIsChestArmor then begin
					SetEditValue(eCurrentResistance[1], strRadiationResist);
					if bRadiationResistExists = false then //Since the "if Pos()" statement ran, we know that the radiation resist exists.
						bRadiationResistExists := true;
				end;
			
			if Pos('dtRadiation', strCurrentResistanceName) > 0 then
				if (bIsChestArmor = false) then begin
					SetEditValue(eCurrentResistance[1], inttostr(strtoint(strRadiationResist) div 2));
					if bRadiationResistExists = false then
						bRadiationResistExists := true;
				end;
			
		end;
				
	
	if bIsChestArmor then
		SetEditValue(eArmorRating, strArmorResist); //If it's a piece of chest armor, we give it an un-molested armor rating.
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
	
	eArmorRating := ElementByPath(e, 'FNAM - \Armor Rating');
	eResistancesContainer := ElementBySignature(e, 'DAMA');
	
	if GetLimbOrChestPiece(e) = 'Neither' then
		exit;
	
	if GetLimbOrChestPiece(e) = 'Chest' then
		bIsChestPiece := true;
	else
		bIsChestPiece := false;
		
	if GetTypeOfArmor(e) = 'Not to be processed' then
		exit;
	
	if GetTypeOfArmor(e) = strCombatArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '6', '3');
	
	if GetTypeOfArmor(e) = strDCGuardArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '4', '2');
	
	if GetTypeOfArmor(e) = strDesciplesHeavyArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '10', '10', '6');
		
	if GetTypeOfArmor(e) = strDesciplesHeavyMetalArmor then
		ChangeDefenceStats(eArmorRating, eResistancesContainer, bIsChestPiece, '12', '4', '10');
	
	if GetTypeOfArmor(e) = strDesciplesArmor then
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