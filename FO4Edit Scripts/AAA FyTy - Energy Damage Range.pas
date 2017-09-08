unit userscript;
uses 'AAA FyTy - Aux Functions';

var
	iCurrentMin, iCurrentMax, iReplaceMin, iReplaceMax: integer;

function Initialize: integer;
begin
  iCurrentMin := 24;
	iCurrentMax := 150;
	iReplaceMin := 24;
	iReplaceMax := 75;
end;


function Process(e: IInterface): integer;
var
	eDamage: IInterface;
	iDamage, iNewDamage: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	eDamage := ElementByPath(e, 'DAMA - Damage Types\Damage Type #0\Amount');
	iDamage := Round(StrToFloat(GetEditValue(eDamage)));
	
	if iDamage < 1 then
		exit;
	
	iNewDamage := ModifyRange(iDamage, iCurrentMin, iCurrentMax, iReplaceMin, iReplaceMax);
	
	SetEditValue(eDamage, IntToStr(iNewDamage));
	
	//AddMessage(IntToStr(iNewDamage));
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.