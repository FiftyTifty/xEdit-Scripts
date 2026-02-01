unit userscript;
var
	fileMyFile: IInterface;
	tstrlistHumanEnergy: TStringList;


function Initialize: integer;
begin
  tstrlistHumanEnergy := TStringList.Create;
	tstrlistHumanEnergy.LoadFromFile(ScriptsPath + '\FyTy\HumanEnergyFormIDs.txt');
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
	eDAMA, eDamageType, eDamage: IInterface;
	strDamage: string;
	iCounter, iDamage: integer;
begin
	
	eDAMA := ElementBySignature(e, 'DAMA');
	AddMessage('Processing: ' + FullPath(e));
	
	for iCounter := 0 to ElementCount(eDAMA) - 1 do begin
		
		eDamageType := ElementByIndex(eDAMA, iCounter);
		
		if GetElementEditValues(eDamageType, 'Type') = 'dtEnergy [DMGT:00060A81]' then
			eDamage := ElementByPath(eDamageType, 'Amount');
			
	end;
	
	strDamage := GetEditValue(eDamage);
	
	if strDamage <> '' then begin
		iDamage := Round( StrToFloat(strDamage) * fPercentage);
		
		SetEditValue(eDamage, IntToStr(iDamage));
	end;
	
end;


function Finalize: integer;
var
	iCounter: integer;
begin

  for iCounter := 0 to   tstrlistHumanEnergy.Count - 1 do begin
		ModifyDamage(RecordByFormID(fileMyFile, StrToInt(tstrlistHumanEnergy [iCounter]), true), '0.65');
	end;
	
end;

end.