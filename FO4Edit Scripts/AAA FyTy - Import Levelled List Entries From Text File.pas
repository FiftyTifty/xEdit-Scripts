unit userscript;

var
FormIDList: TStringList;
ePath: IInterface;
eString, NewString: string;
i, iInt: integer;
bAddedEmptyEntries: boolean;


function Initialize: integer;
begin
	FormIDList := TStringList.Create;
	FormIDList.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Clothes FormIDs.txt');
	
	AddMessage('First Clothing is: '+FormIDList[0]);
end;


function AddToLeveledListWithoutEntries(e: IInterface): integer;
begin
	Add(e, 'Leveled List Entries', false);
	
	for i := 0 to FormIDList.Count - 2 do begin
		ElementAssign(ElementByPath(e, 'Leveled List Entries'), HighInteger, nil, false);
	end;
	
	bAddedEmptyEntries := true;
end;


function AddToLeveledListWithEntries(e: IInterface): integer;
begin	
	for i := 0 to FormIDList.Count - 2 do begin
		ElementAssign(ElementByPath(e, 'Leveled List Entries'), HighInteger, nil, false);
	end;
	AddMessage(IntToStr(FormIDList.Count));
	bAddedEmptyEntries := true;
end;


function EditAddedLevelledListEntries(e: IInterface): integer;
begin
	for iInt := 0 to (ElementCount(ElementByPath(e, 'Leveled List Entries')) - 1) do begin
		ePath := ElementByIndex(ElementByPath(e, 'Leveled List Entries'), 0);
		
		AddMessage('Index is: '+IntToStr(IndexOf(ElementByPath(e, 'Leveled List Entries'), ePath)));
		AddMessage('Current Reference is: '+GetEditValue(ElementByPath(ePath, 'LVLO - Base Data\Reference')));
		
		NewString := FormIDList[iInt];
		AddMessage('Replacement String is: '+NewString);
		AddMessage('ePath is: '+Path(ePath));
		
		SetElementEditValues(ePath, 'LVLO - Base Data\Level', '1');
		SetElementEditValues(ePath, 'LVLO - Base Data\Reference', NewString);
		
		AddMessage('Added '+FormIDList[iInt]);
		AddMessage('Changed to: '+GetElementEditValues(ePath, 'LVLO - Base Data\Reference'));
	end;
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'LVLI' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	if (ElementExists(e, 'Leveled List Entries') = false) and (bAddedEmptyEntries = false) and (ElementCount(ElementByPath(e, 'Leveled List Entries')) <= 1) then
		AddToLeveledListWithoutEntries(e);
	
	if (ElementExists(e, 'Leveled List Entries')) and (bAddedEmptyEntries = false) and (ElementCount(ElementByPath(e, 'Leveled List Entries')) <= 1) then
		AddToLeveledListWithEntries(e);
	
	EditAddedLevelledListEntries(e);
end;


function Finalize: integer;
begin

end;

end.
