//Progress: Finished Lakelurks
unit userscript;
uses mtefunctions;

var
	MyFile, eRecord, CopiedRecord, eLevel, eLevelMult, eHealth, eFlags, eTempFlags, eCalcMin, eCalcMax, eBaseHealth: IInterface;
	i, iOverrides, iHealth, iHealthAdded: integer;
	FlagStr, TempFlagStr, UsesStatsStr, AutoCalcStatsStr, PCLevelMultStr, LevelMultStr, LevelStr, CharStr01, CharStr02, CharStr03: string;
	EDIDstr: string;
	EndScript: Boolean;

function Initialize: integer;
begin
	MyFile := FileSelect('Choose destination .esp');
	//MyFile := FileByIndex(14);
	
	iHealth := 550;
	iHealthAdded := 200;
end;

function RandomLevel(lRandRange: integer; lRandMin:integer): integer;
begin
	Randomize;
	Result := IntToStr((Random(lRandRange) + lRandMin));
end;

function RandomHealth(hRandRange: integer; hRandMin:integer): integer;
begin
	Randomize;
	Result := IntToStr((Random(hRandRange) + hRandMin));
end;

procedure SetHealth(sEDID: string);
begin

	if Pos(sEDID, 'AntQueen') > 0 then begin
		iHealth := 900;
		iHealthAdded := 400;
	end;
	
	if Pos(sEDID, 'BarkScorpion') > 0 then begin
		iHealth := 500;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'BigHorner') > 0 then begin
		iHealth := 900;
		iHealthAdded := 400;
	end;
	
	if Pos(sEDID, 'Bloatfly') > 0 then begin
		iHealth := 130;
		iHealthAdded := 120;
	end;
	
	if Pos(sEDID, 'Brahmin') > 0 then begin
		iHealth := 400;
		iHealthAdded := 300;
	end;
	
	if Pos(sEDID, 'Cazador') > 0 then begin
		iHealth := 450;
		iHealthAdded := 150;
	end;
	
	if Pos(sEDID, 'Centaur') > 0 then begin
		iHealth := 300;
		iHealthAdded := 300;
	end;
	
	if Pos(sEDID, 'Coyote') > 0 then begin
		iHealth := 200;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'CyberDog') > 0 then begin
		iHealth := 400;
		iHealthAdded := 250;
	end;
	
	if Pos(sEDID, 'Deathclaw') > 0 then begin
		iHealth := 300;
		iHealthAdded := 550;
	end;
	
	if Pos(sEDID, 'Dog') > 0 then begin
		iHealth := 200;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'Feral') > 0 then begin
		iHealth := 200;
		iHealthAdded := 250;
	end;
	
	if Pos(sEDID, 'FireAnt') > 0 then begin
		iHealth := 400;
		iHealthAdded := 100;
	end;
	
	if Pos(sEDID, 'Gecko') > 0 then
		if Pos(sEDID, 'Small') > 0 then
			begin
				iHealth := 200;
				iHealthAdded := 150;
			end;
	
	if Pos(sEDID, 'Gecko') > 0 then
		if Pos(sEDID, 'Med') > 0 then
			begin
				iHealth := 300;
				iHealthAdded := 150;
			end;
	
	if Pos(sEDID, 'Gecko') > 0 then
		if Pos(sEDID, 'Large') > 0 then
			begin
				iHealth := 400;
				iHealthAdded := 300;
			end;
	
	if Pos(sEDID, 'Gecko') > 0 then
		if Pos(sEDID, 'Large') = 0 then
			if Pos(sEDID, 'Small') = 0 then
				if Pos(sEDID, 'Med') = 0 then
					begin
						iHealth := 400;
						iHealthAdded := 300;
					end;
	
	if Pos(sEDID, 'LakeLurk') > 0 then begin
		iHealth := 500;
		iHealthAdded := 400;
	end;
	
	if Pos(sEDID, 'GiantRat') > 0 then begin
		iHealth := 200;
		iHealthAdded := 350;
	end;
	
	if Pos(sEDID, 'Mantis') > 0 then begin
		iHealth := 130;
		iHealthAdded := 170;
	end;
	
	if Pos(sEDID, 'Mirelurk') > 0 then begin
		iHealth := 200;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'MisterGutsy') > 0 then begin
		iHealth := 450;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'MisterHandy') > 0 then begin
		iHealth := 450;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'Molerat') > 0 then begin
		iHealth := 200;
		iHealthAdded := 150;
	end;
	
	if Pos(sEDID, 'Nightstalker') > 0 then begin
		iHealth := 450;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'Protectron') > 0 then begin
		iHealth := 500;
		iHealthAdded := 250;
	end;
	
	if Pos(sEDID, 'Radroach') > 0 then begin
		iHealth := 100;
		iHealthAdded := 100;
	end;
	
	if Pos(sEDID, 'RoboScorpion') > 0 then begin
		iHealth := 700;
		iHealthAdded := 250;
	end;
	
	if Pos(sEDID, 'Robobrain') > 0 then begin
		iHealth := 550;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'Securitron') > 0 then begin
		iHealth := 550;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'SentryBot') > 0 then begin
		iHealth := 550;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'SporeCarrier') > 0 then begin
		iHealth := 400;
		iHealthAdded := 100;
	end;
	
	if Pos(sEDID, 'SuperMutant') > 0 then begin
		iHealth := 550;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'Trog') > 0 then begin
		iHealth := 150;
		iHealthAdded := 100;
	end;
	
	if Pos(sEDID, 'Turret') > 0 then begin
		iHealth := 150;
		iHealthAdded := 200;
	end;
	
	if Pos(sEDID, 'YaoGuai') > 0 then begin
		iHealth := 500;
		iHealthAdded := 350;
	end;
