unit userscript;
const
	iItemTemplateFormID = 134237267;
	strTemplateEDID = 'AAAFyTy_MovableToItem_';
var
	eMyFile, eTemplate: IInterface;


function Initialize: integer;
begin
  eMyFile := FileByIndex(8);
	eTemplate := RecordByFormID(eMyFile, iItemTemplateFormID, true);
end;


function Process(e: IInterface): integer;
var
	eNew, eBounds, eModel: IInterface;
	strName, strEDID: string;
begin

	if Signature(e) <> 'MSTT' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eBounds := ElementBySignature(e, 'OBND');
	eModel := ElementByName(e, 'Model');
	
	if GetElementEditValues(e, 'FULL') <> '' then
		strName := GetElementEditValues(e, 'FULL');
	
	strEDID := GetElementEditValues(e, 'EDID');
	
	eNew := wbCopyElementToFile(eTemplate, eMyFile, true, true);
	wbCopyElementToRecord(eBounds, eNew, true, true);
	wbCopyElementToRecord(eModel, eNew, true, true);
	
	if strName <> '' then begin
		Add(eNew, 'FULL - Name', false);
		SetElementEditValues(eNew, 'FULL', strName);
	end;
	
	SetElementEditValues(eNew, 'EDID', strTemplateEDID + strEDID);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.