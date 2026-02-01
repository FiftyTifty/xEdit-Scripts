unit userscript;

function Initialize: integer;
begin
  
	
	
end;


function Process(e: IInterface): integer;
var
	eRecord, eKWDA, eAPPR: IInterface;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
		
	eRecord := MasterOrSelf(e);
	
	if OverrideCount(eRecord) = 0 then
		exit;
	
	AddMessage('Processing: ' + FullPath(e));
		
	if OverrideCount(eRecord) > 1 then
		eRecord := OverrideByIndex(eRecord, OverrideCount(eRecord) - 2);
	
  if ElementExists(e, 'KWDA') then begin
	
		eKWDA := ElementByPath(eRecord, 'KWDA');
		eAPPR := ElementByPath(eRecord, 'APPR');
		
		wbCopyElementToRecord(eKWDA, e, false, true);
		wbCopyElementToRecord(eAPPR, e, false, true);
	
	end;
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.