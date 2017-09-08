unit userscript;
var
	fileMyFile: IInterface;
	tstrlistWeaponFormIDs: TStringList;

function Initialize: integer;
begin
  tstrlistWeaponFormIDs := TStringList.Create;
	tstrlistWeaponFormIDs.LoadFromFile(ScriptsPath + '\FyTy\MeleeGunsUnarmedNPCWeaponFormIDs.txt');
end;


function Process(e: IInterface): integer;

begin

  AddMessage('Processing: ' + FullPath(e));

	fileMyFile := GetFile(e);
end;


function Finalize: integer;
var
	eWeapon, eDamage: IInterface;
	iCounter, iNewDamage: integer;
	strDamage: string;
begin

  for iCounter := 0 to tstrlistWeaponFormIDs.Count - 1 do begin
		eWeapon := RecordByFormID(fileMyFile, StrToInt(tstrlistWeaponFormIDs[iCounter]), true);
		
		eDamage := ElementByPath(eWeapon, 'DNAM - Data\Damage - Base');
		strDamage := GetEditValue(eDamage);
		iNewDamage := Round(StrToInt(strDamage) * 0.6);
		
		SetEditValue(eDamage, IntToStr(iNewDamage));
	end;
	
end;

end.