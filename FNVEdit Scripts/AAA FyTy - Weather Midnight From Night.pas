unit userscript;
const

	strCloudLayer0NightPath = 'PNAM\Layer #0\Color #3 (Night)\';
	strCloudLayer0MidnightPath = 'PNAM\Layer #0\Color #5 (Midnight)\';
	
	strCloudLayer1NightPath = 'PNAM\Layer #1\Color #3 (Night)\';
	strCloudLayer1MidnightPath = 'PNAM\Layer #1\Color #5 (Midnight)\';
	
	strCloudLayer2NightPath = 'PNAM\Layer #2\Color #3 (Night)\';
	strCloudLayer2MidnightPath = 'PNAM\Layer #2\Color #5 (Midnight)\';
	
	strCloudLayer3NightPath = 'PNAM\Layer #3\Color #3 (Night)\';
	strCloudLayer3MidnightPath = 'PNAM\Layer #3\Color #5 (Midnight)\';
	
	strSkyUpperNightPath = 'NAM0\Type #0 (Sky-Upper)\Time #3 (Night)\';
	strSkyUpperMidnightPath = 'NAM0\Type #0 (Sky-Upper)\Time #5 (Midnight)\';
	
	strFogNightPath = 'NAM0\Type #1 (Fog)\Time #3 (Night)\';
	strFogMidnightPath = 'NAM0\Type #1 (Fog)\Time #5 (Midnight)\';
	
	strAmbientNightPath = 'NAM0\Type #3 (Ambient)\Time #3 (Night)\';
	strAmbientMidnightPath = 'NAM0\Type #3 (Ambient)\Time #5 (Midnight)\';
	
	strSunlightNightPath = 'NAM0\Type #4 (Sunlight)\Time #3 (Night)\';
	strSunlightMidnightPath = 'NAM0\Type #4 (Sunlight)\Time #5 (Midnight)\';
	
	strStarsNightPath = 'NAM0\Type #6 (Stars)\Time #3 (Night)\';
	strStarsMidnightPath = 'NAM0\Type #6 (Stars)\Time #5 (Midnight)\';
	
	strSkyLowerNightPath = 'NAM0\Type #7 (Sky-Lower)\Time #3 (Night)\';
	strSkyLowerMidnightPath = 'NAM0\Type #7 (Sky-Lower)\Time #5 (Midnight)\';
	
	strHorizonNightPath = 'NAM0\Type #8 (Horizon)\Time #3 (Night)\';
	strHorizonMidnightPath = 'NAM0\Type #8 (Horizon)\Time #5 (Midnight)\';

procedure SetMidnightValues(e: IInterface; strNightPath, strMidnightPath: string);
var
	strNightR, strNightB, strNightG: string;
begin
	
	strNightR := GetElementEditValues(e, strNightPath + 'Red');
	strNightG := GetElementEditValues(e, strNightPath + 'Green');
	strNightB := GetElementEditValues(e, strNightPath + 'Blue');
	
	SetElementEditValues(e, strMidnightPath + 'Red', strNightR);
	SetElementEditValues(e, strMidnightPath + 'Green', strNightG);
	SetElementEditValues(e, strMidnightPath + 'Blue', strNightB);
	
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	SetMidnightValues(e, strCloudLayer0NightPath, strCloudLayer0MidnightPath);
	SetMidnightValues(e, strCloudLayer1NightPath, strCloudLayer1MidnightPath);
	SetMidnightValues(e, strCloudLayer2NightPath, strCloudLayer2MidnightPath);
	SetMidnightValues(e, strCloudLayer3NightPath, strCloudLayer3MidnightPath);
	SetMidnightValues(e, strSkyUpperNightPath, strSkyUpperMidnightPath);
	SetMidnightValues(e, strFogNightPath, strFogMidnightPath);
	SetMidnightValues(e, strAmbientNightPath, strAmbientMidnightPath);
	SetMidnightValues(e, strSunlightNightPath, strSunlightMidnightPath);
	SetMidnightValues(e, strStarsNightPath, strStarsMidnightPath);
	SetMidnightValues(e, strSkyLowerNightPath, strSkyLowerMidnightPath);
	SetMidnightValues(e, strHorizonNightPath, strHorizonMidnightPath);


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.