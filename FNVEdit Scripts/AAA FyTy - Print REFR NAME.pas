unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'REFR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	AddMessage(GetElementEditValues(e, 'NAME'));


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.