unit userscript;
var
	tstrlistHairFormIDs, tstrlistHairlineFormIDs: TStringList;
	strWorkingPath: string;

function Initialize: integer;
begin
	
	tstrlistHairFormIDs := TStringList.Create;
	tstrlistHairlineFormIDs := TStringList.Create;
	
	strWorkingPath := ProgramPath + 'Edit Scripts\FyTy\Hair\';
	
	tstrlistHairFormIDs.LoadFromFile(strWorkingPath + 'Hair FormIDs.txt');
	tstrlistHairlineFormIDs.LoadFromFile(strWorkingPath + 'Hairline FormIDs.txt');
	
end;

procedure AddHair(eHeadParts: IInterface);
var
	eCurrentHairPart: IInterface;
	iRandIndex: integer;
	strHairline: string;
begin
	
	iRandIndex := Random(tstrlistHairFormIDs.Count);
	
	eCurrentHairPart := ElementAssign(eHeadParts, HighInteger, nil, false);
	SetEditValue(eCurrentHairPart, tstrlistHairFormIDs[iRandIndex]);
	
	strHairline := tstrlistHairlineFormIDs[iRandIndex];
	
	if strHairline <> 'nil' then
		AddHairline(eHeadParts, strHairline);
	
end;

procedure AddHairline(eHeadParts: IInterface; strHairline: string);
var
	eCurrentHairPart: IInterface;
	tstrlistHairlineGroup: TStringList;
	iCounter: integer;
begin
	
	if Pos('.txt', strHairline) > 0 then begin
		tstrlistHairlineGroup := TStringList.Create;
		tstrlistHairlineGroup.LoadFromFile(strWorkingPath + strHairline);
		
		for iCounter := 0 to tstrlistHairlineGroup.Count - 1 do begin
			eCurrentHairPart := ElementAssign(eHeadParts, HighInteger, nil, false);
			SetEditValue(eCurrentHairPart, tstrlistHairlineGroup[iCounter]);
		end;
	
		tstrlistHairlineGroup.Free;
		
	end
	else begin
		eCurrentHairPart := ElementAssign(eHeadParts, HighInteger, nil, false);
		SetEditValue(eCurrentHairPart, strHairline);
	end;
	
end;

procedure RemoveHairStuff(eHeadParts: IInterface);
var
	eCurrentHairPart: IInterface;
	iCounter, iDummy: integer;
begin
	
	for iCounter := Pred(ElementCount(eHeadParts)) downto 0 do begin
	
		eCurrentHairPart := ElementByIndex(eHeadParts, iCounter);
		
		if tstrlistHairFormIDs.Find(GetEditValue(eCurrentHairPart), iDummy) then
			Remove(eCurrentHairPart)
		else if tstrlistHairlineFormIDs.Find(GetEditValue(eCurrentHairPart), iDummy) then
			Remove(eCurrentHairPart);
			
	end;
	
end;

function Process(e: IInterface): integer;
var
	eHeadParts: IInterface;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eHeadParts := ElementByPath(e, 'Head Parts');
	
	RemoveHairStuff(eHeadParts);
	AddHair(eHeadParts);

end;


function Finalize: integer;
begin
	
	tstrlistHairFormIDs.Free;
	tstrlistHairlineFormIDs.Free;
	
end;

end.