unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	strNAME: string;
begin
	
	if Signature(e) <> 'REFR' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	strName := GetElementEditValues(e, 'NAME');
	if Pos('Error:', strNAME) > 0 then
		RemoveNode(e);


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.