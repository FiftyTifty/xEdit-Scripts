unit userscript;

function Process(e: IInterface): integer;
var
	eXLCM: IInterface;
begin

	if (Signature(e) <> 'ACHR') and (Signature(e) <> 'ACRE') then
		exit;
	
	AddMessage('Processing: ' + FullPath(e));
	
	//Check if the record has an XLCM record, if not, create one and keep it in a variable
	//If it does, get it and put that in the variable instead
	if ElementExists(e, 'XLCM - Level Modifier') = false then
		eXLCM := Add(e, 'XLCM', false)
	else
		eXLCM := ElementByPath(e, 'XLCM - Level Modifier');
	
	//We could use GetElementEditValues(e, 'XLCM - Level Modifier)
	//But since we already have the XLCM element, we can just use GetEditValue()
	if StrToInt(GetEditValue(eXLCM)) >= 3 then
		exit;
	
	SetEditValue(eXLCM, '2');

end;

end.