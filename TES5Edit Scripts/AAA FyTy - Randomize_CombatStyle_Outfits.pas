unit userscript;

var
  RandNumberLightOutfits, RandNumberHeavyOutfits, RandNumberMageOutfits: Integer;
  RandNumber1Handed, RandNumber2Handed, RandNumberShield, i, i2, i3: Integer;
  
  eCElement, eZElement, OutfitElement, eAddItems, eWeaponIndex1, eWeaponIndex2, eShieldIndex1: IInterface;
  eAddSpells, SpellIndex: IInterface;
  
  SpellName: string;
  
  ListOfLightArmorOutfits, ListOfHeavyArmorOutfits, ListOfMageOutfits, ListOfShields, ListOf1Handed, ListOf2Handed: TStringList;
  ListOfAlteration, ListOfConjuration, ListOfDestruction, ListOfRestoration, ListOfRestDest, ListOfRestDestAlt: TStringList;


function Initialize: integer;
begin
  randomize();
  
  ListOfLightArmorOutfits := TStringList.Create;
  ListOfLightArmorOutfits.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Outfits - Light.txt');
	AddMessage('Number Of Light Armour Entries: '+IntToStr(ListOfLightArmorOutfits.Count));
//  ListOfLightArmorOutfits.sort;
  
  ListOfHeavyArmorOutfits := TStringList.Create;
  ListOfHeavyArmorOutfits.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Outfits - Heavy.txt');
	AddMessage('Number Of Heavy Armour Entries: '+IntToStr(ListOfHeavyArmorOutfits.Count));
//  ListOfHeavyArmorOutfits.sort;
  
  ListOfMageOutfits := TStringList.Create;
  ListOfMageOutfits.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Outfits - Mage.txt');
	AddMessage('Number Of Mage Clothing Entries: '+IntToStr(ListOfMageOutfits.Count));
//  ListOfMageOutfits.sort;
  
  ListOfShields := TStringList.Create;
  ListOfShields.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Shields.txt');
	AddMessage('Number Of Shield Entries: '+IntToStr(ListOfShields.Count));
//  ListOfShields.sort;
  
  ListOf1Handed := TStringList.Create;
  ListOf1Handed.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Weapons - 1Handed.txt');
	AddMessage('Number Of 1-Handed Weapon Entries: '+IntToStr(ListOf1Handed.Count));
//  ListOf1Handed.sort;
  
  ListOf2Handed := TStringList.Create;
  ListOf2Handed.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Weapons - 2Handed.txt');
	AddMessage('Number Of 2-Handed Weapon Entries: '+IntToStr(ListOf2Handed.Count));
//  ListOf2Handed.sort;
  
  ListOfAlteration := TStringList.Create;
  ListOfAlteration.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Alteration.txt');
	AddMessage('Number Of Alteration Entries: '+IntToStr(ListOfAlteration.Count));
//  ListOfAlteration.sort;
  
  ListOfConjuration := TStringList.Create;
  ListOfConjuration.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Conjuration.txt');
	AddMessage('Number Of Conjuration Entries: '+IntToStr(ListOfConjuration.Count));
//  ListOfConjuration.sort;
  
  ListOfDestruction := TStringList.Create;
  ListOfDestruction.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Destruction.txt');
	AddMessage('Number Of Destruction Entries: '+IntToStr(ListOfDestruction.Count));
//  ListOfDestruction.sort;
  
  ListOfRestoration := TStringList.Create;
  ListOfRestoration.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Restoration.txt');
	AddMessage('Number Of Restoration Entries: '+IntToStr(ListOfRestoration.Count));
//  ListOfRestoration.sort;
  
  ListOfRestDest := TStringList.Create;
  ListOfRestDest.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Rest + Dest.txt');
	AddMessage('Number Of Restoration + Destruction Entries: '+IntToStr(ListOfRestDest.Count));
//  ListOfRestDest.sort;

  
  ListOfRestDestAlt := TStringList.Create;
  ListOfRestDestAlt.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Combat Style Spells - Rest + Dest + Alt.txt');
	AddMessage('Number Of Restoration + Destruction + Alteration Entries: '+IntToStr(ListOfRestDestAlt.Count));
