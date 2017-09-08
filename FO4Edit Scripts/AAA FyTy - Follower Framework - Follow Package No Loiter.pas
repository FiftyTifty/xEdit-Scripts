unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eLoiterFlag: IInterface;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eLoiterFlag := ElementByPath(e, 'Package Data\Data Input Values');
	eLoiterFlag := ElementByIndex(eLoiterFlag, 1);
	eLoiterFlag := ElementByPath(eLoiterFlag, 'CNAM - Value\Bool');
	
	SetEditValue(eLoiterFlag, 'False');

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.