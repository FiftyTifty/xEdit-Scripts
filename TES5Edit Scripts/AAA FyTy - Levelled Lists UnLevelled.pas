unit userscript;
uses mtefunctions;

function Initialize: integer;

begin
	MyFile := FileSelect('Choose/create the destination file');
end;

var
  ePath, CopiedRecord, MyFile: IInterface;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'LVLI' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
	ePath := ElementByPath(e, 'LVLF - Flags');
	if GetEditValue(ePath) = '0100' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1100');
	end;
	if GetEditValue(ePath) = '0101' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1101');
	end;
	if GetEditValue(ePath) = '0000' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1100');
	end;
	if GetEditValue(ePath) = '0001' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1101');
	end;
	if GetEditValue(ePath) = '1000' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1100');
	end;
	if GetEditValue(ePath) = '1001' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1101');
	end;
	if GetEditValue(ePath) = '0000000000000000000000000000000000000000000000000000000000000000' then begin
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetElementEditValues(CopiedRecord, 'LVLF - Flags', '1100');
	end;
end;

end.
