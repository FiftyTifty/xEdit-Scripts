unit userscript;
const
	iBaseHealth = 100;

function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eHealth: IInterface;
	iHealth, iRandHealth: IInterface;
begin
	
	Randomize;
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eHealth := ElementByPath(e, 'DATA - \Base Health');
	iHealth := StrToInt(GetEditValue(eHealth));
	
	if (iHealth < 100) and (iHealth > 0) then begin
		iRandHealth := Random(50);
		SetEditValue(eHealth, IntToStr(iBaseHealth + iRandHealth));
	end


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.