unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'INFO' then exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	RemoveElement(e, 'Conditions');
	RemoveElement(e, 'Script (Begin)');
	RemoveElement(e, 'Script (End)');

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.