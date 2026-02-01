unit userscript;
var
	strTextFilePath: string;
	tstrlistText: TStringList;


function Initialize: integer;
begin
  strTextFilePath := ScriptsPath + '\FyTy\DebrisFormIDs.txt';
	
	tstrlistText := TStringList.Create;
	tstrlistText.LoadFromFile(strTextFilePath);
end;


function Process(e: IInterface): integer;
var
	iCounter: integer;
	eAdded: IInterface;
begin
	
	if Signature(e) <> 'FLST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'FormIDs') then
		RemoveElement(e, 'FormIDs');
	
	Add(e, 'FormIDs', false);
	
	SetEditValue(ElementByIndex(ElementByPath(e, 'FormIDs'), 0), tstrlistText[0]);
	
	for iCounter := 1 to tstrlistText.Count - 1 do begin
		eAdded := ElementAssign(ElementByPath(e, 'FormIDs'), HighInteger, nil, false);
		SetEditValue(eAdded, tstrlistText[iCounter]);
	end;
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.