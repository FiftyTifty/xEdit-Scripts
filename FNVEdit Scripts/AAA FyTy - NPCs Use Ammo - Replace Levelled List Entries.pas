unit userscript;
var
	tstrlistSource, tstrlistDest: TStringList;
	strListsLoadID: string;

function Initialize: integer;
begin
  
	tstrlistSource := TStringList.Create;
	tstrlistDest := TStringList.Create;
	
	tstrlistSource.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\FinalToReplace.txt');
	tstrlistDest.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\FinalReplaceWith.txt');
	
	strListsLoadID := GetFileLoadID('FyTy - NPCs Use Ammo.esp');
	
end;

function GetFileLoadID(strToFind: string): string;
var
	iCounter: integer;
begin

	for iCounter := 0 to FileCount - 1 do begin
	
		if GetFileName(FileByIndex(iCounter)) = strToFind then begin
		
			Result := IntToHex(iCounter  - 1, 2);
			Exit;
		
		end;
	
	end;

end;

function Process(e: IInterface): integer;
var
	eEntries, eEntry: IInterface;
	strEntry, strCorrected: string;
	iCounter, iIndex: integer;
begin

	if Signature(e) <> 'LVLI' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eEntries := ElementByPath(e, 'Leveled List Entries');
	
	for iCounter := 0 to ElementCount(eEntries) - 1 do begin
	
		eEntry := ElementByIndex(eEntries, iCounter);
		strEntry := GetElementEditValues(eEntry, 'LVLO - Base Data\Reference');
		
		iIndex := tstrlistSource.IndexOf(strEntry);
		
		if iIndex > -1 then begin
			
			strCorrected := StringReplace(tstrlistDest[iIndex], 'LVLI:12', 'LVLI:' + strListsLoadID, [false, false]);
			AddMessage(strCorrected);
			SetElementEditValues(eEntry, 'LVLO - Base Data\Reference', strCorrected);
			
		end;
	
	end;

end;

function Finalize: integer;
begin

  Result := 0;
	
end;

end.