unit userscript;
uses 'AAA FyTy - Aux Functions';
var
	bCopyRecord: boolean;
	strStatsFlag, strFlagPath, strTemplateFlagPath, strLevel,
	strAutoCalcFlag, strPCMultFlag, strDeadFlag, strCharGenFlag: string;
	eFile: IInterface;


function Initialize: integer;
begin
	bCopyRecord := true;
	strStatsFlag := 'Use Stats';
	strAutoCalcFlag := 'Auto-calc stats';
	strPCMultFlag := 'PC Level Mult';
	strCharGenFlag := 'Is CharGen Face Preset';

	strTemplateFlagPath := 'ACBS - Configuration\Template Flags';
	strFlagPath := 'ACBS - Configuration\Flags';
	eFile := FileByIndex(19);
	AddMessage(GetFileName(eFile));
	strLevel := '25';
	
	strDeadFlag := 'Record Header\Record Flags\Can''t wait / Platform Specific Texture / Dead';
end;


function Process(e: IInterface): integer;
var
	bNotUsingTemplate: boolean;
	eFlags, eACBSFlags, eLevel: IInterface;
	strEDID: string;
begin

	if Signature(e) <> 'NPC_' then
		exit;

  //AddMessage('Processing: ' + FullPath(e));
	
	e:= MasterOrSelf(e);
	
	if OverrideCount(e) > 0 then
		e := OverrideByIndex(e, OverrideCount(e) - 1);
	
	eFlags := ElementByPath(e, strTemplateFlagPath);
	eACBSFlags := ElementByPath(e, strFlagPath);
	
	strEDID := GetElementEditValues(e, 'EDID - Editor ID');
	
	if (pos('Dead', strEDID) > 0) or (pos('DEAD', strEDID) > 0) then begin
		//AddMessage('Has dead in name! Skipping!');
		exit;
	end;
	
	if (pos('VoiceType', strEDID) > 0) then begin
		//AddMessage('Has VoiceType in name! Skipping!');
		exit;
	end;
	
	if (pos('Dummy', strEDID) > 0) then begin
		//AddMessage('Has Dummy in name! Skipping!');
		exit;
	end;
	
	if GetElementEditValues(e, strDeadFlag) = '1' then begin
		//AddMessage('Has dead flag! Skipping!');
		exit;
	end;
	
	if (GetElementEditValues(eFlags, strStatsFlag) = '1') then begin
		//AddMessage('NPC has Use Stats flag set, skipping');
		exit;
	end;

	if (GetElementEditValues(eACBSFlags, strCharGenFlag) = '1') then begin
		//AddMessage('NPC has Is CharGen Face Preset flag set, skipping');
		exit;
	end;	
	
	if bCopyRecord = true then begin
		e := wbCopyElementToFile(e, eFile, false, true);
		//AddMessage('Copied NPC to file');
	end;
	
	//AddMessage('Editing NPC!');
	
	eFlags := ElementByPath(e, strFlagPath);
	
	SetFlag(eFlags, strPCMultFlag, false);
	SetFlag(eFlags, strAutoCalcFlag, true);
	
	SetElementEditValues(e, 'ACBS - Configuration\Level', '25');
	SetElementEditValues(e, 'ACBS - Configuration\Calc min', '25');
	SetElementEditValues(e, 'ACBS - Configuration\Calc max', '25');
	
	AdjustHumanNPCHealth(e, 100);
	
	//AddMessage('Edited NPC!');
	
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.