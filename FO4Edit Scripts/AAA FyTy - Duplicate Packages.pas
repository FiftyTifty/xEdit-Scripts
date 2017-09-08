unit userscript;
var
	tstrlistPackageRecords: TStringList;
	fileESP: IInterface;
	iNumDuplicates: byte;
	strToFind, strBaseSuffix: string;


function Initialize: integer;
begin
  tstrlistPackageRecords := TStringList.Create;
	iNumDuplicates := 9;
	strToFind := '01';
	strBaseSuffix := '';
end;


function Process(e: IInterface): integer;
var
	strFormID: string;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	fileESP := GetFile(e);
	
	strFormID := FormID(e);
	tstrlistPackageRecords.Add(strFormID);
	
end;


function Finalize: integer;
var
	iCounter, iSuffixCounter, iRecordCounter: integer;
	strSuffix, strEDID, strNewEDID: string;
	ePackage, eNewRecord: IInterface;
begin
  
	
	for iCounter := 0 to tstrlistPackageRecords.Count - 1 do begin
		
		iSuffixCounter := 01;
		
		while iRecordCounter < 9 do begin
			inc(iSuffixCounter);
			
			ePackage := RecordByFormID(fileESP, tstrlistPackageRecords[iCounter], true);
			eNewRecord := wbCopyElementToFile(ePackage, fileESP, true, true);
			
			strEDID := GetElementEditValues(eNewRecord, 'EDID');
			strSuffix := Format('%0.2d', [iSuffixCounter]);
			
			strNewEDID := StringReplace(strEDID, strToFind, strBaseSuffix + strSuffix, nil);
			
			SetElementEditValues(eNewRecord, 'EDID', strNewEDID);
			
			inc(iRecordCounter);
		end;
		
		iRecordCounter := 0;
		
	end;
	
end;

end.