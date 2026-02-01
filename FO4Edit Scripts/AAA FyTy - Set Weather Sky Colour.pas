unit userscript;
const
	iSkyUpperDayR = 25;
	iSkyUpperDayG = 90;
	iSkyUpperDayB = 170;
	strSkyUpperEarlySunrisePath = 'NAM0 - Weather Colors\Sky-Upper\EarlySunrise';
	strSkyUpperSunrisePath = 'NAM0 - Weather Colors\Sky-Upper\Sunrise';
	strSkyUpperLateSunrisePath = 'NAM0 - Weather Colors\Sky-Upper\LateSunrise';
	strSkyUpperDayPath = 'NAM0 - Weather Colors\Sky-Upper\Day';
	strSkyUpperEarlySunsetPath = 'NAM0 - Weather Colors\Sky-Upper\EarlySunset';
	strSkyUpperSunsetPath = 'NAM0 - Weather Colors\Sky-Upper\Sunset';
	strSkyUpperLateSunsetPath = 'NAM0 - Weather Colors\Sky-Upper\LateSunset';
	strSkyUpperNightPath = 'NAM0 - Weather Colors\Sky-Upper\Night';
	
	iSkyLowerDayR = 94;
	iSkyLowerDayG = 199;
	iSkyLowerDayB = 247;
	strSkyLowerEarlySunrisePath = 'NAM0 - Weather Colors\Sky-Lower\EarlySunrise';
	strSkyLowerSunrisePath = 'NAM0 - Weather Colors\Sky-Lower\Sunrise';
	strSkyLowerLateSunrisePath = 'NAM0 - Weather Colors\Sky-Lower\LateSunrise';
	strSkyLowerDayPath = 'NAM0 - Weather Colors\Sky-Lower\Day';
	strSkyLowerEarlySunsetPath = 'NAM0 - Weather Colors\Sky-Lower\EarlySunset';
	strSkyLowerSunsetPath = 'NAM0 - Weather Colors\Sky-Lower\Sunset';
	strSkyLowerLateSunsetPath = 'NAM0 - Weather Colors\Sky-Lower\LateSunset';
	strSkyLowerNightPath = 'NAM0 - Weather Colors\Sky-Lower\Night';
	
	iHorizonDayR = 152;
	iHorizonDayG = 223;
	iHorizonDayB = 251;
	strHorizonEarlySunrisePath = 'NAM0 - Weather Colors\Horizon\EarlySunrise';
	strHorizonSunrisePath = 'NAM0 - Weather Colors\Horizon\Sunrise';
	strHorizonLateSunrisePath = 'NAM0 - Weather Colors\Horizon\LateSunrise';
	strHorizonDayPath = 'NAM0 - Weather Colors\Horizon\Day';
	strHorizonEarlySunsetPath = 'NAM0 - Weather Colors\Horizon\EarlySunset';
	strHorizonSunsetPath = 'NAM0 - Weather Colors\Horizon\Sunset';
	strHorizonLateSunsetPath = 'NAM0 - Weather Colors\Horizon\LateSunset';
	strHorizonNightPath = 'NAM0 - Weather Colors\Horizon\Night';

function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;

  AddMessage('Processing: ' + FullPath(e));

	SetElementEditValues(e, strSkyUpperDayPath + '\Red', IntToStr(iSkyUpperDayR));
	SetElementEditValues(e, strSkyUpperDayPath + '\Green', IntToStr(iSkyUpperDayG));
	SetElementEditValues(e, strSkyUpperDayPath + '\Blue', IntToStr(iSkyUpperDayB));
	
	SetElementEditValues(e, strSkyLowerDayPath + '\Red', IntToStr(iSkyLowerDayR));
	SetElementEditValues(e, strSkyLowerDayPath + '\Green', IntToStr(iSkyLowerDayG));
	SetElementEditValues(e, strSkyLowerDayPath + '\Blue', IntToStr(iSkyLowerDayB));
	
	SetElementEditValues(e, strHorizonDayPath + '\Red', IntToStr(iHorizonDayR));
	SetElementEditValues(e, strHorizonDayPath + '\Green', IntToStr(iHorizonDayG));
	SetElementEditValues(e, strHorizonDayPath + '\Blue', IntToStr(iHorizonDayB));
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.