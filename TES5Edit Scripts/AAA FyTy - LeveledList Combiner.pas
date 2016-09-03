unit userscript;

var
	NewLList, MyFile, OrigLListEntries: IInterface;
	OriginalEDID, Prefix, Suffix, NewEDID, NewFormID: string;
	i: integer;

function Initialize: integer;
begin
  Prefix := 'aaa_FyTy_';
	MyFile := FileByIndex(6);
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'LVLN' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	OriginalEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	OrigLListEntries := ElementByPath(e, 'Leveled List Entries');
	//Setting variables
	
	NewLList := wbCopyElementToFile(e, MyFile, true, true);
	//Creating new record
	NewEDID := SetElementEditValues(NewLList, 'EDID', ''+Prefix+OriginalEDID);
	NewFormID := GetElementEditValues(NewLList, 'Record Header\FormID');
	//Changing EDID of new record
	
	AddMessage('Number of entries: '+inttostr(ElementCount(OrigLListEntries)));
	
	for i := ElementCount(OrigLListEntries) - 1 downto 1 do begin
		//RemoveByIndex(OrigLListEntries, i, true);
		Remove(ElementByIndex(OrigLListEntries, i));
		
		AddMessage('Removed Entry No. '+inttostr(i));
	end;
	
	AddMessage('Finished Removing Entries');
	
	SetEditValue(ElementByPath(ElementByIndex(OrigLListEntries, 0), 'LVLO - Base Data\Reference'), NewFormID);
	SetEditValue(ElementByPath(ElementByIndex(OrigLListEntries, 0), 'LVLO - Base Data\Count'), '5');
	
	AddMessage('Added New Record As Entry To Original');	

end;


end.
