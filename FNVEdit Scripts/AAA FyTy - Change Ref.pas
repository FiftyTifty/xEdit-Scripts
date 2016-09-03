unit userscript;

var
	Check, Replace: string;
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
		exit;	
	
	Check := 'WandererSpawn "Wanderer Spawn Point" [ACTI:0ECABE00]';
	Replace := 'A0ZombieSpawnMarker [ACTI:0D000AE2]';

	if (GetEditValue(ElementBySignature(e, 'NAME')) = Check) then begin
		SetEditValue(ElementBySignature(e, 'NAME'), Replace);
	end;

end;

end.