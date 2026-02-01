unit userscript;
const
	strMop = 'AAAFyTyMiscFlatMop01 "Flat Mop" [MISC:0D013932]';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'REFR' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	if GetElementEditValues(e, 'NAME - Base') = strMop then
		RemoveNode(e);
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.