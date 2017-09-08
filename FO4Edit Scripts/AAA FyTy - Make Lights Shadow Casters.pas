unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eOverride, eOverrideData: IInterface;
begin
	
	if Signature(e) <> 'LIGH' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eOverride := MasterOrSelf(e);
	eOverrideData := ElementBySignature(eOverride, 'DATA');
	
	wbCopyElementToRecord(eOverrideData, e, false, true);

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.