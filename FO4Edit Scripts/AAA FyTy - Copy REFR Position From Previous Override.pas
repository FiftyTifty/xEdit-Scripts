unit userscript;

function Initialize: integer;
begin
  
	
	
end;


function Process(e: IInterface): integer;
var
	eOriginal, eOverride, eDATA, eXRGD, eXLRL: IInterface;
	strFile: string;
	iIndex, iCounter, iNumOverrides: integer;
begin
	
  if Signature(e) <> 'REFR' then
		exit;
		
	strFile := GetFileName(GetFile(e));
	//AddMessage(strFile);
		
	eOriginal := MasterOrSelf(e);
	
	for iCounter := 0 to OverrideCount(eOriginal) - 1 do begin
	
		eOverride := OverrideByIndex(eOriginal, iCounter);
		
		//AddMessage(GetFileName(GetFile(eOverride)));
		
		if GetFileName(GetFile(eOverride)) = strFile then
			break
		else
			iIndex := iCounter;
	
	end;
	
	eOverride := OverrideByIndex(eOriginal, iIndex);
	
	eDATA := ElementByPath(eOverride, 'DATA');
	
	if ElementExists(eOverride, 'eXRGD') then begin
	
		eXRGD := ElementByPath(eOverride, 'eXRGD');
		wbCopyElementToRecord(eXRGD, e, false, true); 
		
	end;
	
	if ElementExists(eOverride, 'eXLRL') then begin
	
		eXLRL := ElementByPath(eOverride, 'eXRGD');
		wbCopyElementToRecord(eXLRL, e, false, true); 
		
	end;
	
	wbCopyElementToRecord(eDATA, e, false, true);  
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.