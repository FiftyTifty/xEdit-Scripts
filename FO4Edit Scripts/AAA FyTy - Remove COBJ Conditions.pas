unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'COBJ' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	//RemoveElement(ElementByPath(e, 'Conditions'), 1);
	RemoveElement(e, 'Conditions');
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.