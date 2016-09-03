unit userscript;
uses mtefunctions;

var
	MyFile, eDefault, eItemTree: IInterface;
	DoCopy, bCopyRec: Boolean;
	
	//begin Procedure PrintItemLevel
	ePrintItem: IInterface;
	sPrintLevel: string;
	intPrint, iPrintLevel: integer;
	//end Procedure PrintItemLevel
	
	//begin Procedure CopyRecord
	eCRnewRecord, eCRitemTree, eCRitem: IInterface;
	//end Procedure CopyRecord

function Initialize: integer;
begin
	DoCopy := true;
	
	if DoCopy = true then
		MyFile := FileSelect('Select Destination File');
end;

procedure LevelMessage;
begin
	AddMessage('Processing: ' + FullPath(eDefault));
	AddMessage('Item level is greater than 1');
end;

procedure PrintItemLevel(eP: IInterface);
begin

	for intPrint := 0 to ElementCount(eP) - 1 do begin
	
		ePrintItem := ElementByIndex(eP, intPrint);
		ePrintItem := ElementByPath(ePrintItem, 'LVLO - Base Data\Level');
		
		sPrintLevel := GetEditvalue(ePrintItem);
		
		if strtoint(sPrintLevel) > 1 then
			bCopyRec := true;
		
		//AddMessage(sPrintLevel);
	end;
	
	if bCopyRec = true then
		CopyRecord(intPrint);

end;

procedure CopyRecord(iCopyIndex: integer;);
begin
	eCRnewRecord := wbCopyElementToFile(eDefault, MyFile, false, true);
	
	eCRitemTree := ElementByPath(eCRnewRecord, 'Leveled List Entries');
	
	eCRitem := ElementByIndex(eCRitemTree, iCopyIndex);
	eCRitem := ElementByPath(eCRitem, 'LVLO - Base Data\Level');
	
	SetEditValue(eCRitem, '1');
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'LVLI' then
		exit;
		
  //AddMessage('Processing: ' + FullPath(e));
	bCopyRec := false;
	eDefault := e;
	eItemTree := ElementByPath(e, 'Leveled List Entries');
	PrintItemLevel(eItemTree);

end;


function Finalize: integer;
begin

end;

end.