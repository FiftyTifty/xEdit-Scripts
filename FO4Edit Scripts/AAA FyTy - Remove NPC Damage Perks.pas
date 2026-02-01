unit userscript;
var
tstrlistPerksToRemove: TStringList;


function Initialize: integer;
begin
  tstrlistPerksToRemove := TStringList.Create;
	tstrlistPerksToRemove.LoadFromFile(ScriptsPath + '\FyTy\CreaturePerkFormIDs.txt');
end;


function Process(e: IInterface): integer;
var
	ePerks, ePerk: IInterface;
	iCounter, iListCounter: integer;
	strPerk: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
		
	ePerks := ElementByPath(e, 'Perks');
	
	for iCounter := ElementCount(ePerks) - 1 downto 0 do begin
		ePerk := ElementByIndex(ePerks, iCounter);
		strPerk := GetElementEditValues(ePerk, 'Perk');
		//AddMessage(strPerk);
		for iListCounter := 0 to tstrlistPerksToRemove.Count - 1 do begin
			if tstrlistPerksToRemove[iListCounter] = strPerk then
				RemoveElement(ePerks, iCounter);
		end;
		
	end;

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.