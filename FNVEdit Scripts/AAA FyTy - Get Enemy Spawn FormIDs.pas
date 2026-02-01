unit userscript;

const
	strPathFactionsFlag = 'ACBS - Configuration\Template Flags\Use Factions';
	strPathScriptFlag = 'ACBS - Configuration\Template Flags\Use Script';

var
	tlistFactions, tlistFormIDs: TList;
	tstrlistFileNames, tstrlistRemaining, tstrlistCurrent,
	tstrlistFunctions: TStringList;
	strScriptREGEX: string;

procedure GetFilesCount(strFolderPath, WildCard: string);
var
  intFound, iListCount, iIndexFactions, iIndexFormIDs: Integer;
  SearchRec: TSearchRec;
begin

  iListCount := 0;
	
  intFound := FindFirst(strFolderPath + WildCard, faAnyFile, SearchRec);
	
  while (intFound = 0) do begin
	
    if not (SearchRec.Attr and faDirectory = faDirectory) then begin
			
			iIndexFactions := tlistFactions.Add(TStringList.Create);
			
			//AddMessage(strFolderPath + SearchRec.name);
			//AddMessage('index is: ' + IntToStr(iIndexFactions));
			
			TStringList(tlistFactions[iIndexFactions]).LoadFromFile(strFolderPath + SearchRec.Name);
			
			iIndexFormIDs := tlistFormIDs.Add(TStringList.Create);
			
			TStringList(tlistFormIDs[iIndexFormIDs]).Sorted := true;
			TStringList(tlistFormIDs[iIndexFormIDs]).Duplicates := dupIgnore;
			
			tstrlistFileNames.Add(SearchRec.Name);
			
			inc(iListCount);
			
		end;
		
    intFound := FindNext(SearchRec);
		
  end;
	
  FindClose(SearchRec);
	
end;

function Initialize: integer;
var
	iCounter: integer;
