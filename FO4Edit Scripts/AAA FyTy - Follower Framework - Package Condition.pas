unit userscript;
var
	strTokenFormID: string;

function Initialize: integer;
begin
  strTokenFormID := 'AAAFyTy_FollowerFramework_NPCToken [MISC:080380FD]';
end;


function Process(e: IInterface): integer;
var
	eCondition: IInterface;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eCondition := ElementByPath(e, 'Conditions');
	eCondition := ElementByIndex(eCondition, 0);
	eCondition := ElementByPath(eCondition, 'CTDA - ');
	
	SetElementEditValues(eCondition, 'Function', 'GetItemCount');
	SetElementEditValues(eCondition, 'Referenceable Object', strTokenFormID);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.