unit userscript;
var
	tstrlistGlobalRecords: TStringList;
	fileESP: IInterface;
	iNumDuplicates: byte;
	strToFind, strBaseSuffix: string;


function Initialize: integer;
begin
  tstrlistGlobalRecords := TStringList.Create;
	iNumDuplicates := 9;
	strToFind := 'Party01';
	strBaseSuffix := 'Party';
end;


function Process(e: IInterface): integer;
var
	strFormID: string;
begin
	
	if Signature(e) <> 'GLOB' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	fileESP := GetFile(e);
	
	strFormID := FormID(e);
	tstrlistGlobalRecords.Add(strFormID);
	
end;


function Finalize: integer;
var
	iCounter, iSuffixCounter, iRecordCounter: byte;
	strSuffix, strEDID, strNewEDID: string;
	eGlobal, eNewRecord: IInterface;
begin
  
	iSuffixCounter := 01;
	
	for iCounter := 0 to tstrlistGlobalRecords.Count - 1 do begin
		
		inc(iSuffixCounter);
		
		while iRecordCounter < 9 do begin
			eGlobal := RecordByFormID(fileESP, tstrlistGlobalRecords[iCounter], true);
			eNewRecord := wbCopyElementToFile(eGlobal, fileESP, true, true);
			
			strEDID := GetElementEditValues(eNewRecord, 'EDID');
			strSuffix := Format('%0.2d', [iSuffixCounter]);
			
			strNewEDID := StringReplace(strEDID, strToFind, strBaseSuffix + strSuffix);
			
			SetElementEditValues(eNewRecord, 'EDID', strNewEDID);
			
			inc(iRecordCounter);
		end;
		
		iRecordCounter := 0;
		
	end;
	
end;

end.