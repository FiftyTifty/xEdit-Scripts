unit userscript;
var
	fileDestination, eBaseLvlList, eBaseLvlChar: IInterface;
	tstrlistFormIDs: TStringList;
	tlistLvlListEntry: TList;
	bBuildLists, bEditLists: boolean;
	iTally: integer;

function Initialize: integer;
begin
	
	bBuildLists := false;
	bEditLists := true;
	
	fileDestination := FileByIndex(9);
	eBaseLvlList := RecordByFormID(fileDestination, 134237794, false);
	eBaseLvlChar := RecordByFormID(fileDestination, 134237793, false);
	
	tstrlistFormIDs := TStringList.Create;
	tstrlistFormIDs.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Hot Mama FormIDs.txt');
	
	iTally := 0;
	
	if bEditLists = false then
		if bBuildLists then
			BuildLeveledLists;
	
	
end;


Procedure BuildLeveledLists;
var
	eCurrentListRecord, eListEntries, eCurrentEntry, eEmptyElement: IInterface;
	iCounter, iNumEntries: integer;
begin

	
	iNumEntries := 1;
	
	eCurrentListRecord := wbCopyElementToFile(eBaseLvlList, fileDestination, true, true);
	eListEntries := ElementByPath(eCurrentListRecord, 'Leveled List Entries');
	eEmptyElement := ElementByIndex(eListEntries, 1);
	
	
	for iCounter := 0 to tstrlistFormIDs.Count - 1 do begin
	
		ElementAssign(eListEntries, HighInteger, nil, false);
		
		
		inc(iNumEntries);
		
		
		if iNumEntries > 20 then begin
		
			eCurrentListRecord := wbCopyElementToFile(eBaseLvlList, fileDestination, true, true);
			eListEntries := ElementByPath(eCurrentListRecord, 'Leveled List Entries');
			iNumEntries := 1;
			
		end;
		
	end;
	
	exit;

end;


function Process(e: IInterface): integer;
var
	eListEntries, eCurrentEntry: IInterface;
	iCounter: integer;
begin
	
	if bEditLists = false then
		exit;
	
	if Signature(e) <> 'LVLN' then
		exit;
	
	AddMessage('Processing: ' + FullPath(e));
	
	eListEntries := ElementByPath(e, 'Leveled List Entries');
	
	tlistLvlListEntry := TList.Create;
	
	for iCounter := Pred(ElementCount(eListEntries)) downto 0 do begin
		eCurrentEntry := ElementByIndex(eListEntries, iCounter);
		tlistLvlListEntry.Add(eCurrentEntry);
	end;
		
	
	for iCounter := Pred(tlistLvlListEntry.Count) downto 0 do begin
		
		if iTally > tstrlistFormIDs.Count then
			exit;
		
		eCurrentEntry := ObjectToElement(tlistLvlListEntry[iCounter]);
		SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Reference', tstrlistFormIDs[iTally]);
		Inc(iTally);
		
	end;
	
	
	tlistLvlListEntry.Free;
	
end;


function Finalize: integer;
begin
	
	tstrlistFormIDs.Free;
	
end;

end.