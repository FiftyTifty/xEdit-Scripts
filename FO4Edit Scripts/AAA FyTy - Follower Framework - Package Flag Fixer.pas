unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eFlag: IInterface;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eFlag := ElementByPath(e, 'PKDT - Pack Data\General Flags\Treat As Player Follower');
	SetEditValue(eFlag, '1');
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.