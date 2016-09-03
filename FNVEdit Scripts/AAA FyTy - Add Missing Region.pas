unit userscript;

var
	ePath, oRecord, oElement, TestRecord: IInterface;
	cRecord: Cardinal;
	cOverrides: integer;
	Fallout3File, TTWFile, TTWFixesFile: IInterface;

function Initialize: integer;
begin
	Fallout3File := FileByIndex(11);
	AddMessage(GetFileName(Fallout3File));
	TTWFile := FileByIndex(17);
	AddMessage(GetFileName(TTWFile));
	TTwFixesFile := FileByIndex(18);
	AddMessage(GetFileName(TTWFixesFile));
end;


function Process(e: IInterface): integer;
begin

	if (Signature(e) <> 'CELL') then
		if (ElementExists(e, 'XCLR') == true) then
			exit;

  AddMessage('Processing: ' + FullPath(e));
	
	ePath := ElementBySignature(e, 'XCLR');
	cRecord := FormID(e);
	cOverrides := OverrideCount(e);
	//AddMessage(IntToStr(cOverrides));
	//AddMessage(IntToStr(cRecord));
	
	TestRecord := MasterOrSelf(e);
	AddMessage(IntToStr(OverrideCount(TestRecord)));
	TestRecord := OverrideByIndex(TestRecord, 0);
	AddMessage(IntToStr(OverrideCount(TestRecord)));
	AddMessage(GetFileName(GetFile(TestRecord)));
	//OverrideByIndex(e, OverrideCount(e) - 2);
	
	//TestRecord := RecordByFormID(Fallout3File, cRecord, true);
	//AddMessage(IntToStr(FixedFormID(TestRecord)));
	
	//if FixedFormID(TestRecord) == 0 then
	
end;


function Finalize: integer;
begin

end;

end.