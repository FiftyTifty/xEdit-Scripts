unit userscript;
var
	fileDestination: IInterface;

function Initialize: integer;
begin
	
	fileDestination := FileByIndex(9);
	
end;


function Process(e: IInterface): integer;
var
	eCopiedActor, eActorConfig, eActorConfigFlags, eTemplate, eLevel: IInterface;
	strActorConfigFlags, strTemplateFlags: string;
	iCounter: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	//if GetEditValue(ElementBySignature(e, 'RNAM')) <> 'HumanRace "Human" [RACE:00013746]' then
		//exit;
	
	if OverrideCount(e) > 0 then	
		if GetFileName(GetFile(OverrideByIndex(e, OverrideCount(e) - 1))) = 'FyTy - Armor Balance.esp' then
			exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	
	
	// Get elements 'n' strings from the original NPC
	eActorConfig := ElementBySignature(e, 'ACBS');
	
	eTemplate := ElementByPath(eActorConfig, 'Use Template Actors');
	strTemplateFlags := GetEditValue(eTemplate); // Stats flag is 2nd flag
	// End
	
	{
	if Length(strTemplateFlags) > 1 then // If the flags string is longer than 1 character
		if strTemplateFlags[2] = '1' then // And the actor uses the stats of another
			exit; //There's no need to change the actor, so skip it.
	}
	
	
	eCopiedActor := wbCopyElementToFile(e, fileDestination, false, true);
	
	// Change our variables to reference the override
	eActorConfig := ElementBySignature(eCopiedActor, 'ACBS');
	
	eActorConfigFlags := ElementByPath(eActorConfig, 'Flags');
	strActorConfigFlags := GetEditValue(eActorConfigFlags);
	
	eTemplate := ElementByPath(eActorConfig, 'Use Template Actors');
	strTemplateFlags := GetEditValue(eTemplate); // Stats flag is 2nd flag
	
	// End
	
	
	if Length(strActorConfigFlags) > 7 then
		if strActorConfigFlags[8] = '1' then begin // If the PC Lvl Mult flag is 1
		
			Delete(strActorConfigFlags, 8, 1);
			Insert('0', strActorConfigFlags, 8); // Change it to 0
			
		end;
	
	
	if Length(strActorConfigFlags) > 4 then begin // If we have the Level Calc flag already
		Delete(strActorConfigFlags, 5, 1); // We'll make sure that it's set to 1 by removing it
		Insert('1', strActorConfigFlags, 5); // And then adding it back in
	end;
	
	if Length(strActorConfigFlags) < 4 then // If we don't
		for iCounter := Length(strActorConfigFlags) to 3 do begin // We'll make sure that we have all the flags compensated for
			strActorConfigFlags := strActorConfigFlags + '0'; // By adding the preceding flags as 0
		end;
	
	if Length(strActorConfigFlags) = 4 then
		strActorConfigFlags := strActorConfigFlags + '1';
	
	SetEditValue(eActorConfigFlags, strActorConfigFlags);
	
	AddMessage(strActorConfigFlags);
	
	eLevel := ElementByPath(eCopiedActor, 'ACBS - Configuration\Level');
	SetEditValue(eLevel, '50');
	
end;

end.