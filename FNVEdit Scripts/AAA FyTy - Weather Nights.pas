unit userscript;
const
	strNightAmbientPath = 'NAM0\Type #3 (Ambient)\Time #3 (Night)';
	strNightLightPath = 'NAM0\Type #4 (Sunlight)\Time #3 (Night)';
	strNightAmbientR = '41';
	strNightAmbientG = '41';
	strNightAmbientB = '41';
	strNightLightR = '35';
	strNightLightG = '35';
	strNightLightB = '44';
	
	strMidnightAmbientPath = 'NAM0\Type #3 (Ambient)\Time #5 (Midnight)';
	strMidnightLightPath = 'NAM0\Type #4 (Sunlight)\Time #5 (Midnight)';
	strMidnightAmbientR = '41';
	strMidnightAmbientG = '41';
	strMidnightAmbientB = '41';
	strMidnightLightR = '35';
	strMidnightLightG = '35';
	strMidnightLightB = '44';
	
	strNightSkyUpperPath = 'NAM0\Type #0 (Sky-Upper)\Time #3 (Night)';
	strNightSkyLowerPath = 'NAM0\Type #7 (Sky-Lower)\Time #3 (Night)';
	strNightSkyUpperR = '44';
	strNightSkyUpperG = '44';
	strNightSkyUpperB = '58';
	strNightSkyLowerR = '30';
	strNightSkyLowerG = '30';
	strNightSkyLowerB = '40';
	
	strMidnightSkyUpperPath = 'NAM0\Type #0 (Sky-Upper)\Time #5 (Midnight)';
	strMidnightSkyLowerPath = 'NAM0\Type #7 (Sky-Lower)\Time #5 (Midnight)';
	strMidnightSkyUpperR = '44';
	strMidnightSkyUpperG = '44';
	strMidnightSkyUpperB = '58';
	strMidnightSkyLowerR = '30';
	strMidnightSkyLowerG = '30';
	strMidnightSkyLowerB = '40';
	
	strNightHorizonPath = 'NAM0\Type #8 (Horizon)\Time #3 (Night)';
	strMidnightHorizonPath = 'NAM0\Type #8 (Horizon)\Time #5 (Midnight)';
	strNightHorizonR = '3';
	strNightHorizonG = '3';
	strNightHorizonB = '6';
	strMidnightHorizonR = '3';
	strMidnightHorizonG = '3';
	strMidnightHorizonB = '6';
	
function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, strNightAmbientPath + '\Red', strNightAmbientR);
	SetElementEditValues(e, strNightAmbientPath + '\Green', strNightAmbientG);
	SetElementEditValues(e, strNightAmbientPath + '\Blue', strNightAmbientB);
	
	SetElementEditValues(e, strNightLightPath + '\Red', strNightLightR);
	SetElementEditValues(e, strNightLightPath + '\Green', strNightLightG);
	SetElementEditValues(e, strNightLightPath + '\Blue', strNightLightB);
	
	//
	
	SetElementEditValues(e, strNightSkyLowerPath + '\Red', strNightSkyLowerR);
	SetElementEditValues(e, strNightSkyLowerPath + '\Green', strNightSkyLowerG);
	SetElementEditValues(e, strNightSkyLowerPath + '\Blue', strNightSkyLowerB);
	
	SetElementEditValues(e, strNightSkyUpperPath + '\Red', strNightSkyUpperR);
	SetElementEditValues(e, strNightSkyUpperPath + '\Green', strNightSkyUpperG);
	SetElementEditValues(e, strNightSkyUpperPath + '\Blue', strNightSkyUpperB);
	
	SetElementEditValues(e, strNightHorizonPath + '\Red', strNightHorizonR);
	SetElementEditValues(e, strNightHorizonPath + '\Green', strNightHorizonG);
	SetElementEditValues(e, strNightHorizonPath + '\Blue', strNightHorizonB);
	
	// - Midnight
	
	SetElementEditValues(e, strMidnightAmbientPath + '\Red', strMidnightAmbientR);
	SetElementEditValues(e, strMidnightAmbientPath + '\Green', strMidnightAmbientG);
	SetElementEditValues(e, strMidnightAmbientPath + '\Blue', strMidnightAmbientB);
	
	SetElementEditValues(e, strMidnightLightPath + '\Red', strMidnightLightR);
	SetElementEditValues(e, strMidnightLightPath + '\Green', strMidnightLightG);
	SetElementEditValues(e, strMidnightLightPath + '\Blue', strMidnightLightB);
	
	//
	
	SetElementEditValues(e, strMidnightSkyLowerPath + '\Red', strMidnightSkyLowerR);
	SetElementEditValues(e, strMidnightSkyLowerPath + '\Green', strMidnightSkyLowerG);
	SetElementEditValues(e, strMidnightSkyLowerPath + '\Blue', strMidnightSkyLowerB);
	
	SetElementEditValues(e, strMidnightSkyUpperPath + '\Red', strMidnightSkyUpperR);
	SetElementEditValues(e, strMidnightSkyUpperPath + '\Green', strMidnightSkyUpperG);
	SetElementEditValues(e, strMidnightSkyUpperPath + '\Blue', strMidnightSkyUpperB);
	
	SetElementEditValues(e, strMidnightHorizonPath + '\Red', strMidnightHorizonR);
	SetElementEditValues(e, strMidnightHorizonPath + '\Green', strMidnightHorizonG);
	SetElementEditValues(e, strMidnightHorizonPath + '\Blue', strMidnightHorizonB);
	
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.
