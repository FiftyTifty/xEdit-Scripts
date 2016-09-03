
unit userscript;

var
	SkyUpperDay, SkyUpperNoon, SkyLowerDay, SkyLowerNoon, SkyHorizonDay, SkyHorizonNoon, FogDayNear, FogDayFar, FogNightNear, FogNightFar, FogDayPower, FogNightPower: IInterface;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'WTHR' then
		exit;
	
	FogDayNear := ElementByPath(e, 'FNAM - Fog Distance\Day - Near');
	FogDayFar := ElementByPath(e, 'FNAM - Fog Distance\Day - Far');
	FogNightNear:= ElementByPath(e, 'FNAM - Fog Distance\Night - Near');
	FogNightFar := ElementByPath(e, 'FNAM - Fog Distance\Night - Far');
	FogDayPower := ElementByPath(e, 'FNAM - Fog Distance\Day - Power');
	FogNightPower := ElementByPath(e, 'FNAM - Fog Distance\Night - Power');
	
	
	if strtofloat(GetEditValue(FogDayNear)) < 8000 then begin
		SetEditValue(FogDayNear, '8000');
	end;
	
	if strtofloat(GetEditValue(FogDayFar)) < 350000 then begin
		SetEditValue(FogDayFar, '350000');
	end;
	
	
	SkyUpperDay := ElementByPath(e, 'NAM0\Type #0 (Sky-Upper)\Time #1 (Day)');
	SkyUpperNoon := ElementByPath(e, 'NAM0\Type #0 (Sky-Upper)\Time #4 (High Noon)');
	SkyLowerDay := ElementByPath(e, 'NAM0\Type #7 (Sky-Lower)\Time #1 (Day)');
	SkyLowerNoon := ElementByPath(e, 'NAM0\Type #7 (Sky-Lower)\Time #4 (High Noon)');
	SkyHorizonDay := ElementByPath(e, 'NAM0\Type #8 (Horizon)\Time #1 (Day)');
	SkyHorizonNoon := ElementByPath(e, 'NAM0\Type #8 (Horizon)\Time #4 (High Noon)');
	
  SetElementEditValues(SkyUpperDay, 'Red', '43');
	SetElementEditValues(SkyUpperDay, 'Green', '100');
	SetElementEditValues(SkyUpperDay, 'Blue', '128');
	//
	SetElementEditValues(SkyUpperNoon, 'Red', '43');
	SetElementEditValues(SkyUpperNoon, 'Green', '100');
	SetElementEditValues(SkyUpperNoon, 'Blue', '128');
	
	SetElementEditValues(SkyLowerDay, 'Red', '130');
	SetElementEditValues(SkyLowerDay, 'Green', '179');
	SetElementEditValues(SkyLowerDay, 'Blue', '176');
	//
	SetElementEditValues(SkyLowerNoon, 'Red', '130');
	SetElementEditValues(SkyLowerNoon, 'Green', '179');
	SetElementEditValues(SkyLowerNoon, 'Blue', '176');
	
	SetElementEditValues(SkyHorizonDay, 'Red', '196');
	SetElementEditValues(SkyHorizonDay, 'Green', '240');
	SetElementEditValues(SkyHorizonDay, 'Blue', '255');
	//
	SetElementEditValues(SkyHorizonNoon, 'Red', '196');
	SetElementEditValues(SkyHorizonNoon, 'Green', '240');
	SetElementEditValues(SkyHorizonNoon, 'Blue', '255');
	
	
end;


end.
