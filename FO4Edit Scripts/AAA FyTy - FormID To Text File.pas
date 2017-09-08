unit userscript;
var
	tstrlistText: TStringList;
	strFilePath: string;

function Initialize: integer;
begin
  tstrlistText := TStringList.Create;
	strFilePath := ScriptsPath + 'FyTy\MeleeGunsUnarmedNPCWeaponFormIDs.txt';
end;


function Process(e: IInterface): integer;
var
	strFormID, strDamage: string;
	iDamage: integer;
begin
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFormID := FixedFormID(e);
	
	strDamage := GetElementEditValues(e, 'DNAM - Data\Damage - Base');
	
	if strDamage = '' then
		exit;
	
	AddMessage(strDamage);
	
	iDamage := Round(StrToFloat(strDamage));
	
	if iDamage > 0 then
		tstrlistText.Add(strFormID);


end;


function Finalize: integer;
begin
  tstrlistText.SaveToFile(strFilePath);
	tstrlistText.Free();
end;

end.
