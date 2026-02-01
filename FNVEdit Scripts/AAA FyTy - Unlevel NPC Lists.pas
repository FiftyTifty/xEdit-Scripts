unit userscript;
var
	fileDestination: IInterface;
	tstrlistNPCEntries: TStringList;
	bCopyToFile, bEditFlags: boolean;

function Initialize: integer;
begin
	fileDestination := FileByIndex(19);
	bCopyToFile := true;
	bEditFlags := false;
end;


function Process(e: IInterface): integer;
var
	eRec, eCopiedList, eFlags, eLeveledListContainer, eLevel, eActor: IInterface;
	iCounter, iFlagsLength: integer;
	strFlags: string;
	bBreakFlagsLoop: boolean;
begin
	
	if Signature(e) <> 'LVLN' then
		exit;
	
	if ElementExists(e, 'Leveled List Entries') = false then
		exit;
	
	//AddMessage('Processing: ' + FullPath(e));
	
	eRec := MasterOrSelf(e);
	
	if OverrideCount(eRec) > 0 then
		eRec := HighestOverrideOrSelf(eRec, 255);
	
	if bCopyToFile then
		eCopiedList := wbCopyElementToFile(eRec, fileDestination, false, true)
	else
		eCopiedList := eRec;
	
	if bEditFlags then begin
		eFlags := ElementBySignature(eCopiedList, 'LVLF');
		
		SetElementEditValues(eFlags, 'Calculate from all levels <= player''s level', 'true');
	end;
			
	
	tstrlistNPCEntries := TList.Create;
	//AddMessage('Created the list!');
	
	// Since Leveled Lists reset the order of each entry in the list when they're changed.
	// We'll use a neat workaround; if we add the entry to a TStringList, and modify the data
	// through a proxy, we can edit the data without resetting the list's index.
	// Funky, but it works.
	eLeveledListContainer := ElementByName(eCopiedList, 'Leveled List Entries');
	
	for iCounter := Pred(ElementCount(eLeveledListContainer)) downto 0 do 
		tstrlistNPCEntries.Add(ElementByIndex(eLeveledListContainer, iCounter));
	
	for iCounter := Pred(tstrlistNPCEntries.Count) downto 0 do begin
		eActor := ObjectToElement(tstrlistNPCEntries[iCounter]);
		SetElementNativeValues(eActor, 'LVLO\Level', '1');
	end;
	
	tstrlistNPCEntries.Free;
end;

end.
