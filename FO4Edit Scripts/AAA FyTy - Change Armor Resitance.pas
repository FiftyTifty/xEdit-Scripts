unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eArmorRating: IInterface;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eArmorRating := ElementByPath(e, 'FNAM\Armor Rating');
	
	SetEditValue(eArmorRating, '14');

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.