unit userscript;
uses 'AAA FyTy - Aux Functions';

var
	iCurrentMin, iCurrentMax, iReplaceMin, iReplaceMax: integer;

function Initialize: integer;
begin
  iCurrentMin := 45;
	iCurrentMax := 120;
	iReplaceMin := 22;
	iReplaceMax := 60;
end;


function Process(e: IInterface): integer;
var
	eDamage: IInterface;
	iDamage, iNewDamage: integer;
begin
	
	if Signature(e) <> 'WEAP' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	eDamage := ElementByPath(e, 'DNAM - Data\Damage - Base');
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