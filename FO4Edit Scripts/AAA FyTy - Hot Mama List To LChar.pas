unit userscript;
var
	strFind, strReplace: string;
	iSuffix: integer;
	tstrlistLeveledLists: TStringList;
	fileDestination: IInterface;

function Initialize: integer;
begin
	
	iSuffix := 001;
	strFind := '001';
	
	tstrlistLeveledLists := TStringList.Create;
	tstrlistLeveledLists.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Hot Mama Leveled Lists.txt');
	
	fileDestination := FileByIndex(9);
	
end;


function Process(eBaseLChar: IInterface): integer;
var
	strSuffix, strEDID, strBaseEDID, strNewEDID: string;
	eNewLChar: IInterface;
	iCounter: integer;
begin
	
	if Signature(eBaseLChar) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(eBaseLChar));
	
	strEDID := GetEditValue(ElementBySignature(eBaseLChar, 'EDID'));
	
	
	strBaseEDID := Delete(strEDID, Length(strEDID) - 2, 3);
	
	AddMessage(strEDID);
	
	for iCounter := 0 to tstrlistLeveledLists.Count - 1 do begin
		
	inc(iSuffix);
	strSuffix := Format('%0.3d',[iSuffix]);
	strNewEDID := strBaseEDID + strSuffix;
	
	eNewLChar := wbCopyElementToFile(eBaseLChar, fileDestination, true, true);
	
	SetElementEditValues(eNewLChar, 'TPTA - Template Actors\Traits', tstrlistLeveledLists[iCounter]);
	SetEditValue(ElementBySignature(eNewLChar, 'EDID'), strNewEDID);
		
	end;
	

end;


function Finalize: integer;
begin
	
	
	
end;

end.