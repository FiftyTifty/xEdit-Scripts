unit userscript;

var
	tstrlistOriginal, tstrlistReplace: TStringList;
	//tstrlistOriginal Will contain all the NAME values that we're looking for.
	//tstrlistReplace Will contain the ones we want to change them to.
	
	//It's done on a line by line basis. The script looks through each line in
	//tstrlistOriginal. Once it finds a match with the currently selected record,
	//it looks in tstrlistReplace at the same line number, to get the replacement.
	iNumEntriesInList: integer;

function Initialize: integer;
begin

	tstrlistOriginal := TStringList.Create;
	tstrlistOriginal.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NAME Replace - Source.txt');
	
	tstrlistReplace := TStringList.Create;
	tstrlistReplace.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NAME Replace - Replacement.txt');
	
	iNumEntriesInList := tstrlistOriginal.Count;
	
end;


function Process(e: IInterface): integer;
var
	eName: IInterface;
	strName: string;
	iCounter: integer;
begin
	
	if Signature(e) <> 'ACHR' then
		if Signature(e) <> 'REFR' then
			exit;
	
  AddMessage('Processing: ' + FullPath(e));

	eName := ElementBySignature(e, 'NAME');
	strName := GetEditValue(eName);
	
	
	for iCounter := 0 to iNumEntriesInList - 1 do begin
	
		if strName = tstrlistOriginal[iCounter] then
			SetEditValue(eName, tstrlistReplace[iCounter]);
			
	end;
	
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.