unit userscript;

var
	Check, MuzzleFlag, NewFlags: string;
	MuzzleFlagInt: Integer;
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'PROJ' then
		exit;	
		
	SetElementEditValues(e, 'DATA - Data\Flags\Muzzle Flash', '0');
	
	{Check := GetEditValue(ElementByPath(e, 'DATA - Data\Flags'));
	AddMessage('Flag Binary = '+Check);
	
	MuzzleFlag := Copy(Check,4,1);
	AddMessage('Muzzle Flag is '+MuzzleFlag);
	
	MuzzleFlagInt := StrToInt(MuzzleFlag);}
	
{	if MuzzleFlagInt = false then begin
	
		AddMessage('Does not have Muzzle Flash flag. Removing record...');
		RemoveNode(e);
		
	end;
	
	if MuzzleFlagInt = 1 then begin
	
		AddMessage('Muzzle Flash flag is present. Removing flag...');
		SetElementEditValues(e, 'DATA - Data\Flags\Muzzle Flash', '0');
	end;}
	
end;

end.