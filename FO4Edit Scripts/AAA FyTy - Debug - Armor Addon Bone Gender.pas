unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eBoneDataMale, eBoneDataFemale: IInterface;
begin
	
	if Signature(e) <> 'ARMA' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	eBoneDataMale := ElementByIndex(ElementByPath(e, 'Bone Data'), 1);
	eBoneDataMale := ElementByPath(eBoneDataMale, 'BSMP - Gender');
	AddMessage('At Index 1 is: '+GetEditValue(eBoneDataMale));
	
	//Results: Male is @ Index 0
	//Results: Female is @ Index 1

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.