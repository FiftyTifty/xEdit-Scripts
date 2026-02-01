unit userscript;
var
	tstrlistSource, tstrlistDest: TStringList;
	fileDest: IInterface;
	strListsLoadID: string;

function Initialize: integer;
begin

  tstrlistSource := TStringList.Create;
	tstrlistDest := TStringList.Create;
	
	tstrlistSource.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\FinalToReplace.txt');
	tstrlistDest.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\FinalReplaceWith.txt');
	
	fileDest := FileByIndex($12 + 1);
	
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

function CreateGroupIfNotPresent(strGroup: string): IwbGroupRecord;
var
	group: IwbGroupRecord;
begin

	group := GroupBySignature(fileDest, strGroup);
	
	if not Assigned(group) then
		group := Add(fileDest, strGroup, False);
		
	Result := group;

end;

function GetLastOverride(e: IInterface): IInterface;
var
	eRec: IInterface;
begin

	eRec := MasterOrSelf(e);
	//AddMessage('eRec is: ' + Signature(eRec));
	
	if OverrideCount(eRec) > 0 then
		eRec := WinningOverride(eRec);
		
	Result := eRec;

end;

function Process(e: IInterface): integer;
var
	eActor, eItems, eItem: IInterface;
	strItem, strCorrected: string;
	iCounter, iIndex: integer;
	bModified: Boolean;
begin

  if (Signature(e) <> 'NPC_') and (Signature(e) <> 'CREA') then
		exit;
		
	eActor := GetLastOverride(e);
		
	if GetElementEditValues(eActor, 'ACBS\Template Flags\Use Inventory') = '1' then
		exit;
	
	AddMessage('Passed template flag!');
	
	if ElementExists(eActor, 'Items') = false then
		exit;
	
	AddMessage('Passed Items exists!');
	
  AddMessage('Processing: ' + FullPath(eActor));
	
	eItems := ElementByPath(eActor, 'Items');
	
	for iCounter := 0 to ElementCount(eItems) - 1 do begin
	
		eItem := ElementByIndex(eItems, iCounter);
		strItem := GetElementEditValues(eItem, 'CNTO - Item\Item');
		
		iIndex := tstrlistSource.IndexOf(strItem);
		
		if iIndex > -1 then begin
			
			if bModified = false then begin
				
				if GetFileName(fileDest) <> GetFileName(GetFile(eActor)) then begin
				
					eActor := wbCopyElementToFile(eActor, fileDest, false, true);
					eItems := ElementByPath(eActor, 'Items');
					eItem := ElementByIndex(eItems, iCounter);
					
				end;
				
				bModified := true;
				
			end;
			
			strCorrected := StringReplace(tstrlistDest[iIndex], 'LVLI:12', 'LVLI:' + strListsLoadID, [false, false]);
			AddMessage(strCorrected);
			SetElementEditValues(eItem, 'CNTO - Item\Item', strCorrected);
			
		end;
	
	end;
	
end;


function Finalize: integer;
begin
  
	tstrlistDest.Free;
	tstrlistSource.Free;
	
end;

end.