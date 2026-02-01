unit userscript;
var
	tstrlistFactions, tstrlistWeapons: TStringList;

function Initialize: integer;
begin
  
	tstrlistFactions := TStringList.Create;
	tstrlistWeapons := TStringList.Create;
	tstrlistFactions.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\MeleeFactions.txt');
	tstrlistWeapons.LoadFromFile(ScriptsPath + 'FyTy\NPCsUseAmmo\MeleeFactionsWeapons.txt');
	
end;

function FindRecordUntilHasFaction(e: IInterface): IInterface;
begin

	if (Signature(e) = 'LVLN') or (Signature(e) = 'LVLC') then begin
	
		AddMessage('FindRecordUntilHasFaction - Signature: ' + Signature(e));
		FindRecordUntilHasFaction(LinksTo(ElementByPath(e, 'Leveled List Entries\[0]\LVLO - Base Data\Reference')));
	
	end;
	
	if (Signature(e) = 'NPC_') or (Signature(e) = 'CREA') then begin
	
		if GetElementEditValues(e, 'ACBS - Configuration\Template Flags\Use Factions') <> '1' then begin
			//AddMessage('FindRecordUntilHasFaction - Does not have template factions! ' + GetElementEditValues(e, 'ACBS - Configuration\Template Flags\Use Factions'));
			Result := e;
			
		end
		else begin
		
			//AddMessage('FindRecordUntilHasFaction - Has template factions! ' + GetElementEditValues(e, 'ACBS - Configuration\Template Flags\Use Factions'));
			FindRecordUntilHasFaction(LinksTo(ElementByPath(e, 'ACBS - Configuration\TPLT - Template')));
			
		end;
	
	end;

end;

function Process(e: IInterface): integer;
var
	eItems, eFactions, eEntry, eRecWithFactions: IInterface;
	iCounter, iIndex: integer;
	strItem: string;
begin

	if (Signature(e) <> 'NPC_') and (Signature(e) <> 'CREA') then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	eItems := ElementByPath(e, 'Items');
	
	for iCounter := 0 to ElementCount(eItems) do begin
	
		eEntry := ElementByIndex(eItems, iCounter);
		
		if Pos('Melee', GetElementEditValues(eEntry, 'CNTO - Item\Item')) > 0 then
			exit;
	
	end;
	
	//Didn't exit, so needs a melee weapon added
	
	if GetElementEditValues(e, 'ACBS - Configuration\Template Flags\Use Factions') = '1' then
		eRecWithFactions := FindRecordUntilHasFaction(e)
	else
		eRecWithFactions := e;
	
	eFactions := ElementByPath(e, 'Factions');
	
	for iCounter := 0 to ElementCount(eFactions) - 1 do begin
	
		eEntry := ElementByIndex(eFactions, iCounter);
		
		iIndex := tstrlistFactions.IndexOf(GetElementEditValues(eEntry, 'Faction'));
		
		if iIndex > -1 then
			break;
	
	end;
	
	if iIndex > -1 then
		strItem := tstrlistWeapons[iIndex]
	else begin
		AddMessage('No valid factions for: ' + FullPath(e));
		AddMessage('Checked: ' + FullPath(eRecWithFactions));
		strItem := 'LL2Tier1MeleeWasteland [LVLI:001776D1]';
	end;
	
	eEntry := ElementAssign(eItems, HighInteger, nil, false);
	
	SetElementEditValues(eEntry, 'CNTO - Item\Item', strItem);
	SetElementEditValues(eEntry, 'CNTO - Item\Count', '1');
	

end;

function Finalize: integer;
begin
  
	tstrlistWeapons.Free;
	tstrlistFactions.Free;
	
end;

end.