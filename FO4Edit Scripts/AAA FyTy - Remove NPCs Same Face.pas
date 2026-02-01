unit userscript;
var
	tstrlistSortKeys: TStringList;

function Initialize: integer;
begin
  
	tstrlistSortKeys := TStringList.Create;
	
end;


function Process(e: IInterface): integer;
var
	strCombinedKeys: string;
begin
	
  
  AddMessage('Processing: ' + FullPath(e));
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	strCombinedKeys := SortKey(ElementBySignature(e, 'MSDK'), true) + '_' + SortKey(ElementBySignature(e, 'MSDV'), true);
	
	if tstrlistSortKeys.IndexOf(strCombinedKeys) <> -1 then	
		Remove(e)
	else if GetElementEditValues(e, 'ACBS\Flags\Female') <> '1' then
		Remove(e);
	
	
end;


function Finalize: integer;
begin
  
	tstrlistSortKeys.Free;
	
end;

end.