unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eDamage: IInterface;
	strDamage: string;
	iDamage: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eDamage := ElementByPath(e, 'DNAM - Data\Damage - Base');
	
	strDamage := GetEditValue(eDamage);
	iDamage := Round( StrToFloat(strDamage) * 1.35);
	
	SetEditValue(eDamage, IntToStr(iDamage));
	
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.