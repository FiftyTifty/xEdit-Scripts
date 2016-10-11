unit userscript;
var
	tlistEntries: TList;

function Initialize: integer;
begin
	
end;


function Process(e: IInterface): integer;
var
	eEntries, eCurrentEntry: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'LVLN' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	tlistEntries := TList.Create;
	eEntries := ElementByName(e, 'Leveled List Entries');
	
	for iCounter := Pred(ElementCount(eEntries)) downto 0 do
		tListEntries.Add(ElementByIndex(eEntries, iCounter));
	
	for iCounter := Pred(tlistEntries.Count) downto 0 do begin
		eCurrentEntry := ObjectToElement(tListEntries[iCounter]);
		SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Count', '1');
	end;
		
	tListEntries.Free;

end;


function Finalize: integer;
begin
	
	
	
end;

end.