//  ListOfRestDestAlt.sort;

end;

procedure SetUpVariables(e: IInterface);
begin
  eCElement := ElementByPath(e, 'CNAM'); // Class
  eZElement := ElementByPath(e, 'ZNAM'); //Combat Style
  OutfitElement := ElementByPath(e, 'DOFT'); // Default Outfit
  RandNumberLightOutfits := (Random(47) + 1);
	AddMessage('Random Light Outfits Number: '+inttostr(RandNumberLightOutfits));
  RandNumberHeavyOutfits := (Random(31) + 1);
	AddMessage('Random Heavy Outfits Number: '+inttostr(RandNumberHeavyOutfits));
  RandNumberMageOutfits := (Random(27) + 1);
	AddMessage('Random Mage Outfits Number: '+inttostr(RandNumberMageOutfits));
  
  RandNumber1Handed := (Random(61) + 1);
	AddMessage('Random 1-Handed Number: '+inttostr(RandNumber1Handed));
  RandNumber2Handed := (Random(40) + 1);
	AddMessage('Random 2-Handed Number: '+inttostr(RandNumber2Handed));
  RandNumberShield := (Random(28) + 1);
	AddMessage('Random Shield Number: '+inttostr(RandNumberShield));
  
  i := 0;
  i2 := 0;
  i3 := 0;
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
    Exit;

  // comment this out if you don't want those messages
