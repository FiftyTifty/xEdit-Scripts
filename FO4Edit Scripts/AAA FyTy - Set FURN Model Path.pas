unit userscript;
var
	strPath: string;


function Initialize: integer;
begin
  strPath := 'Despy\BusySettlersRug.nif';
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'FURN' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'Model\MODL - Model Filename', strPath);


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.