end;

				

procedure CopyRecModLvlHealth(e: IInterface; CreaHealthVariance: integer; CreaHealthBase: integer;);
begin
	AddMessage('Copying Creature');
	CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
	
	eFlags := ElementByPath(CopiedRecord, 'ACBS - Configuration\Flags');
	eLevel := ElementByPath(CopiedRecord, 'ACBS - Configuration\Level');
	eHealth := ElementByPath(CopiedRecord, 'DATA\Health');
	eCalcMin := ElementByPath(CopiedRecord, 'ACBS - Configuration\Calc min');
	eCalcMax := ElementByPath(CopiedRecord, 'ACBS - Configuration\Calc max');
	
	LevelStr := GetEditValue(eLevel);
	
	if FlagStr[8] = '1' then begin // flag #8 = PCLevelMult
		AddMessage(FlagStr);
		Delete(FlagStr, 8, 1); // flag #8 is true, so delete only 1 char
		Insert('0', FlagStr, 8); // Insert "0" so now flag #8 is false.
		AddMessage(FlagStr);
		SetEditValue(eFlags, FlagStr);
	end;
	
	
	if LevelStr < 40 then
		SetEditValue(eLevel, RandomLevel(10, 40));
	
	if LevelStr > 50 then
		SetEditValue(eLevel, RandomLevel(10, 40));
	
	SetEditValue(eHealth, RandomHealth(CreaHealthVariance, CreaHealthBase));
	
	SetEditValue(eCalcMin, 0);
	SetEditValue(eCalcMax, 0);
	
	EndScript := true;
end;

procedure CopyRecModLvlHealthAutoCalc(e: IInterface);
begin
	AddMessage('Copying NPC');
	CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
	
	//CopiedRecord := e;
	
	eFlags := ElementByPath(CopiedRecord, 'ACBS - Configuration\Flags');
	eLevel := ElementByPath(CopiedRecord, 'ACBS - Configuration\Level');
	eCalcMin := ElementByPath(CopiedRecord, 'ACBS - Configuration\Calc min');
	eCalcMax := ElementByPath(CopiedRecord, 'ACBS - Configuration\Calc max');
	eBaseHealth := ElementByPath(CopiedRecord, 'DATA\Base Health');
	eLevelMult := ElementByPath(CopiedRecord, 'ACBS - Configuration\Level Mult');
	
	LevelMultStr := GetEditValue(eLevelMult);
	FlagStr := GetEditValue(eFlags);
	
	
	if FlagStr[5] = '0' then begin // 5 = Auto Calc Stats
		AddMessage(FlagStr);
		Delete(FlagStr, 5, 1); // flag #5 is @ 0, so delete it
		Insert('1', FlagStr, 5); // Insert "1" so now flag #5 is true.
		AddMessage(FlagStr);
		SetEditValue(eFlags, FlagStr);
	end;
	
	LevelStr := GetEditValue(eLevel);
	
	if LevelStr < 40 then
		SetEditValue(eLevel, RandomLevel(10, 40));
	
	if LevelStr > 50 then
		SetEditValue(eLevel, RandomLevel(10, 40));
	
	SetEditValue(eCalcMin, 0);
	SetEditValue(eCalcMax, 0);
	
	SetEditValue(eBaseHealth, 95);
	
	if FlagStr[8] = '1' then begin // 8 = PC Level Mult
		AddMessage(FlagStr);
		Delete(FlagStr, 8, 1);
		Insert('0', FlagStr, 8);
		AddMessage(FlagStr);
		SetEditValue(eFlags, FlagStr);
	end;
	
	SetEditValue(eLevelMult, RandomLevel(10, 40));
	
	EndScript := true;
