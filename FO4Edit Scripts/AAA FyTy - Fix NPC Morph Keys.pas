unit userscript;

function DoMorphsExist(e: IInterface): boolean;
var
	bMSDKExists, bMSDVExists: boolean;
begin
	bMSDKExists := ElementExists(e, 'MSDK');
	bMSDVExists := ElementExists(e, 'MSDV');
	
	if (bMSDKExists = true) and (bMSDVExists = true) then
		Result := true
	else
		Result := false;
end;

function Process(e: IInterface): integer;
var
	eOrig, eOrigMSDK, eOrigMSDV, eMaster: IInterface;
	iOverrideCount: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eMaster := MasterOrSelf(e);
	
	iOverrideCount := OverrideCount(eMaster);
	
	if (iOverrideCount = 0) then
		exit;
	
	if (DoMorphsExist(e) = false) then
		exit;
	
	if iOverrideCount > 1 then
		eMaster := OverrideByIndex(eMaster, iOverrideCount - 2);
	
	AddMessage(GetFileName(GetFile(eMaster)));
	
	eOrigMSDK := ElementBySignature(eMaster, 'MSDK');
	eOrigMSDV := ElementBySignature(eMaster, 'MSDV');
	
	wbCopyElementToRecord(eOrigMSDK, e, false, true);
	wbCopyElementToRecord(eOrigMSDV, e, false, true);

end;


end.