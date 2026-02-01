unit userscript;
const
	fHealthMult = 2.0;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eHealth: IInterface;
	iHealth: integer;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eHealth := ElementByPath(e, 'DATA - Data\Health');
	iHealth := Round(StrToInt(GetEditValue(eHealth)) * fHealthMult);
	SetEditValue(eHealth, IntToStr(iHealth));

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.