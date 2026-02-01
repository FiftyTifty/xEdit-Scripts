unit userscript;
uses 'AAA FyTy - Aux Functions';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eMaster, eOrigFlags, eOverFlags, eOverTempFlags: IInterface;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));

	eMaster := MasterOrSelf(e);
	eOrigFlags := ElementByPath(eMaster, 'ACBS - Configuration\Flags');
	
	//wbCopyElementToRecord(eOrigFlags, e, false, true);
	
	eOverFlags := ElementByPath(e, 'ACBS - Configuration\Flags');
	//eOverTempFlags := ElementByPath(e, 'ACBS - Configuration\Use Template Actors');
	
	if GetElementEditValues(eOverFlags, 'PC Level Mult') = '1' then
		SetFlag(eOverFlags, 'PC Level Mult', false);
		
	//SetFlag(eOverFlags, 'Auto-calc stats', true);
	
	//if GetElementNativeValues(eOverTempFlags, 'Stats') = 0 then
	//	SetFlag(eOverFlags, 'Auto-calc stats', true);
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.