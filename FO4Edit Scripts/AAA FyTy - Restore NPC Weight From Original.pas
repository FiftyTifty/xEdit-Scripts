unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eOverride, eOverrideWeight,	eOverrideMorphs,
	eOverrideMorphValues: IInterface;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eOverride := MasterOrSelf(e);
	
	if ElementExists(e, 'MWGT - Weight') then begin
		eOverrideWeight := ElementBySignature(eOverride, 'MWGT');
		wbCopyElementToRecord(eOverrideWeight, e, true, true);
	end;
	
	if ElementExists(e, 'MSDK - Morph Keys') then begin
		eOverrideMorphs := ElementBySignature(eOverrideMorphs, 'MSDK');
		wbCopyElementToRecord(eOverrideMorphs, e, true, true);
	end;
	
	if ElementExists(e, 'MSDV - Morph Values') then begin
		eOverrideMorphValues := ELementBySignature(eOverrideMorphValues, 'MSDV');
		wbCopyElementToRecord(eOverrideMorphValues, e, true, true);
	end;

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.