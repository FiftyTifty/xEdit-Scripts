unit userscript;

var
	eFlags, eLevelMult01, eLevelMult02: IInterface;
	FlagStr: string;

function Initialize: integer;
begin
  Result := 0;
end;

function RandomLevel(lRandRange: integer; lRandMin:integer): integer;
begin
	Randomize;
	Result := IntToStr((Random(10) + 40));
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
		if Signature(e) <> 'CREA' then
			exit;

  //AddMessage('Processing: ' + FullPath(e));
	
	eFlags := ElementByPath(e, 'ACBS - Configuration\Flags');
	FlagStr := GetEditValue(eFlags);
	eLevelMult01 := ElementByPath(e, 'ACBS - Configuration\Level');
	eLevelMult02 := ElementByPath(e, 'ACBS - Configuration\Level Mult');
	
	if Length(FlagStr) > 7 then
		if FlagStr[8] = '1' then
			begin // flag #8 = PCLevelMult
			
				AddMessage(FlagStr);
				Delete(FlagStr, 8, 1);
				Insert('0', FlagStr, 8);
				AddMessage(FlagStr);
				SetEditValue(eFlags, FlagStr);
				
				SetEditValue(eLevelMult01, RandomLevel(10, 40));
				SetEditValue(eLevelMult02, RandomLevel(10, 40));
				
			end;
		
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.