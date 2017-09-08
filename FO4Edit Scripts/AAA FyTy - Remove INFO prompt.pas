unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eRNAM: IInterface;
begin

	if Signature(e) <> 'INFO' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	RemoveElement(e, 'RNAM - Prompt');

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.