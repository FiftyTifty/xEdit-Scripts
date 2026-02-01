unit userscript;
var
	fMult: float;


function Initialize: integer;
begin
	fMult := 1.75;
end;


function Process(e: IInterface): integer;
var
	ePRPS, eProperty: IInterface;
	iCounter: integer;
	strHealthValue: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	ePRPS := ElementBySignature(e, 'PRPS');
	
	for iCounter := 0 to ElementCount(ePRPS) - 1 do begin
		eProperty := ElementByIndex(ePRPS, iCounter);
		
		if (GetElementEditValues(eProperty, 'Actor Value') = 'Health "Health" [AVIF:000002D4]') then begin
			
			strHealthValue := GetElementEditValues(eProperty, 'Value');
			StrHealthValue := FloatToStr(Round(StrToFloat(StrHealthValue) * fMult));
			SetElementEditValues(eProperty, 'Value', strHealthValue);
			
		end;
	end;
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.