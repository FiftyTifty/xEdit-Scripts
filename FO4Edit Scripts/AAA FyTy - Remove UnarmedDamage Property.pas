unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	iCounter: integer;
	ePRPS, eProperty: IInterface;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	ePRPS := ElementBySignature(e, 'PRPS');
	
	for iCounter := 0 to ElementCount(ePRPS) - 1 do begin
		
		eProperty := ElementByIndex(ePRPS, iCounter);
		
		if GetElementEditValues(eProperty, 'Actor Value') = 'UnarmedDamage [AVIF:000002DF]' then begin
			RemoveElement(ePRPS, eProperty);
			exit;
		end;
	end;
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.