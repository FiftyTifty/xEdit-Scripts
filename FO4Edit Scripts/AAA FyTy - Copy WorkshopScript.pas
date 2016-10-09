unit userscript;

function Initialize: integer;
begin
	
	
	
end;


function Process(e: IInterface): integer;
var
	eDestination, eSourceVMAD: IInterface;
begin

	if Signature(e) <> 'REFR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eDestination := RecordByFormID(GetFile(e), 118195128, true);
	AddMessage(GetEditValue(ElementBySignature(eDestination, 'EDID')));
	
	eSourceVMAD := ElementBySignature(e, 'VMAD');
	
	wbCopyElementToRecord(eSourceVMAD, eDestination, true, true);

end;


function Finalize: integer;
begin
	
	
	
end;

end.