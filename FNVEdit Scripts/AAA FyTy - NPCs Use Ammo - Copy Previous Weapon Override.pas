unit userscript;

function Initialize: integer;
begin
  Result := 0;
end;

function Process(e: IInterface): integer;
var
	eFilePatch, eOriginal, eOverride: IInterface;
	strFileName: string;
	iCounter, iNumOverrides: integer;
begin

  if Signature(e) <> 'WEAP' then
		exit;
	
	eFilePatch := GetFile(e);
	strFileName := GetFileName(eFilePatch);
	
	eOriginal := MasterOrSelf(e);
	iNumOverrides := OverrideCount(eOriginal) - 1;
	//AddMessage(IntToStr(iNumOverrides));
	
	if iNumOverrides = 0 then
		eOverride := eOriginal
	else
		eOverride := OverrideByIndex(eOriginal, iNumOverrides - 1);
	
	Remove(e);
	
	eOverride := wbCopyElementToFile(eOverride, eFilePatch, false, true);		
	SetElementEditValues(eOverride, 'DNAM - DNAM\Flags 2\NPCs Use Ammo', '1');

end;

function Finalize: integer;
begin
  Result := 0;
end;

end.