//  AddMessage('Processing: ' + FullPath(e));

	SetUpVariables(e);

  if GetEditValue(eCElement) = 'CombatAssassin "Assassin" [CLAS:0001317F]' then begin
		SetEditValue(OutfitElement, ListOfLightArmorOutfits[RandNumberLightOutfits]);
	
		eAddItems := Add(e, 'Items', false);
		eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
		SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
		SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '2');
	
		eAddSpells := Add(e, 'Actor Effects', false);
	
		if ElementCount(eAddSpells) < ListOfAlteration.Count then
			for i := 0 to ListOfAlteration.Count - 2 do begin
				ElementAssign(eAddSpells, HighInteger, nil, false);
		end;
	
	for i2 := 0 to ListOfAlteration.Count - 1 do begin
		SpellName := ListOfAlteration[i2];
		SpellIndex := ElementByIndex(ElementByPath(e, 'Actor Effects'), 0);
		SetEditValue(SpellIndex, SpellName);
	end;
	
  end;
  
  if GetEditValue(eCElement) = 'CombatBarbarian "Barbarian" [CLAS:0001CE16]' then begin
	SetEditValue(OutfitElement, ListOfLightArmorOutfits[RandNumberLightOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	ElementAssign(eAddItems, HighInteger, nil, false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	eWeaponIndex2 := ElementByIndex(eAddItems, 1);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf2Handed[RandNumber2Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Count', '1');
  end;
  
  if GetEditValue(eCElement) = 'CombatWarrior1H "Warrior" [CLAS:00013176]' then begin
	SetEditValue(OutfitElement, ListOfHeavyArmorOutfits[RandNumberHeavyOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	ElementAssign(eAddItems, HighInteger, nil, false);
	ElementAssign(eAddItems, HighInteger, nil, false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	eWeaponIndex2 := ElementByIndex(eAddItems, 1);
	eShieldIndex1 := ElementByIndex(eAddItems, 2);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Item', ListOf2Handed[RandNumber2Handed]);
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Count', '1');
	
	SetElementEditValues(eShieldIndex1, 'CNTO - Item\Item', ListOfShields[RandNumberShield]);
	SetElementEditValues(eShieldIndex1, 'CNTO - Item\Count', '1');
  end;
  
  if GetEditValue(eCElement) = 'CombatWarrior2H "Warrior" [CLAS:0001CE15]' then begin
	SetEditValue(OutfitElement, ListOfHeavyArmorOutfits[RandNumberHeavyOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	ElementAssign(eAddItems, HighInteger, nil, false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	eWeaponIndex2 := ElementByIndex(eAddItems, 1);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf2Handed[RandNumber2Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex2, 'CNTO - Item\Count', '1');
  end;
  
  if GetEditValue(eCElement) = 'CombatSpellsword "Spellsword" [CLAS:00013177]' then begin
	SetEditValue(OutfitElement, ListOfHeavyArmorOutfits[RandNumberHeavyOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	eAddSpells := Add(e, 'Actor Effects', false);
	
	if ElementCount(eAddSpells) < ListOfRestDest.Count then
		for i := 0 to ListOfRestDest.Count - 2 do begin
			ElementAssign(eAddSpells, HighInteger, nil, false);
		end;
	
	for i2 := 0 to ListOfRestDest.Count - 1 do begin
		SpellName := ListOfRestDest[i2];
		SpellIndex := ElementByIndex(ElementByPath(e, 'Actor Effects'), 0);
		SetEditValue(SpellIndex, SpellName);
	end;
		
	end;
  
  if GetEditValue(eCElement) = 'CombatWitchblade "Witchblade" [CLAS:00013178]' then begin
	SetEditValue(OutfitElement, ListOfMageOutfits[RandNumberMageOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	eAddSpells := Add(e, 'Actor Effects', false);
	
	if ElementCount(eAddSpells) < ListOfRestDest.Count then
		for i := 0 to ListOfRestDest.Count - 2 do begin
			ElementAssign(eAddSpells, HighInteger, nil, false);
		end;
	
	for i2 := 0 to ListOfRestDest.Count - 1 do begin
		SpellName := ListOfRestDest[i2];
		SpellIndex := ElementByIndex(ElementByPath(e, 'Actor Effects'), 0);
		SetEditValue(SpellIndex, SpellName);
	end;
	
  end;

  if GetEditValue(eCElement) = 'CombatRanger "Ranger" [CLAS:00013181]' then begin
	SetEditValue(OutfitElement, ListOfLightArmorOutfits[RandNumberLightOutfits]);
	
	eAddItems := Add(e, 'Items', false);
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '2');
	
  end;
  
  if GetEditValue(eCElement) = 'EncClassThalmorMelee "Thalmor Warrior" [CLAS:0007289D]' then begin
	SetEditValue(OutfitElement, ListOfLightArmorOutfits[RandNumberLightOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	eAddSpells := Add(e, 'Actor Effects', false);
	
	if ElementCount(eAddSpells) < ListOfRestoration.Count then
		for i := 0 to ListOfRestoration.Count - 2 do begin
			ElementAssign(eAddSpells, HighInteger, nil, false);
		end;
	
	for i2 := 0 to ListOfRestoration.Count - 1 do begin
		SpellName := ListOfRestoration[i2];
		SpellIndex := ElementByIndex(ElementByPath(e, 'Actor Effects'), 0);
		SetEditValue(SpellIndex, SpellName);
	end;
	
  end;

  if GetEditValue(eCElement) = 'TrainerDestructionMaster "Sorcerer" [CLAS:000E3A73]' then begin
	SetEditValue(OutfitElement, ListOfMageOutfits[RandNumberMageOutfits]);
	
	eAddItems := Add(e, 'Items', false);
	
    eWeaponIndex1 := ElementByIndex(eAddItems, 0);
	
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Item', ListOf1Handed[RandNumber1Handed]);
	SetElementEditValues(eWeaponIndex1, 'CNTO - Item\Count', '1');
	
	eAddSpells := Add(e, 'Actor Effects', false);
	
	if ElementCount(eAddSpells) < ListOfRestDestAlt.Count then
		for i := 0 to ListOfRestDestAlt.Count - 2 do begin
			ElementAssign(eAddSpells, HighInteger, nil, false);
		end;
	
	for i2 := 0 to ListOfRestDestAlt.Count - 1 do begin
		SpellName := ListOfRestDestAlt[i2];
		SpellIndex := ElementByIndex(ElementByPath(e, 'Actor Effects'), 0);
		SetEditValue(SpellIndex, SpellName);
	end;
	
  end;
  
  end;

end.