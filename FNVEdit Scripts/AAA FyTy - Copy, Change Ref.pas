unit userscript;

var
	ChDollHead, ReDollHead, ChChemTubes, ReChemTubes, ChCoffeeMaker, ReCoffeeMaker, ChCoffeeUrn, ReCoffeeUrn, ChDeckOfCards, ReDeckOfCards: string;
	ChTreeDoll, ReTreeDoll, ChFan, ReFan, ChHamRadioWithoutMic, ReHamRadioWithoutMic, ChHamRadioBlock, ReHamRadioBlock, ChHula, ReHula: string;
	ChCookingPan, ReCookingPan, ChMicroscope, ReMicroscope, ChMusicStand, ReMusicStand, ChPickaxe, RePickaxe, ChRattle, ReRattle: string;
	ChRedBall, ReRedBall, ChRollerSkate, ReRollerSkate, ChRollerBlade, ReRollerBlade, ChTelephone, ReTelephone, ChTricycle, ReTricycle: string;
	ChBigTV, ReBigTV, ChTVCracked, ReTVCracked, ChTypeWriter, ReTypeWriter, ChWoodBlock, ReWoodBlock, ChBloodySkull, ReBloodySkull: string;
	ChBrahminSkull01, ChBrahminSkull02, ReBrahminSkull: string;
	
	ChRock01, ChRock02, ChRock03, ChRock04: string;
	
	//Fuckload of strings. "Ch" is short for the word change. "Re" is short for the word replace.
	PatchFile : IInterface;
	
	function Initialize: integer; // This section is run once; when the script is applied. It does not run on every selected record.
begin

	//PatchFile := AddNewFile; // Create a new file, and allow us to reference it through the "PatchFile" variable. "AddFile" also gives a prompt to name the new file.
	PatchFile := FileByIndex(22);												// You can also reference an already-made file by changing it to: Patchfile := FileByIndex(#);
													//With # being the index of your mod.You'll have to change the index depending on how many other mods there are preceeding it.
	{AddMasterIfMissing(PatchFile, 'FalloutNV.esm'); // Adding the default TTW files, as well as TTWInteriors_Core.esm.
	AddMasterIfMissing(PatchFile, 'DeadMoney.esm');
	AddMasterIfMissing(PatchFile, 'HonestHearts.esm');
	AddMasterIfMissing(PatchFile, 'OldWorldBlues.esm');
	AddMasterIfMissing(PatchFile, 'LonesomeRoad.esm');
	AddMasterIfMissing(PatchFile, 'GunRunnersArsenal.esm');
	AddMasterIfMissing(PatchFile, 'Fallout3.esm');
	AddMasterIfMissing(PatchFile, 'Anchorage.esm');
	AddMasterIfMissing(PatchFile, 'ThePitt.esm');
	AddMasterIfMissing(PatchFile, 'BrokenSteel.esm');
	AddMasterIfMissing(PatchFile, 'PointLookout.esm');
	AddMasterIfMissing(PatchFile, 'Zeta.esm');
	AddMasterIfMissing(PatchFile, 'TaleOfTwoWastelands.esm');
	AddMasterIfMissing(PatchFile, 'TTWInteriors_Core.esm');
	SortMasters(PatchFile);} //Re-arrange the masters according to the load order. Just in case.
	
	{ChDollHead := 'DLC04DollHead [MSTT:0A00CB4F]';
	ReDollHead := 'FNVIntToyDollhead "broken Doll Head" [MISC:0D034DA9]';
	
	ChChemTubes := 'ChemTubeRack01 [STAT:00025085]';
	ReChemTubes := 'FNVIntChemTubeRack "Chem Tubes" [MISC:0D00214E]';
	
	ChCoffeeMaker := 'CoffeeBrewer01 [STAT:00034178]';
	ReCoffeeMaker := 'FNVIntCoffeeMaker01 "Coffee Maker" [MISC:0D001DFA]';
	
	ChCoffeeUrn := 'CoffeeUrn01 [STAT:0002E3B2]';
	ReCoffeeUrn := 'FNVIntCoffeeurn01 "Coffee Urn" [MISC:0D001B13]';
	
	//ChDeckOfCards := 
	//ReDeckOfCards := 'FNVIntCardDeck01 "Deck of Cards" [MISC:0D01316F]';
	
	ChTreeDoll := 'DLC04DollTree01a [STAT:0A00D7D3]';
	ReTreeDoll := 'TTWIntDLCPLTreeDoll "Doll" [MISC:0D002A1F]';
	
	ChFan := 'OfficeFan01 [MSTT:00017AC8]';
	ReFan := 'FNVIntOfficeFan01 "Fan" [MISC:0D001DFE]';
	
//ChHamRadioWithoutMic := 'clutter\hamradio\Hamradio02.NIF'
//ReHamRadioWithoutMic := 'FNVIntHamRadio02 "Ham Radio" [MISC:0D00215D]';
	
	ChHamRadioBlock := 'Hamradio03 [STAT:000EA228]';
	ReHamRadioBlock := 'FNVIntHamRadio03 "Ham Radio" [MISC:0D00215F]';
	
	ChHula := 'HulaGirl [STAT:0001E5E9]';
	ReHula := 'FNVIntHulaGirl01 "Hula Girl" [MISC:0D001E28]';
	
//ChCookingPan := 
//ReCookingPan := 'FNVIntPanCookingMetal "Metal Cooking Pan" [MISC:0D02E2EB]';
	
	ChMicroscope := 'Microscope [STAT:00078CE6]';
	ReMicroscope := 'FNVIntMicroscope01 "Microscope" [MISC:0D002146]';
	
	ChMusicStand := 'MusicStand [MSTT:0001BD7A]';
	ReMusicStand := 'FNVIntMusicStand01 "Music Stand" [MISC:0D002159]';
	
	ChPickaxe := 'Pickaxe [STAT:000E87C2]';
	RePickaxe := 'FNVIntPickAxe "Pick Axe" [MISC:0D01E146]';
	
//ChRattle := 
//ReRattle := 'FNVIntToyRattle01 "Rattle" [MISC:0D0166DA]'; 
	
	ChRedBall := 'Ball01 [MSTT:00044637]';
	ReRedBall := 'FNVIntToyBall01 "Red Ball" [MISC:0D0316AF]';
	
//ChRollerSkate := 
//ReRollerSkate := 'FNVIntToyRollerskate02 "Roller Skate" [MISC:0D0166D8]';
	
	ChRollerBlade := 'RollerSkate [MSTT:00029581]';
	ReRollerBlade := 'FNVIntToyRollerskate01 "Roller Skate" [MISC:0D0166D6]';
	
	ChTelephone := 'Telephone01 [MSTT:000389C6]';
	ReTelephone := 'FNVIntTelephone01 "Telephone" [MISC:0D001B16]';
	
	ChTricycle := 'TricycleDirty01 [MSTT:00018DD9]';
	ReTricycle := 'FNVInttricycle01 "tricycle" [MISC:0D01A974]';
	
	ChBigTV := 'TV02 [STAT:0007479A]';
	ReBigTV := 'FNVIntTVSetDirty02a "TV Set" [MISC:0D002196]';
	
	ChTVCracked := 'TVSetDirty [STAT:00093B9A]';
	ReTVCracked := 'FNVIntTVSetDirty01a "TV Set" [MISC:0D00218E]';
	
	ChTypeWriter := 'Typewriter01 [STAT:0003180E]';
	ReTypeWriter := 'FNVIntOfficeTypewriter01 "Typewriter" [MISC:0D001E02]';
	
	ChWoodBlock := 'ToyWoodenBlock [MSTT:00046219]';
	ReWoodBlock := 'FNVIntToyWoodenBlock01 "Wooden Block" [MISC:0D0166DC]';
	
	ChBloodySkull := 'SkullBloody [MSTT:000769BD]';
	ReBloodySkull := 'BodyPart05 "Mutilated Skull" [MISC:00074170]';
	
	ChBrahminSkull01 := 'BrahminSkull [MSTT:00024448]';
	ChBrahminSkull02 := 'BrahminSkullStatic [STAT:000E299C]';
	ReBrahminSkull := 'SkullBrahmin "Brahmin Skull" [MISC:0003405E]';}
	
	ChRock01 := 'RockCanyon06rad70 [STAT:0A0464C3]';
	ChRock02 := 'RockCanyon12rad68 [STAT:0A0464C7]';
	ChRock03 := 'RockCanyon19rad127 [STAT:0A0464C8]';
	
