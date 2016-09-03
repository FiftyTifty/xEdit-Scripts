unit userscript;

var
	Levelstr: string;
	Health01int, Health02int: integer;
	Health01, Health02, Level: IInterface;

function Initialize: integer;
begin
  Result := 0;
end;

procedure TripleHealth(e: IInterface);
begin
	SetEditValue(Health01, IntToStr(Health01int * 3));
	SetEditValue(Health02, IntToStr(Health02int * 3));
end;

procedure IncreaseHealthPast3000(e: IInterface);
begin

	AddMessage('Increasing Health');
	
		if (Health01int < 5000) or (health02int < 5000) then
			Repeat
				Health01int := (Health01int + 500);
				Health02int := (Health02int + 500);
			Until (Health01int >= 3000) and (Health02int >= 3000);
		
		if (Health01int >= 3000) and (health02int >= 3000) then begin
			SetEditValue(Health01, IntToStr(Health01Int));
			SetEditValue(Health02, IntToStr(Health02Int));
		end;
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	Health01 := ElementByPath(e, 'ACBS - Configuration\Health Offset');
	Health02 := ElementByPath(e, 'DNAM - Player Skills\Health');
	Level := ElementByPath(e, 'ACBS - Configuration\Level');
	Health01int := StrToInt(GetEditValue(Health01));
	Health02int := StrToInt(GetEditValue(Health02));
	
	//TripleHealth(e);
	
	IncreaseHealthPast3000(e);


end;

function Finalize: integer;
begin

end;

end.