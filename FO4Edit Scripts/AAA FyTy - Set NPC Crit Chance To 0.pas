unit userscript;
var
	strCritChance: string;


function Initialize: integer;
begin
  strCritChance := 'CritChance [AVIF:000002DD]';
end;


function Process(e: IInterface): integer;
var
	eProperties, eProperty: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eProperties := ElementBySignature(e, 'PRPS');
	
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
		eProperty := ElementByIndex(eProperties, iCounter);
		if GetElementEditValues(eProperty, 'Actor Value') = strCritChance then begin
			SetElementEditValues(eProperty, 'Value', '0.0');
			exit;
		end;
	end;
	
	eProperty := ElementAssign(eProperties, HighInteger, nil, false);
	SetElementEditValues(eProperty, 'Actor Value', strCritChance);
	SetElementEditValues(eProperty, 'Value', '0.0');
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.