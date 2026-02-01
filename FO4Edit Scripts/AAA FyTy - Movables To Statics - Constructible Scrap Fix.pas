unit userscript;
var
	eMyFile, eFormlistTemplate: IInterface;


function Initialize: integer;
begin
  eMyFile := FileByIndex(8);
	eFormlistTemplate := RecordByFormID(eMyFile, 117647509, true);
end;


function Process(e: IInterface): integer;
var
	eRecord, eNewList, eCNAM, eFormID: IInterface;
	strEDID, strFullFormID, strListFullFormID: string;
begin
	
	if Signature(e) <> 'COBJ' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eCNAM := ElementBySignature(e, 'CNAM');
	strEDID := GetElementEditValues(e, 'EDID') + '_Formlist';
	
	eRecord := LinksTo(eCNAM);
	strFullFormID := GetElementEditValues(eRecord, 'Record Header\FormID');
	
	eNewList := wbCopyElementToFile(eFormlistTemplate, eMyFile, true, true);
	eFormID := ElementByIndex(ElementByPath(eNewList, 'FormIDs'), 0);
	SetEditValue(eFormID, strFullFormID);
	SetElementEditValues(eNewList, 'EDID', strEDID);
	strListFullFormID := GetElementEditValues(eNewList, 'Record Header\FormID');
	AddMessage(strListFullFormID);
	
	SetEditValue(eCNAM, strListFullFormID);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.