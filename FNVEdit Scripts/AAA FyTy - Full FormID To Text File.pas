unit userscript;
var
	tstrlistText: TStringList;
	strFilePath: string;

function Initialize: integer;
begin

	tstrlistText := TStringList.Create;
	strFilePath := ScriptsPath + 'FyTy\TTWInteriors\Item_FormIDs_Dest.txt';
	
end;

function Process(e: IInterface): integer;
var
	eHeadParts: IInterface;
	strFullFormID: string;
	iCounter, iNumUsedBy, iNumREFRs: integer;
	bAddToTheList: boolean;
begin
	
	AddMessage('Processing: ' + FullPath(e));
	{
	iNumUsedBy := ReferencedByCount(e);
	
	for iCounter := 0 to iNumUsedBy - 1 do begin
		if Signature(ReferencedByIndex(e, iCounter)) = 'REFR' then
			Inc(iNumREFRs);
	end;
	
	if iNumREFRs > 1 then begin
	
		strFullFormID := GetElementEditValues(e, 'Record Header\FormID');
		tstrlistText.Add(strFullFormID);
		
		AddMessage('Added FullFormID');
	
	end;
	}
	
	strFullFormID := GetElementEditValues(e, 'Record Header\FormID');
	tstrlistText.Add(strFullFormID);

end;


function Finalize: integer;
begin
	tstrlistText.SaveToFile(strFilePath);
end;

end.
