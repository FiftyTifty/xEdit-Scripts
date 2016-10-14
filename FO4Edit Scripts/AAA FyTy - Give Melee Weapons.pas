unit userscript;
var
	arraystrWeapons: array [1..6] of string;

function Initialize: integer;
begin
	
	arraystrWeapons[1] := 'AAA_FyTy_ArmorBalance_Melee_Low [LVLI:08066FF0]';
	arraystrWeapons[2] := 'AAA_FyTy_ArmorBalance_MeleeLowMed [LVLI:08066FF4]';
	arraystrWeapons[3] := 'AAA_FyTy_ArmorBalance_Melee_Med [LVLI:08066FF1]';
	arraystrWeapons[4] := 'AAA_FyTy_ArmorBalance_MeleeAll [LVLI:08066FF3]';
	arraystrWeapons[5] := 'AAA_FyTy_ArmorBalance_MeleeMedHigh [LVLI:08066FF5]';
	arraystrWeapons[6] := 'AAA_FyTy_ArmorBalance_Melee_High [LVLI:08066FF2]';
	
end;

function IsValidRace(e: IInterface; strRace: string): boolean;
var
	bIsValidRace: boolean;
begin
	
	bIsValidRace := true;
	
	if strRace <> 'HumanRace "Human" [RACE:00013746]' then
		if strRace <> 'GhoulRace "Ghoul" [RACE:000EAFB6]' then
			if strRace <> 'SynthGen1Race "Gen 1 Synth" [RACE:000E8D09]' then
				if strRace <> 'SynthGen2Race "Gen 2 Synth" [RACE:0010BD65]' then
					if strRace <> 'HumanChildRace "Human" [RACE:0011D83F]' then
						if strRace <> 'GhoulChildRace "Human" [RACE:0011EB96]' then
							if strRace <> 'SynthGen2RaceValentine "Gen 2 Synth" [RACE:002261A4]' then
								if strRace <> 'SuperMutantRace [RACE:0001A009]' then
									bIsValidRace := false;
	
	Result := bIsValidRace;				
	
end;

function Process(e: IInterface): integer;
var
	eItems, eAddedItem: IInterface;
	iRand: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	if isValidRace(e, GetEditValue(ElementBySignature(e, 'RNAM'))) = false then
		exit;
	
	Randomize;
	
  AddMessage('Processing: ' + FullPath(e));
	
	iRand := Random(100) + 1; //Random will generate a number below 100. We add 1 so we get a number that is 1, 100, or any number between.
	
	eItems := ElementByName(e, 'Items');
	eAddedItem := ElementAssign(eItems, HighInteger, nil, false);
	
	SetElementEditValues(eAddedItem, 'CNTO - Item\Count', 1);
	
	
	if iRand >= 90 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[6]);
		exit;
	end;
	
	if iRand >= 80 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[5]);
		exit;
	end;
	
	if iRand >= 75 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[4]);
		exit;
	end;
	
	if iRand >= 65 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[3]);
		exit;
	end;
	
	if iRand >= 50 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[2]);
		exit;
	end;
	
	if iRand >= 1 then begin
		SetElementEditValues(eAddedItem, 'CNTO - Item\Item', arraystrWeapons[1]);
		exit;
	end;
	
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.