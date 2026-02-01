unit userscript;
const
	iFormID = $0E008BC3;
var
	eFormList: IInterface;
	eFormIDs: IInterface;

function Initialize: integer;
begin
  
	eFormList := RecordByFormID(FileByIndex($0E + 1), iFormID, false);
	
	if ElementExists(eFormList, 'FormIDs') = false then
		eFormIDs := Add(eFormList, 'FormIDs', false)
	else
		eFormIDs := ElementByName(eFormList, 'FormIDs');
	
	//AddMessage(GetElementEditValues(eFormList, 'EDID'));
	
end;

function Process(e: IInterface): integer;
var
	eEntry: IInterface;
begin


  //AddMessage('Processing: ' + FullPath(e));
	
	eEntry := ElementAssign(eFormIDs, HighInteger, nil, False);

	SetEditValue(eEntry, GetElementEditValues(e, 'Record Header\FormID'));

end;


function Finalize: integer;
begin

	if GetEditValue(ElementByIndex(eFormIDs, 0)) = 'NULL - Null Reference [00000000]' then
		RemoveByIndex(eFormIDs, 0, true); 
	
end;

end.