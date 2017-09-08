unit userscript;
var
	strNoneRays: string;

function Initialize: integer;
begin
  Result := 0;
	strNoneRays := 'None_Rays [GDRY:001B40E8]';
end;


function Process(e: IInterface): integer;
var
	eGodRays: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eGodRays := ElementByPath(e, 'WGDR - God Rays');
	
	SetElementEditValues(eGodRays, 'Sunrise', strNoneRays);
	SetElementEditValues(eGodRays, 'Day', strNoneRays);
	SetElementEditValues(eGodRays, 'Sunset', strNoneRays);
	SetElementEditValues(eGodRays, 'Night', strNoneRays);
	SetElementEditValues(eGodRays, 'EarlySunrise', strNoneRays);
	SetElementEditValues(eGodRays, 'LateSunrise', strNoneRays);
	SetElementEditValues(eGodRays, 'EarlySunset', strNoneRays);
	SetElementEditValues(eGodRays, 'LateSunset', strNoneRays);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.