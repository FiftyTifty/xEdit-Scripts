unit userscript;
var
	strScriptName: string;


function Initialize: integer;
begin
  strScriptName := 'cVcScripts:DeadWastelandAutoDoor';
end;


function Process(e: IInterface): integer;
var
	eScript: IInterface;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	eScript := ELementByPath(e, 'VMAD\Scripts');
	eScript := ElementByIndex(eScript, 0);
	
	if GetElementEditValues(eScript, 'scriptName') = strScriptName then
		RemoveElement(ElementByPath(e, 'VMAD\Scripts'), 0);
	
	if ElementCount(ElementByPath(e, 'VMAD\Scripts')) = 0 then
		RemoveElement(e, 'VMAD');
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.