end;




function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'NPC_' then
		if Signature(e) <> 'CREA' then
			exit;
		
	if (FormID(e) = 7) then // Male Player
		exit;
	
	if (FormID(e) = 523167) then // Female Player
		exit;
	
	if GetEditValue(ElementBySignature(e, 'VTCK')) = 'UniqueRadioPlay [VTYP:00093242]' then
		exit;
		
	if GetEditValue(ElementBySignature(e, 'VTCK')) = 'NVDLC03MaleUniquePlayersBrain [VTYP:00029FB1]' then
		exit;
	
	if GetEditValue(ElementBySignature(e, 'VTCK')) = 'MaleUniqueVault101PA [VTYP:00071623]' then
		exit;
	
	if GetEditValue(ElementBySignature(e, 'VTCK')) = 'PlayerVoiceFemale [VTYP:00040D42]' then
		exit;
	
	if GetEditValue(ElementBySignature(e, 'VTCK')) = 'PlayerVoiceMale [VTYP:0002853B]' then
		exit;
	
	//if GetEditValue(ElementBySignature(e, 'VTCK')) = 'VoiceDoNotRecordF [VTYP:00094EED]' then
	//	exit;
	
	//if GetEditValue(ElementBySignature(e, 'VTCK')) = 'VoiceDoNotRecordM [VTYP:00094EEC]' then
	//	exit;
	
	EDIDstr := GetEditValue(ElementByPath(e, 'EDID - Editor ID'));
	
	if Pos('Dead', EDIDstr) > 0 then
		exit;
	
	if Pos('DEAD', EDIDstr) > 0 then
		exit;
	
	if Pos('dead', EDIDstr) > 0 then
		exit;
	
	if Pos('AudioTemplate', EDIDstr) > 0 then
		exit;
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	EndScript := false;
	iOverrides := OverrideCount(e);
	
	eRecord := e;
	
	if (iOverrides > 0) then
		eRecord := OverrideByIndex(e, iOverrides - 1);
	
	if Signature(e) = 'CREA' then
		SetHealth(EDIDstr);

	eTempFlags := ElementByPath(eRecord, 'ACBS - Configuration\Template Flags');
	TempFlagStr := GetEditValue(eTempFlags);
	
	eFlags := ElementByPath(eRecord, 'ACBS - Configuration\Flags');
	FlagStr := GetEditValue(eFlags);
	
	AddMessage(TempFlagStr);
	AddMessage(FlagStr);
	
	if TempFlagStr[2] = '1' then
		exit;
	
	AddMessage('Is not using Stats');
	
	if Signature(e) = 'CREA' then
		CopyRecModLvlHealth(eRecord, iHealthAdded, iHealth); // First int is variance of health, added to second int.
	
	AddMessage('Is not a Creature');
	
	if Length(FlagStr) < 8 then
		if TempFlagStr[2] = '0' then
			if EndScript = false then
				CopyRecModLvlHealthAutoCalc(eRecord);
	
	if FlagStr[8] = '1' then
		if TempFlagStr[2] = '0' then
			if EndScript = false then
				CopyRecModLvlHealthAutoCalc(eRecord);
			
	if FlagStr[8] = '0' then
		if TempFlagStr[2] = '0' then
			if EndScript = false then
				CopyRecModLvlHealthAutoCalc(eRecord);
	
	
	
end;


function Finalize: integer;
begin

end;

end.
