unit UserScript;

var
	ItemsInOutfitList: TStringList;

function Initialize: integer;

begin
  AddMessage('Begun')
end;

function Process(e: IInterface): integer;

var
	DOutfit, OutfitItemsPath, NPCItemsPath, OutfitItem, NPCAssignedItem: IInterface;
	i, iSecond, iThird: integer;
	ItemString, OutfitItemString: string;

begin
    if Signature(e) <> 'NPC_' then
  Exit;

  AddMessage('Processing: ' + FullPath(e));
	
	ItemsInOutfitList := TStringList.Create;
	
	DOutfit := ElementBySignature(e, 'DOFT');
	//AddMessage('Set the DOutfit variable to DOFT element');
	
	OutfitItemsPath := ElementBySignature(LinksTo(DOutfit), 'INAM');
	//AddMessage('Set the OutfitItemsPath variable to referenced outfit records items element');
	
	if not ElementExists(e, 'Items') then begin
		//AddMessage('Items element doesnt exist. Adding.');
		Add(e, 'Items', false);
	end;
	
	NPCItemsPath := ElementByPath(e, 'Items');
	//AddMessage('Set the NPCItemsPath variable to Items element');
	
	for i := 0 to ElementCount(OutfitItemsPath) - 1 do begin
		//AddMessage('Beginning loop to add strings to list');
		OutfitItem := ElementByIndex(OutfitItemsPath, i);
		OutfitItemString := GetEditValue(OutfitItem);
		ItemsInOutfitList.Add(OutfitItemString);
		//AddMessage('Loop no.'+inttostr(i));

		if i = ElementCount(OutfitItemsPath) - 1 then begin
			AddMessage('First loop has finished');
		end;
		
	end;
	
	AddMessage('Finished adding item strings to list');
	
	for iSecond := 0 to ItemsInOutfitList.Count - 1 do begin
		//AddMessage('Beginning loop to add items to NPC');
		NPCAssignedItem := ElementAssign(NPCItemsPath, HighInteger, nil, false);
		SetElementEditValues(NPCAssignedItem, 'CNTO - Item\Item', ItemsInOutfitList[iSecond]);
		SetElementEditValues(NPCAssignedItem, 'CNTO - Item\Count', '1');
		//AddMessage('Adding items. Loop no.'+inttostr(iSecond));
	end;
	
	//AddMessage('Removing null item');
	RemoveByIndex(NPCItemsPath, 0, true);
	Remove(DOutfit);
	
	ItemsInOutfitList.Free;
 end;
 
end.