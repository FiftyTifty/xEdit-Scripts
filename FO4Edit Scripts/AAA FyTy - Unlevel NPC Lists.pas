unit userscript;
var
	fileDestination: IInterface;
	tstrlistNPCEntries: TStringList;
	bCopyToFile, bEditFlags: boolean;

function Initialize: integer;
begin
	fileDestination := FileByIndex(9);
	bCopyToFile := true;
	bEditFlags := true;
end;


function Process(e: IInterface): integer;
var
	eCopiedList, eFlags, eLeveledListContainer, eLevel, eActor: IInterface;
	iCounter, iFlagsLength: integer;
	strFlags: string;
	bBreakFlagsLoop: boolean;
begin
	
	if Signature(e) <> 'LVLN' then
		exit;
	
	if ElementExists(e, 'Leveled List Entries') = false then
		exit;
	
	//AddMessage('Processing: ' + FullPath(e));
	
	if bCopyToFile then
		eCopiedList := wbCopyElementToFile(e, fileDestination, false, true)
	else
		eCopiedList := e;
	
	if bEditFlags then
		begin
		
			if ElementExists(eCopiedList, 'LVLF - Flags') then begin
			
				eFlags := ElementBySignature(eCopiedList, 'LVLF');
				strFlags := GetEditValue(eFlags);
			
				iFlagsLength := Length(strFlags);
				
				if iFlagsLength > 0 then
					if strFlags[1] = '1' then
						//if strFlags[2] = '1' then
							bBreakFlagsLoop := true;
				
				if bBreakFlagsLoop = false then
					if iFlagsLength = 2 then begin
						Delete(strFlags, 1, 1);
						Insert('1', strFlags, 1);
					end;
				{
				if bBreakFlagsLoop = false then
					if iFlagsLength = 1 then
						strFlags := strFlags + '1';
				}
				SetEditValue(eFlags, strFlags);
				
			end;
			
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