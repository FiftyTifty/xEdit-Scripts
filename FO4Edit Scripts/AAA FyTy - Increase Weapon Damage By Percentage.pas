unit userscript;
var
	fileMyFile: IInterface;
	tstrlistHumanMelee, tstrlistHumanGuns: TStringList;


function Initialize: integer;
begin
  tstrlistHumanMelee := TStringList.Create;
	tstrlistHumanMelee.LoadFromFile(ScriptsPath + '\FyTy\HumanMeleeFormIDs.txt');
	
	tstrlistHumanGuns := TStringList.Create;
	tstrlistHumanGuns.LoadFromFile(ScriptsPath + '\FyTy\HumanGunsFormIDs.txt');
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
	
	fileMyFile := GetFile(e);
	
	//eDamage := ElementByPath(e, 'DNAM - Data\Damage - Base');
	
	//strDamage := GetEditValue(eDamage);
	//iDamage := Round( StrToFloat(strDamage) * 1.35);
	
	//SetEditValue(eDamage, IntToStr(iDamage));
	
	
end;

procedure ModifyDamage(e: IInterface; fPercentage: float);
var
	eDamage: IInterface;
	strDamage: string;
	iDamage: integer;
begin
	
	eDamage := ElementByPath(e, 'DNAM - Data\Damage - Base');
	
	strDamage := GetEditValue(eDamage);
	iDamage := Round( StrToFloat(strDamage) * fPercentage);
	
	SetEditValue(eDamage, IntToStr(iDamage));
	
end;


function Finalize: integer;
var
	iCounter: integer;
begin
  for iCounter := 0 to tstrlistHumanGuns.Count() - 1 do begin
		ModifyDamage(RecordByFormID(fileMyFile, StrToInt(tstrlistHumanGuns[iCounter]), true), '0.75');
	end;
	
	for iCounter := 0 to tstrlistHumanMelee.Count() - 1 do begin
		ModifyDamage(RecordByFormID(fileMyFile, StrToInt(tstrlistHumanMelee[iCounter]), true), '0.75');
	end;
end;

end.