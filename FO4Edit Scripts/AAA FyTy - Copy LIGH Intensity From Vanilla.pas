unit userscript;

function Process(e: IInterface): integer;
var
	eOriginal, eOverride: IInterface;
	strFade: string;
begin
	
  if Signature(e) <> 'LIGH' then
		exit;
		
	eOriginal := MasterOrSelf(e);
	
	strFade := GetElementEditValues(eOriginal, 'FNAM - Fade Value');
	SetElementEditValues(e, 'FNAM - Fade Value', strFade);
	
end;

end.