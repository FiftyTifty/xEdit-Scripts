unit userscript;
var
	strClassWork, strFurnitureSpecial,
	strWorkshopGuardObject, strWorkshopWorkObject: string;
	tstrlistKeywords: TStringList;


function Initialize: integer;
begin
	strWorkshopGuardObject := 'WorkshopGuardObject [KYWD:00069548]';
	strWorkshopWorkObject := 'WorkshopWorkObject [KYWD:00020592]';
	
	tstrlistKeywords := TStringList.Create;
	
	tstrlistKeywords.Add(strWorkshopGuardObject);
	tstrlistKeywords.Add(strWorkshopWorkObject);
end;


function Process(e: IInterface): integer;
var
	iCounter: integer;
	eKWDA, eCurrent: IInterface;
	strCurrent: string;
begin
	
	if Signature(e) <> 'FURN' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eKWDA := ElementBySignature(e, 'KWDA');
	
	for iCounter := ElementCount(eKWDA) - 1 downto 0 do begin
		eCurrent := ElementByIndex(eKWDA, iCounter);
		if tstrlistKeywords.IndexOf(GetEditValue(eCurrent)) > (-1) then
			RemoveElement(eKWDA, iCounter);
	end;
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.