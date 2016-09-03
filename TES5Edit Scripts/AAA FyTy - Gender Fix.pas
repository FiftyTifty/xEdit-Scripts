unit userscript;

var
	HeadPath, eHeadPart: IInterface;
	HeadPartStr, GenderStr, FemaleGenderStr, FlagsStr: string;
	bDoChange: boolean;
	i, ii, iii: integer;
	
	//Copy-Paste job below
	RandNumber, RandNumber2, RandSubNumber, RandSubNumberMale, GenderFlag, IsTemplateTraitsFlag: integer;
	TemplateTraitsString, GenderString: string;
	RaceIsDunmer, RaceIsOrc: boolean;
	VoiceType, FlagPath: IInterface;
	
function Initialize: integer;
begin
	GenderStr := 'Male';
	FemaleGenderStr := 'Female';
end;

procedure FemaleVoices(e: IInterface);
begin

	if RandNumber = 1 then
		if RaceIsDunmer = True then
			if RandSubNumber = 1 then
				SetEditValue(VoiceType, 'DLC2FemaleDarkElfCommoner [VTYP:040247E5]');
		
	if RandNumber = 1 then
		if RaceIsDunmer = True then
			if RandSubNumber = 2 then
				SetEditValue(VoiceType, 'FemaleDarkElf [VTYP:00013AF3]');
		
	if RandNumber = 1 then
		if RaceIsOrc = True then
		SetEditValue(VoiceType, 'FemaleOrc [VTYP:00013AEB]');
		
	if RandNumber = 1 then
		if RaceIsDunmer = False then
			if RaceIsOrc = False then
				SetEditValue(VoiceType, 'FemaleCommoner [VTYP:00013ADE]');
	
	if RandNumber = 2 then 
		SetEditValue(VoiceType, 'FemaleCommander [VTYP:00013AE3]');
	
	if RandNumber = 3 then
		SetEditValue(VoiceType, 'FemaleCondescending [VTYP:00013AE4]');
	
	if RandNumber = 4 then
		SetEditValue(VoiceType, 'FemaleCoward [VTYP:00013AE5]');
	
	if RandNumber = 5 then
		SetEditValue(VoiceType, 'FemaleElfHaughty [VTYP:00013AF1]');
	
	if RandNumber = 6 then
		SetEditValue(VoiceType, 'FemaleEvenToned [VTYP:00013ADD]');
	
	if RandNumber = 7 then
		SetEditValue(VoiceType, 'FemaleShrill [VTYP:00013BC3]');
	
	if RandNumber = 8 then
		SetEditValue(VoiceType, 'FemaleSultry [VTYP:00013AE0]');
	
	if RandNumber = 9 then
		SetEditValue(VoiceType, 'FemaleYoungEager [VTYP:00013ADC]');
end;

procedure MaleVoices(e: IInterface);
begin

	if (RandNumber2 = 1) and (RaceIsDunmer = True) and (RandSubNumberMale = 1) then
		SetEditValue(VoiceType, 'DLC2MaleDarkElfCommoner [VTYP:040247E4]');
		
	if (RandNumber2 = 1) and (RaceIsDunmer = True) and (RandSubNumberMale = 2) then
		SetEditValue(VoiceType, 'DLC2MaleDarkElfCynical [VTYP:04018469]');
		
	if (RandNumber2 = 1) and (RaceIsDunmer = True) and (RandSubNumberMale = 3) then
		SetEditValue(VoiceType, 'DLC2MaleDarkElfCommoner [VTYP:040247E4]');
		
	if (RandNumber2 = 1) and (RaceIsDunmer = True) and (RandSubNumberMale = 4) then
		SetEditValue(VoiceType, 'MaleDarkElf [VTYP:00013AF2]');
		
	if (RandNumber2 = 1) and (RaceIsOrc = True) then
		SetEditValue(VoiceType, 'MaleOrc [VTYP:00013AEA]');
		
	if (RandNumber2 = 1) and (RaceIsDunmer = False) and (RaceIsOrc = False) then
		SetEditValue(VoiceType, 'MaleCommoner [VTYP:00013AD3]');
	
	if RandNumber2 = 2 then 
		SetEditValue(VoiceType, 'MaleBandit [VTYP:0009843B]');
	
	if RandNumber2 = 3 then
		SetEditValue(VoiceType, 'MaleBrute [VTYP:00013ADA]');
	
	if RandNumber2 = 4 then
		SetEditValue(VoiceType, 'MaleCommander [VTYP:00013AD8]');
	
	if RandNumber2 = 5 then
		SetEditValue(VoiceType, 'MaleCommonerAccented [VTYP:000EA266]');
	
	if RandNumber2 = 6 then
		SetEditValue(VoiceType, 'MaleCondescending [VTYP:00013AD9]');
	
	if RandNumber2 = 7 then
		SetEditValue(VoiceType, 'MaleCoward [VTYP:00013ADB]');
	
	if RandNumber2 = 8 then
		SetEditValue(VoiceType, 'MaleDrunk [VTYP:00013AD4]');
	
	if RandNumber2 = 9 then
		SetEditValue(VoiceType, 'MaleElfHaughty [VTYP:00013AF0]');
	
	if RandNumber2 = 10 then
		SetEditValue(VoiceType, 'MaleEvenToned [VTYP:00013AD2]');
	
	if RandNumber2 = 11 then
		SetEditValue(VoiceType, 'MaleEvenTonedAccented [VTYP:000EA267]');
	
	if RandNumber2 = 12 then
		SetEditValue(VoiceType, 'MaleGuard [VTYP:000AA8D3]');
	
	if RandNumber2 = 13 then
		SetEditValue(VoiceType, 'MaleNord [VTYP:00013AE6]');
	
	if RandNumber2 = 14 then
		SetEditValue(VoiceType, 'MaleNordCommander [VTYP:000E5003]');
		
	if RandNumber2 = 15 then
		SetEditValue(VoiceType, 'MaleSlyCynical [VTYP:00013AD5]');
		
	if RandNumber2 = 16 then
		SetEditValue(VoiceType, 'MaleYoungEager [VTYP:00013AD1]');

