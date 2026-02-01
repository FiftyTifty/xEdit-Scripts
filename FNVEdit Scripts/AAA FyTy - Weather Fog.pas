unit userscript;
const
	
	// H = 143, Sat = 49, Lum = 157
	iFogCloudyDayR = 149;
	iFogCloudyDayG = 164;
	iFogCloudyDayB = 185;
	
	// H = 34, Sat = 17, Lum = 95
	iFogCloudySunriseR = 108;
	iFogCloudySunriseG = 106;
	iFogCloudySunriseB = 94;
	
	// H = 20, Sat = 96, Lum = 80
	iFogCloudySunsetR = 119;
	iFogCloudySunsetG = 85;
	iFogCloudySunsetB = 51;
	
	// H = 144, Sat = 172, Lum = 157
	iFogDayR = 123;
	iFogDayG = 175;
	iFogDayB = 250;
	
	// H = 18, Sat = 95, Lum = 95
	iFogSunriseR = 141;
	iFogSunriseG = 98;
	iFogSunriseB = 61;
	
	// H = 232, Sat = 39, Lum = 89
	iFogSunsetR = 110;
	iFogSunsetG = 79;
	iFogSunsetB = 85;
	
	strFogDayPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #1 (Day)\';
	strFogHighNoonPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #4 (High Noon)\';
	strFogSunrisePath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #0 (Sunrise)\';
	strFogSunsetPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #2 (Sunset)\';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eEDID: IInterface;
	strEDID: string;
	iPosOvercast, iPosCloudy: integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
	eEDID := ElementBySignature(e, 'EDID');
	strEDID := GetEditValue(eEDID);
	iPosOvercast	:= Pos('Overcast', strEDID);
	iPosCloudy := Pos('Cloudy', strEDID);
	
  AddMessage('Processing: ' + FullPath(e));
	
	if (iPosOvercast = 0) and (iPosCloudy = 0) then begin
		
		SetElementEditValues(e, strFogSunrisePath + 'Red', IntToStr(iFogSunriseR));
		SetElementEditValues(e, strFogSunrisePath + 'Green', IntToStr(iFogSunriseG));
		SetElementEditValues(e, strFogSunrisePath + 'Blue', IntToStr(iFogSunriseB));
	
		SetElementEditValues(e, strFogDayPath + 'Red', IntToStr(iFogDayR));
		SetElementEditValues(e, strFogDayPath + 'Green', IntToStr(iFogDayG));
		SetElementEditValues(e, strFogDayPath + 'Blue', IntToStr(iFogDayB));
		
		SetElementEditValues(e, strFogHighNoonPath + 'Red', IntToStr(iFogDayR));
		SetElementEditValues(e, strFogHighNoonPath + 'Green', IntToStr(iFogDayG));
		SetElementEditValues(e, strFogHighNoonPath + 'Blue', IntToStr(iFogDayB));
		
		SetElementEditValues(e, strFogSunsetPath + 'Red', IntToStr(iFogSunsetR));
		SetElementEditValues(e, strFogSunsetPath + 'Green', IntToStr(iFogSunsetG));
		SetElementEditValues(e, strFogSunsetPath + 'Blue', IntToStr(iFogSunsetB));
		
	end;
	
	if (iPosOvercast > 0) or (iPosCloudy > 0) then begin
	
		SetElementEditValues(e, strFogSunrisePath + 'Red', IntToStr(iFogCloudySunriseR));
		SetElementEditValues(e, strFogSunrisePath + 'Green', IntToStr(iFogCloudySunriseG));
		SetElementEditValues(e, strFogSunrisePath + 'Blue', IntToStr(iFogCloudySunriseB));
		
		SetElementEditValues(e, strFogDayPath + 'Red', IntToStr(iFogCloudyDayR));
		SetElementEditValues(e, strFogDayPath + 'Green', IntToStr(iFogCloudyDayG));
		SetElementEditValues(e, strFogDayPath + 'Blue', IntToStr(iFogCloudyDayB));
		
		SetElementEditValues(e, strFogHighNoonPath + 'Red', IntToStr(iFogCloudyDayR));
		SetElementEditValues(e, strFogHighNoonPath + 'Green', IntToStr(iFogCloudyDayG));
		SetElementEditValues(e, strFogHighNoonPath + 'Blue', IntToStr(iFogCloudyDayB));
		
		SetElementEditValues(e, strFogSunsetPath + 'Red', IntToStr(iFogCloudySunsetR));
		SetElementEditValues(e, strFogSunsetPath + 'Green', IntToStr(iFogCloudySunsetG));
		SetElementEditValues(e, strFogSunsetPath + 'Blue', IntToStr(iFogCloudySunsetB));
		
	end;
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.