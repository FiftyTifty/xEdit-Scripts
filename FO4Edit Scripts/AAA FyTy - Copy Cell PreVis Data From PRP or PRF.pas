unit userscript;
const
	strPRF = 'PRF.esm';
	strPRP = 'PRP.esp';


function Process(e: IInterface): integer;
var
	eOriginal, eOverride, ePRP, ePRF,
	eHeader, eVISI, ePCMB, eXPRI, eXCRI: IInterface;
	strFile, strOverride: string;
	iCounter, iNumOverrides: integer;
begin
	
  if Signature(e) <> 'CELL' then
		exit;
		
	strFile := GetFileName(GetFile(e));
	//AddMessage(strFile);
		
	eOriginal := MasterOrSelf(e);
	
	for iCounter := 0 to OverrideCount(eOriginal) - 1 do begin
	
		eOverride := OverrideByIndex(eOriginal, iCounter);
		
		strOverride := GetFileName(GetFile(eOverride));
		
		if strOverride = strPRF then
			ePRF := eOverride;
			
		if strOverride = strPRP then
			ePRP := eOverride;
			
		if strOverride = strFile then
			break
	
	end;
	
	if Assigned(ePRP) then
		eOverride := ePRP
	else if Assigned(ePRF) then
		eOverride := ePRF
	else
		exit;
	
	eHeader := ElementByPath(eOverride, 'Record Header');
	eVISI := ElementByPath(eOverride, 'VISI');
	ePCMB := ElementByPath(eOverride, 'PCMB');
	eXPRI := ElementByPath(eOverride, 'XPRI');
	eXCRI := ElementByPath(eOverride, 'XCRI');
	
	wbCopyElementToRecord(eHeader, e, false, true);  
	wbCopyElementToRecord(eVISI, e, false, true);
	wbCopyElementToRecord(ePCMB, e, false, true);
	wbCopyElementToRecord(eXPRI, e, false, true);
	wbCopyElementToRecord(eXCRI, e, false, true);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.