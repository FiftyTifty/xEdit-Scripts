unit userscript;
var
	fileDestination: IInterface;
	tstrlistItemEntries: TList;
	bCopyToFile, bEditFlags: boolean;
	//iarrayBadLeveledLists: array [1..2] of integer;

function Initialize: integer;
begin
	fileDestination := FileByIndex(19);
	bCopyToFile := true;
	bEditFlags := false;
	
	//iarrayBadLeveledLists[1] := 00137820;
	//iarrayBadLeveledLists[2] := 17122060;
end;

{
function IsBadLeveledList(e: IInterface; iFormID: integer): boolean;
begin

	Result := false;
	
	if IntToStr(FormID(e)) = iarrayBadLeveledLists[1] then
		if GetFileName(GetFile(e)) = 'Fallout4.esm' then
			Result := true;
		
	if IntToStr(FormID(e)) = iarrayBadLeveledLists[2] then
		if GetFileName(GetFile(e)) = 'DLCCoast.esm' then
			Result := true;
		
end;
}


function Process(e: IInterface): integer;
var
	eRec, eCopiedList, eFlags, eLeveledListContainer, eLevel, eItem: IInterface;
	iPasses, iCounter, iFlagsLength: integer;
	strFlags: string;
	bBreakFlagsLoop: boolean;
begin
	
	if Signature(e) <> 'LVLI' then
		exit;
	
	if ElementExists(e, 'Leveled List Entries') = false then
		exit;
	
	//if IsBadLeveledList(e, FormID(e)) then
	//	exit;
	
	//AddMessage('Processing: ' + FullPath(e));
	eRec := MasterOrSelf(e);
	
	if OverrideCount(eRec) > 0 then
		eRec := HighestOverrideOrSelf(eRec, 255);
		//eRec := OverrideByIndex(eRec, OverrideCount(eRec) - 1);
	
	if bCopyToFile then
		eCopiedList := wbCopyElementToFile(eRec, fileDestination, false, true)
	else
		eCopiedList := eRec;
	
	if bEditFlags then
		begin
			
			if ElementExists(eCopiedList, 'LVLF - Flags') then begin
			
				eFlags := ElementBySignature(eCopiedList, 'LVLF');
				strFlags := GetEditValue(eFlags);
			
				iFlagsLength := Length(strFlags);
				
				if iFlagsLength = 2 then
					if strFlags[1] = '1' then
						if strFlags[2] = '1' then
							bBreakFlagsLoop := true;
				
				if bBreakFlagsLoop = false then
					if iFlagsLength = 2 then begin
						Delete(strFlags, 1, 1);
						Insert('1', strFlags, 1);
					end;
				
				if bBreakFlagsLoop = false then
					if iFlagsLength = 1 then
						strFlags := strFlags + '1';
				
				SetEditValue(eFlags, strFlags);
				
			end;
			
		end;
	
	
	tstrlistItemEntries := TList.Create;
	//AddMessage('Created the list!');
	
	// Since Leveled Lists reset the order of each entry in the list when they're changed.
	// We'll use a neat workaround; if we add the entry to a TStringList, and modify the data
	// through a proxy, we can edit the data without resetting the list's index.
	// Funky, but it works.
	eLeveledListContainer := ElementByName(eCopiedList, 'Leveled List Entries');
	
	for iCounter := Pred(ElementCount(eLeveledListContainer)) downto 0 do 
		tstrlistItemEntries.Add(ElementByIndex(eLeveledListContainer, iCounter));
	
	for iCounter := Pred(tstrlistItemEntries.Count) downto 0 do begin
		eItem := ObjectToElement(tstrlistItemEntries[iCounter]);
		SetElementNativeValues(eItem, 'LVLO\Level', '1');
	end;
	
	tstrlistItemEntries.Free;
end;

end.