end;

var
	RecordCopy: IInterface;

function Process(e: IInterface): integer; // This runs on every record we selected.
begin
  if Signature(e) <> 'REFR' then // If it's not a REFR (reference; placed object in a cell), don't copy it.
		exit;	
		
	if GetIsPersistent(e) then // Check to see if we selected a quest item. If so, dinnae copy it.
		exit;
		
		//We'll put brackets around GetEditValue condition. When there's more than one condition, this allows for more than one. When it's solo, it keeps things easy to read.
		
	{if (GetEditValue(ElementBySignature(e, 'NAME')) = ChBrahminSkull01) or (GetEditValue(ElementBySignature(e, 'NAME')) = ChBrahminSkull02) then begin // Get the value of the element "NAME" in our record. We do this using the element's signature.
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true); // We copy the selected records to the file. Note that most things in xxxEdit is an element.
		// The vars: wbCopyElementToFile(Selected record, Our patch file variable, Don't copy as new record, Don't inherit elements from masters with same record)
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReBrahminSkull); // Change the NAME (I.E, the object) of the copied record. We made a moveable static reference into an item reference.
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChDollHead) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReDollHead);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChChemTubes) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReChemTubes);
	end;

	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChCoffeeMaker) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReCoffeeMaker);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChCoffeeUrn) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReCoffeeUrn);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChTreeDoll) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReTreeDoll);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChFan) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReFan);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChHamRadioBlock) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReHamRadioBlock);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChHula) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReHula);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChMicroscope) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReMicroscope);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChMusicStand) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReMusicStand);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChPickaxe) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), RePickaxe);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChRedBall) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReRedBall);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChRollerBlade) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReRollerBlade);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChTelephone) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReTelephone);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChTricycle) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReTricycle);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChBigTV) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReBigTV);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChBigTV) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReTVCracked);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChTypeWriter) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReTypeWriter);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChWoodBlock) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReWoodBlock);
	end;
	
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChBloodySkull) then begin
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true);
		SetEditValue(ElementBySignature(RecordCopy, 'NAME'), ReBloodySkull);
	end;}
	
end;

end.