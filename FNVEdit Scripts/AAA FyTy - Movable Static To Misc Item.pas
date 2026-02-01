unit userscript;
var
	eFile, eMISCTemplate: IInterface;

function Initialize: integer;
begin
	eFile := FileByIndex(18);
	eMISCTemplate := RecordByFormID(eFile, 234891581, false);
end;


function Process(e: IInterface): integer;
var
	eMSTTObjectBounds, eMSTTEDID, eMSTTModel: IInterface;
	eMISCObjectBounds, eMISCEDID, eMISCModel: IInterface;
	eMISCNew: IInterface;
	strName, strEDID: string;
begin
	
	if Signature(e) <> 'MSTT' then
		exit;
	
	AddMessage('Processing: ' + FullPath(e));
	
	eMISCNew := wbCopyElementToFile(eMISCTemplate, eFile, true, true);
	
	eMSTTObjectBounds := ElementBySignature(e, 'OBND');
	eMSTTEDID := ElementBySignature(e, 'EDID');
	eMSTTModel := ElementByPath(e, 'Model');
	
	eMISCObjectBounds := wbCopyElementToRecord(eMSTTObjectBounds, eMISCNew, true, true);
	eMISCEDID := wbCopyElementToRecord(eMSTTEDID, eMISCNew, true, true);
	eMISCModel := wbCopyElementToRecord(eMSTTModel, eMISCNew, true, true);
	
	strName := GetElementEditValues(eMISCNew, 'EDID');
	strEDID := 'AAAFyTyMisc' + GetElementEditValues(eMISCNew, 'EDID');
	
	SetElementEditValues(eMISCNew, 'EDID', strEDID);
	SetElementEditValues(eMISCNew, 'FULL', strName);

end;

end.
