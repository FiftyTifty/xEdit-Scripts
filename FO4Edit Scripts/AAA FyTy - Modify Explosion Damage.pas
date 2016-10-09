unit userscript;
var
	fMultiplier: float;

function Initialize: integer;
begin
	
	fMultiplier := 3.0;
	
end;


function Process(e: IInterface): integer;
var
	eDamage: IInterface;
	strDamage, strNewDamage: string;
	fDamage, fNewDamage: float;
begin

	if Signature(e) <> 'EXPL' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eDamage := ElementByPath(e, 'DATA - Data\Damage');
	strDamage := GetEditValue(eDamage);
	fDamage := StrToFloat(strDamage);
	
	fNewDamage := fDamage * fMultiplier;
	
	strNewDamage := FloatToStr(fNewDamage);
	SetEditValue(eDamage, strNewDamage);
end;


function Finalize: integer;
begin
	
	
	
end;

end.