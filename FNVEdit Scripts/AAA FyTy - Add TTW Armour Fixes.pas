unit userscript;
const
	strBMDTPath = 'BMDT - Biped Data';
	strMaleBipedPath = 'Male biped model';
	strFemaleBipedPath = 'Female biped model';
	strTNAMPath = 'TNAM - Animation Sounds Template';
	strValuePath = 'DATA - Data\Value';
	strEITMPath = 'EITM - Object Effect';
	strMaleWorldModelPath = 'Male world model';
	strOBNDPath = 'OBND - Object Bounds';
	strFemaleWorldModelPath = 'Female world model';
	strMICOPath = 'MICO - Male mico filename';
	strFULLPath = 'FULL - Name';
	strFlagsPath = 'DNAM - DNAM\Flags';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eTTW, eToCopy: IInterface;
	bDoBiped, bDoMaleBiped, bDoFemaleBiped, bDoTNAM,
	bDoValue, bDoEITM, bDoMaleWorldModel,
	bDoOBND, bDoFemaleWorldModel, bRemoveMICO,
	bDoFULL, bDoFlags: boolean;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eTTW:= MasterOrSelf(e);
	
	if OverrideCount(eTTW) < 2 then
		exit;
	
	eTTW := OverrideByIndex(eTTW, OverrideCount(eTTW) - 2);
	
	if ElementExists(eTTW, strBMDTPath) then
		bDoBiped := true;
	
	if ElementExists(eTTW, strMaleBipedPath) then
		bDoMaleBiped := true;
	
	if ElementExists(eTTW, strFemaleBipedPath) then
		bDoFemaleBiped := true;
	
	if ElementExists(eTTW, strTNAMPath) then
		bDoTNAM := true;
	
	if ElementExists(eTTW, strValuePath) then
		bDoValue := true;
	
	if ElementExists(eTTW, strEITMPath) then
		bDoEITM := true;
	
	if ElementExists(eTTW, strMaleWorldModelPath) then
		bDoMaleWorldModel := true;
	
	if ElementExists(eTTW, strOBNDPath) then
		bDoOBND := true;
	
	if ElementExists(eTTW, strFemaleWorldModelPath) then
		bDoFemaleWorldModel := true;
	
	if ElementExists(eTTW, strFULLPath) then
		bDoFULL := true;
	
	bRemoveMICO := ElementExists(eTTW, strMICOPath);
	
	if ElementExists(eTTW, strFlagsPath) then
		bDoFlags := true;
	
	if bDoBiped = true then begin
		eToCopy := ElementByPath(eTTW, strBMDTPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoMaleBiped = true then begin
		eToCopy := ElementByPath(eTTW, strMaleBipedPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoFemaleBiped = true then begin
		eToCopy := ElementByPath(eTTW, strFemaleBipedPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoTNAM = true then begin
		eToCopy := ElementByPath(eTTW, strTNAMPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoValue = true then begin
		eToCopy := ElementByPath(eTTW, strValuePath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoEITM = true then begin
		eToCopy := ElementByPath(eTTW, strEITMPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoMaleWorldModel = true then begin
		eToCopy := ElementByPath(eTTW, strMaleWorldModelPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoOBND = true then begin
		eToCopy := ElementByPath(eTTW, strOBNDPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoFemaleWorldModel = true then begin
		eToCopy := ElementByPath(eTTW, strFemaleWorldModelPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoFemaleWorldModel = true then begin
		eToCopy := ElementByPath(eTTW, strFemaleWorldModelPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bRemoveMICO = false then begin
		RemoveElement(e, 'MICO');
	end;
	
	if bDoFULL = true then begin
		eToCopy := ElementByPath(eTTW, strFULLPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if bDoFlags = true then begin
		eToCopy := ElementByPath(eTTW, strFlagsPath);
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.