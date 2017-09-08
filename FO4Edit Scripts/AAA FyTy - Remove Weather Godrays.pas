unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'WGDR - God Rays') then
		RemoveElement(e, 'WGDR - God Rays');


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.