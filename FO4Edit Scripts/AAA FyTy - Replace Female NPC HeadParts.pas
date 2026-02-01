unit userscript;
var
	tstrlistEyes, tstrlistHair, tstrlistHairline: TStringList;
	strFemaleEyesAO, strFemaleEyesWet, strMouthShadow,
	strEyeLashes, strFemaleHeadRear, strFemaleHead, strFemaleMouth: string;

function Initialize: integer;
begin

  tstrlistEyes := TStringList.Create;
	tstrlistEyes.LoadFromFile(ScriptsPath + '\FyTy\Eyes\EyesFormIDs.txt');
	
	tstrlistHair := TStringList.Create;
	tstrlistHair.LoadFromFile(ScriptsPath + '\Fyty\Hair - Final\Hair FormIDs.txt');
	
	tstrlistHairline := TStringList.Create;
	tstrlistHairline.LoadFromFile(ScriptsPath + '\Fyty\Hair - Final\Hairline FormIDs.txt');
	
	strFemaleEyesAO := 'FemaleEyesHumanAO "FemaleEyesHumanAO" [HDPT:000F159E]';
	strFemaleEyesWet := 'FemaleEyesHumanWet "FemaleEyesHumanWet" [HDPT:0014EC22]';
	strMouthShadow := 'MouthShadowFemale "MouthShadowFemale" [HDPT:001D7F9F]';
	strEyeLashes := 'FemaleEyesHumanLashes "FemaleEyesHumanLashes" [HDPT:0004D0EC]';
	strFemaleHeadRear := 'FemaleHeadHumanRearTEMP "FemaleHeadHumanRearTEMP" [HDPT:0004D0E9]';
	strFemaleHead := 'FemaleHeadHuman "FemaleHeadHuman" [HDPT:000CFB3F]';
	strFemaleMouth := 'FemaleMouthHumanoidDefault "FemaleMouthHumanoidDefault" [HDPT:000CFB4E]';
	
end;

procedure AddHeadPart(eHeadParts: IInterface; strHeadPart: string);
var
	eHeadPart: IInterface;
begin
	
	eHeadPart := ElementAssign(eHeadParts, HighInteger, nil, false);
	SetEditValue(eHeadPart, strHeadPart);
	
end;

procedure AddRequiredHeadParts(eHeadParts: IInterface);
begin
	
	AddHeadPart(eHeadParts, strFemaleEyesAO);
	
	AddHeadPart(eHeadParts, strFemaleEyesWet);
	
	AddHeadPart(eHeadParts, strMouthShadow);
	
	AddHeadPart(eHeadParts, strEyeLashes);
	
	AddHeadPart(eHeadParts, strFemaleHeadRear);
	
	AddHeadPart(eHeadParts, strFemaleHead);
	
	AddHeadPart(eHeadParts, strFemaleMouth);
	
end;


procedure AddHairlinesFromTStringList(eHeadParts: IInterface; strHairlinesPath: string);
var
	iCounter: integer;
	tstrlistHairlines: TStringList;
begin
	tstrlistHairlines := TStringList.Create;
	tstrlistHairlines.LoadFromFile(ScriptsPath + strHairlinesPath);
	
	for iCounter := 0 to tstrlistHairlines.Count - 1 do begin
		
		AddHeadPart(eHeadParts, tstrlistHairlines[iCounter]);
		
	end;
	
	tstrlistHairlines.Free;
	
	exit;
	
end;

procedure AddHairToNPC(eHeadParts: IInterface);
var
	iRandom: integer;
	strHair, strHairline: string;
begin
	
	iRandom := Random(tstrlistHair.Count);
	strHair := tstrlistHair[iRandom];
	strHairline := tstrlistHairline[iRandom];
	
	AddHeadPart(eHeadParts, strHair);
	
	if Pos('.txt', strHairline) > 0 then
		AddHairlinesFromTStringList(eHeadParts, strHairline);
	
	if strHairline = 'nil' then
		exit;
	
	if Pos('.txt', strHairline) = 0 then
		AddHeadPart(eHeadParts, strHairline);
		
	
end;


function Process(e: IInterface): integer;
var
	eHeadParts: IInterface;
	strFullFormID: string;
	iRandom: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	Randomize;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'Head Parts') then
		RemoveElement(e, 'Head Parts');
	
	eHeadParts := Add(e, 'Head Parts', false);
	
	AddRequiredHeadParts(eHeadParts);
	
	iRandom := Random(tstrlistEyes.Count);
	AddHeadPart(eHeadParts, tstrlistEyes[iRandom]);
	
	AddHairToNPC(eHeadParts);
	
	//Now get rid of the first null head part, that was auto-created
	//when we re-added the Head Parts element
	
	RemoveByIndex(eHeadParts, 0, true);
end;


function Finalize: integer;
begin
  tstrlistEyes.Free;
	tstrlistHair.Free;
	tstrlistHairline.Free;
end;

end.