end;

procedure RandomVoicetype(e: IInterface);
begin
	Randomize;
	
	VoiceType := ElementBySignature(e, 'VTCK');
	RandNumber := random(8) + 1;
	RandNumber2 := random(15) + 1;
	RandSubNumber := random(1) + 1;
	RandSubNumberMale := random(3) + 1;
	
	TemplateTraitsString := GetElementEditValues(e, 'ACBS - Configuration\Template Flags');
	GenderString := GetElementEditValues(e, 'ACBS - Configuration\Flags');
	
	if bDoChange = true then begin
	
		AddMessage(GenderString);
		Delete(GenderString, 1, 1);
		AddMessage(GenderString);
		GenderString := '0'+GenderString;
		SetEditValue(FlagPath, GenderString);
		AddMessage(GenderString);
		SetEditValue(ElementByPath(e, 'ACBS - Configuration\Flags'), GenderString);
		
	end;
	
	IsTemplateTraitsFlag := StrToInt(TemplateTraitsString[1]);
	GenderFlag := StrToInt(GenderString[1]);
	
	
	if (GetElementEditValues(e, 'RNAM - Race') = 'DarkElfRace "Dark Elf" [RACE:00013742]') then
		RaceIsDunmer := True;
		
	if (GetElementEditValues(e, 'RNAM - Race') = 'ArgonianRace "Argonian" [RACE:00013740]') then
		exit;
		
	if (GetElementEditValues(e, 'RNAM - Race') = 'KhajiitRace "Khajiit" [RACE:00013745]') then
		exit;
		
	if (GetElementEditValues(e, 'RNAM - Race') = 'OrcRace "Orc" [RACE:00013747]') then
		RaceIsOrc := True;
	
	if (IsTemplateTraitsFlag = 0) and (GenderFlag = 1) then
		FemaleVoices(e);
		
	if (IsTemplateTraitsFlag = 0) and (GenderFlag = 0) then
		MaleVoices(e);
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	HeadPath := ElementByPath(e, 'Head Parts');
	FlagPath := ElementByPath(e, 'ACBS - Configuration\Flags');
	
	FlagsStr := GetEditValue(FlagPath);
	
	for i := 0 to ElementCount(HeadPath) - 1 do begin
		eHeadPart := ElementByIndex(HeadPath, i);
		HeadPartStr := GetEditValue(eHeadPart);
		iii := Pos(FemaleGenderStr, HeadPartStr);
		if iii > 0 then
			exit;
		
		ii := Pos(GenderStr, HeadPartStr);
		if ii > 0 then
			if bDoChange = false then
				if FlagsStr[1] = '1' then
					bDoChange := true;
	end;
	
	if bDoChange = true then
		RandomVoiceType(e);
	
end;


function Finalize: integer;
begin

end;

end.