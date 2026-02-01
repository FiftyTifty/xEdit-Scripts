unit userscript;
const
	strPathUpperSunrise = 'NAM0\Type #0 (Sky-Upper)\Time #0 (Sunrise)';
	strPathLowerSunrise = 'NAM0\Type #7 (Sky-Lower)\Time #0 (Sunrise)';
	strPathUpperSunset = 'NAM0\Type #0 (Sky-Upper)\Time #2 (Sunset)';
	strPathLowerSunset = 'NAM0\Type #7 (Sky-Lower)\Time #2 (Sunset)';
var
	iUpperSunriseR, iUpperSunriseG, iUpperSunriseB, iLowerSunriseR, iLowerSunriseG, iLowerSunriseB,
	iUpperSunsetR, iUpperSunsetG, iUpperSunsetB, iLowerSunsetR, iLowerSunsetG, iLowerSunsetB: integer;


function Initialize: integer;
begin
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	iLowerSunriseR := StrToInt(GetElementEditValues(e, strPathLowerSunrise + '\Red'));
	iLowerSunriseG := StrToInt(GetElementEditValues(e, strPathLowerSunrise + '\Green'));
	iLowerSunriseB := StrToInt(GetElementEditValues(e, strPathLowerSunrise + '\Blue'));
	
	iLowerSunsetR := StrToInt(GetElementEditValues(e, strPathLowerSunset + '\Red'));
	iLowerSunsetG := StrToInt(GetElementEditValues(e, strPathLowerSunset + '\Green'));
	iLowerSunsetB := StrToInt(GetElementEditValues(e, strPathLowerSunset + '\Blue'));
	
	iUpperSunriseR := Round(iLowerSunriseR / 0.85);
	iUpperSunriseG := Round(iLowerSunriseG / 0.85);
	iUpperSunriseB := Round(iLowerSunriseB / 0.85);
	
	iUpperSunsetR := Round(iLowerSunsetR / 0.85);
	iUpperSunsetG := Round(iLowerSunsetG / 0.85);
	iUpperSunsetB := Round(iLowerSunsetB / 0.85);
	
	SetElementEditValues(e, strPathUpperSunrise + '\Red', IntToStr(iUpperSunriseR));
	SetElementEditValues(e, strPathUpperSunrise + '\Green', IntToStr(iUpperSunriseG));
	SetElementEditValues(e, strPathUpperSunrise + '\Blue', IntToStr(iUpperSunriseB));
	
	SetElementEditValues(e, strPathUpperSunset + '\Red', IntToStr(iUpperSunsetR));
	SetElementEditValues(e, strPathUpperSunset + '\Green', IntToStr(iUpperSunsetG));
	SetElementEditValues(e, strPathUpperSunset + '\Blue', IntToStr(iUpperSunsetB));

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.