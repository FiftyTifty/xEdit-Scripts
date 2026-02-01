unit userscript;

const
	strMyEDIDPath = ScriptsPath + 'FyTy\Movable Statics To Items\My EDIDs to Replace.txt';
	strSourceEDIDPath = ScriptsPath + 'FyTy\Movable Statics To Items\Source EDIDs to Replace.txt';

var
	tstrlistMyEDIDs, tstrlistSourceEDIDs, tstrlistReferences: TStringList;
	
function Initialize: integer;
begin

	tstrlistMyEDIDs := TStringList.Create;
	tstrlistSourceEDIDs := TStringList.Create;
	
	tstrlistMyEDIDs.LoadFromFile(strMyEDIDPath);
	tstrlistSourceEDIDs.LoadFromFile(strSourceEDIDPath);
	
	tstrlistReferences := TStringList.Create;
	
end;


function Process(e: IInterface): integer;
var
	iCounter, iSubCounter: integer;
	eLVLIToTakeFrom, eEntriesSource, eAdded: IInterface;
	strFormID: string;
begin

	if Signature(e) <> 'LVLI' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	strFormID := FormID(e);
	tstrlistReferences.Clear;
	
	for iCounter := 0 to tstrlistSourceEDIDs.Count - 1 do begin
		
		if tstrlistSourceEDIDs[iCounter] = strFormID then begin
		
			eLVLIToTakeFrom := RecordByFormID(GetFile(e), StrToInt(tstrlistMyEDIDs[iCounter]), false);
			eEntriesSource := ElementByPath(eLVLIToTakeFrom, 'Leveled List Entries');
			
			for iSubCounter := 0 to ElementCount(eEntriesSource) - 1 do				
				tstrlistReferences.Add(GetElementEditValues(ElementByIndex(eEntriesSource, iSubCounter), 'LVLO\Reference'));
			
			for iSubCounter := 0 to tstrlistReferences.Count - 1 do begin
			
				eAdded := ElementAssign(ElementByPath(e, 'Leveled List Entries'), HighInteger, nil, false);
				SetElementEditValues(eAdded, 'LVLO\Reference', tstrlistReferences[iSubCounter]);
				SetElementEditValues(eAdded, 'LVLO\Level', '1');
				SetElementEditValues(eAdded, 'LVLO\Count', '1');
				
			end;
			
		end;
		
	end;


end;


function Finalize: integer;
begin

	tstrlistSourceEDIDs.Free;
	tstrlistMyEDIDs.Free;
	tstrlistReferences.Free;
	
end;

end.