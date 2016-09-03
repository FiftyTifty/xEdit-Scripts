unit userscript;

var
	PatchFile: IInterface;
	
function  Initialize: integer;
begin
	PatchFile := FileByIndex(18);
end;

var
	Check, Replace: string;
	RecordCopy: IInterface;
	
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
		exit;	
	
	Check := 'WandererSpawn "Wanderer Spawn Point" [ACTI:0ECABE00]';
	//Replace := 'A0ZombieSpawnMarker [ACTI:0D000AE2]';

	if (GetEditValue(ElementBySignature(e, 'NAME')) = Check) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetIsInitiallyDisabled(RecordCopy, true)
		//SetEditValue(ElementBySignature(e, 'NAME'), Replace);
	end;

end;

end.