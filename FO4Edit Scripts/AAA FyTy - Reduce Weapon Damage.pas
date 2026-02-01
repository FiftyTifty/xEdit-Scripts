unit userscript;
const
	fMultiplier = 0.6;
	strDamagePath = 'DNAM - Data\Damage - Base';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	iDamage: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	iDamage := GetElementEditValues(e, strDamagePath);
	SetElementEditValues(e, strDamagePath, IntToStr(Round(iDamage * fMultiplier)));

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.