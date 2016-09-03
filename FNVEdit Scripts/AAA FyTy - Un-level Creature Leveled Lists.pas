unit userscript;
uses mtefunctions;

var
	MyFile, eDefault, eCREAtree: IInterface;
	DoCopy, bCopyRec: Boolean;
	
	//begin Procedure PrintItemLevel
	ePrintCrea: IInterface;
	sPrintLevel: string;
	intPrint, iPrintLevel: integer;
	//end Procedure PrintItemLevel
	
	//begin Procedure CopyRecord
	eCRnewRecord, eCRcreaTree, eCRcrea: IInterface;
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
	
		ePrintCrea := ElementByIndex(eP, intPrint);
		ePrintCrea := ElementByPath(ePrintCrea, 'LVLO - Base Data\Level');
		
		sPrintLevel := GetEditvalue(ePrintCrea);
		
		if strtoint(sPrintLevel) > 1 then
			bCopyRec := true;
		
		AddMessage(sPrintLevel);
	end;
	
	if bCopyRec = true then
		CopyRecord(intPrint);

end;

procedure CopyRecord(iCopyIndex: integer;);
begin
	eCRnewRecord := wbCopyElementToFile(eDefault, MyFile, false, true);
	
	eCRcreaTree := ElementByPath(eCRnewRecord, 'Leveled List Entries');
	
	eCRcrea := ElementByIndex(eCRcreaTree, iCopyIndex);
	eCRcrea := ElementByPath(eCRcrea, 'LVLO - Base Data\Level');
	
	SetEditValue(eCRcrea, '1');
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'LVLC' then
		exit;
		
  //AddMessage('Processing: ' + FullPath(e));
	eDefault := e;
	eCREAtree := ElementByPath(e, 'Leveled List Entries');
	PrintItemLevel(eCREAtree);

end;


function Finalize: integer;
begin

end;

end.