begin
	
	tListFactions := TList.Create;
	tlistFormIDs := TList.Create;
	
	tstrlistFileNames := TStringList.Create;
	tstrlistRemaining := TStringList.Create;
	tstrlistCurrent := TStringList.Create;
	
	tstrlistFunctions := TStringList.Create;
	tstrlistFunctions.LoadFromFile(ScriptsPath + 'FyTy\More Spawns\_Nasty Script Functions.txt');
	
	GetFilesCount(ScriptsPath + 'FyTy\More Spawns\FactionsToCheck\', '*');
	
	strScriptREGEX := '^[^\n;]*([^\w;](';
	//AddMessage(strScriptREGEX);
	for iCounter := 0 to tstrlistFunctions.Count - 1 do begin
	
		if iCounter < tstrlistFunctions.Count - 1 then
			strScriptREGEX := strScriptREGEX + tstrlistFunctions[iCounter] + '|'
		else
			strScriptREGEX := strScriptREGEX + tstrlistFunctions[iCounter];
	
	end;
	strScriptREGEX := strScriptREGEX + ')).*?$';
	//AddMessage(strScriptREGEX);
	
	//AddMessage(IntToStr(tlistFactions.Count));
	
end;

function IsActor(eRecord: IInterface): boolean;
var
	strSignature: string;
begin

	Result := false;
	
	strSignature := Signature(eRecord);
	
	if (strSignature = 'NPC_') or (strSignature = 'CREA') then
		Result := true;

end;

function IsRef(eRecord: IInterface): boolean;
var
	strSignature: string;
begin

	Result := false;
	
	strSignature := Signature(eRecord);
	
	if (strSignature = 'ACHR') or (strSignature = 'ACRE') then
		Result := true;

end;

function IsUselessNPC(eNPC: IInterface): boolean;
var
	strEDID: string;
begin

	Result := true;
	
	strEDID := GetElementEditValues(eNPC, 'EDID');
	
	//AddMessage(strEDID);
	
	if (pos('DEAD', strEDID) = 0) and (pos('Dead', strEDID) = 0)
		and (pos('dead', strEDID) = 0) and (pos('sleep', strEDID) = 0) and (pos('Sleep', strEDID) = 0)
		and (pos('fluff', strEDID) = 0) and (pos('loot', strEDID) = 0) and (pos('Loot', strEDID) = 0) then
			Result := false;

end;

function IsUnsafeRef(eNPC: IInterface): boolean;
var
	eReference, eScriptReferences, eCurrentRef: IInterface;
	strFullFormID: string;
	iCounter, iSubCounter, iNumReferences: integer;
begin

	Result := false;
	
	if ElementExists(eNPC, 'EDID') then begin
	
		Result := true;
		Exit;
		
	end;
	
	strFullFormID := GetElementEditValues(eNPC, 'Record Header\FormID');
	
	iNumReferences := ReferencedByCount(eNPC);
	
	if iNumReferences > 0 then	
		for iCounter := 0 to iNumReferences - 1 do begin
		
			eReference := ReferencedByIndex(eNPC, iCounter);
			
			if (Signature(eReference) = 'SCPT') then begin
				
					if ElementExists(eReference, 'References') then begin
					
						for iSubCounter := 0 to ElementCount(ElementByName(eReference, 'References')) - 1 do begin
						
							//AddMessage('Number of Script References: ' +IntToStr(iCounter));
							eScriptReferences := ElementByName(eReference, 'References');
							
							eCurrentRef := ElementByIndex(eScriptReferences, iCounter);
							
							if pos(strFullFormID, GetEditValue(eCurrentRef)) > 0 then begin
							
								Result := true;
								Exit;
								
							end;
						
						end;
					
					end;
					
			end;
		
		end;

end;

function GetFactionsTemplate(npc: IInterface): IInterface;
begin

  while (Signature(npc) = 'LVLN') or (Signature(npc) = 'LVLC') do
    npc := LinksTo(ElementByPath(npc, 'Leveled List Entries\[0]\LVLO\Reference'));
  
  if (GetElementEditValues(npc, 'ACBS\Template Flags\Use Factions') = '1') then
    Result := GetFactionsTemplate(LinksTo(ElementBySignature(npc, 'TPLT')))
  else if ( (ElementExists(npc, 'TLPT') = true) and (GetElementEditValues(npc, 'ACBS\Template Flags\Use Factions') <> '1') and (ElementExists(npc, 'FACT - Factions') = false) ) then
    Result := GetFactionsTemplate(LinksTo(ElementBySignature(npc, 'TPLT')))
	else
		Result := npc;
		
end;

function GetScriptTemplate(npc: IInterface): IInterface;
begin

  while (Signature(npc) = 'LVLN') or (Signature(npc) = 'LVLC') do
    npc := LinksTo(ElementByPath(npc, 'Leveled List Entries\[0]\LVLO\Reference'));
  
  if (GetElementEditValues(npc, 'ACBS\Template Flags\Use Script') = '1') then
    Result := GetScriptTemplate(LinksTo(ElementBySignature(npc, 'TPLT')))
  else
    Result := npc;
		
end;

function IsCodeSafe(strSourceCode: string): boolean;
var
	strFunction: string;
	iCounter: integer;
	regexp: TPerlRegEx;
begin

	Result := true;
	regexp := TPerlRegEx.Create;

	for iCounter := 0 to tstrlistFunctions.Count - 1 do begin
			
		strFunction := tstrlistFunctions[iCounter];
		
		regexp.Subject := strSourceCode;
		regexp.RegEx := strScriptREGEX;
		regexp.Options := [preUnGreedy, preMultiLine];
		
		if regexp.MatchAgain then begin
			
			Result := false;
			regexp.Free;
			Exit;
			
		end;
			
	end;
	
	//AddMessage('Script is safe!');
	regexp.Free;
		
end;

function IsCharacterScriptSafe(npc: IInterface): boolean;
var
	eSCRI, eScript: IInterface;
	strScriptSource: string;
begin

	//AddMessage(Signature(npc));
  npc := GetScriptTemplate(npc);
	
	if ElementExists(npc, 'SCRI - Script') then begin
	
		//AddMessage('=== ' + FullPath(npc) + ' ===');
		
		eSCRI := ELementBySignature(NPC, 'SCRI');
		
		eScript := LinksTo(eSCRI);
		
		strScriptSource := GetElementEditValues(eScript, 'SCTX - Script Source');
		
		Result := IsCodeSafe(strScriptSource);
		Exit;
		
	end
	else
		Result := true;
		
end;

function Process(e: IInterface): integer;
var
	eRec, eBase, eTemp, eFactions, eFaction: IInterface;
	iCounter, iSubCounter, iOverrides, iNumReferences: integer;
	strNAME, strReferenceEDID, strTemplate,
	strFaction: string;
	bFoundInList: boolean;
begin
	
	if (Signature(e) <> 'ACHR') and (Signature(e) <> 'ACRE') then
		exit;
	
	eRec := MasterOrSelf(e);
	//AddMessage('eRec is: ' + Signature(eRec));
	
	if OverrideCount(eRec) > 0 then
		eRec := WinningOverride(eRec);
	
	eBase := LinksTo(ElementByPath(eRec, 'NAME - Base'));
	//AddMessage('eBase is: ' + Signature(eBase));
	
	if IsCharacterScriptSafe(eBase) = false then
		exit;
	
	strNAME := GetElementEditValues(eRec, 'NAME - Base');
	//AddMessage('strNAME is: ' +strNAME);
	
	iNumReferences := ReferencedByCount(eBase);
	//AddMessage(IntToStr(iNumReferences));
	
	iOverrides := 0;
	bFoundInList := 0;
	
	if (iNumReferences > 1) and (IsUselessNPC(eBase) = false) then
		for iCounter := 0 to iNumReferences - 1 do begin
		
			eTemp := ReferencedByIndex(eBase, iCounter);
				
			if (IsRef(eTemp) = false) then
				Continue;
				
			if (ElementExists(eTemp, 'EDID - Editor ID')) and (IsUselessNPC(eTemp) = true) then
				Continue;
			
			if (IsUnsafeRef(eTemp) = true) then
				Continue;
			//AddMessage('iOverrides is: ' + IntToStr(iOverrides));
			
			inc(iOverrides);
			
		
		end;
	
	//AddMessage(IntToHex(GetLoadOrderFormID(eBase), 8));
	
	iCounter := 0;
	iSubCounter := 0;
	
	//AddMessage('iOverrides is: ' +IntToStr(iOverrides));
	
	if (iOverrides > 1) then begin
		
		eBase := GetFactionsTemplate(eBase);
		//AddMessage('Processing: ' + FullPath(eBase));
		
		if IsCharacterScriptSafe(eBase) = false then
			exit;
		
		if ElementExists(eBase, 'Factions') then begin
		
			//AddMessage('Has Factions!');
		
			eFactions := ElementByName(eBase, 'Factions');
			
			for iCounter := ElementCount(eFactions) - 1 downto 0 do begin
			
				//AddMessage('Getting NPC Factions!');
				
				eFaction := LinksTo(ElementByPath(ElementByIndex(eFactions, iCounter), 'Faction'));
				strFaction := GetElementEditValues(eFaction, 'EDID');
				
				//AddMessage('Faction is: ' + strFaction);
				
				iSubCounter := 0;
		
				for iSubCounter := 0 to tlistFactions.Count - 1 do begin
				
					//AddMessage('= ' + IntToStr(TStringList(tlistFactions[iSubCounter]).IndexOf(strFaction)) + ' = ');
					
					if (TStringList(tlistFactions[iSubCounter]).IndexOf(strFaction) > -1) then begin
						
						TStringList(tlistFormIDs[iSubCounter]).Add(strNAME);
						//AddMessage('Adding to unique list: ' + tstrlistFileNames[iSubCounter]  +' - ' + strNAME);
						exit;
					
					end;
				
				end;
				
			end;
			
		end
		else begin
		
			eBase := GetFactionsTemplate(eBase);
			//AddMessage('Adding: ' + strNAME + 'To tstrlistRemaining!');
			tstrlistRemaining.Add(strNAME);
		end;
		
	end;
	
end;


function Finalize: integer;
var
	iCounter: integer;
begin
	
	iCounter := tlistFactions.Count - 1;
	
	for iCounter := tlistFactions.Count - 1 downto 0 do begin
		
		TStringList(tlistFormIDs[iCounter]).SaveToFile(ScriptsPath + 'FyTy\More Spawns\' + tstrlistFileNames[iCounter]);
		
		TStringList(tlistFactions[iCounter]).Free;
		TStringList(tlistFormIDs[iCounter]).Free;
	
	end;
	
	tstrlistRemaining.SaveToFile(ScriptsPath + 'FyTy\More Spawns\xRemaining.txt');
	tstrlistRemaining.Free;
	
	tlistFormIDs.Free;
	tlistFactions.Free;
	
	tstrlistCurrent.Free;
	
	tstrlistFileNames.Free;
	
	tstrlistFunctions.Free;
	
end;


end.
