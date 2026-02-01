unit userscript;
const
	strLoadPath = ScriptsPath + '/FyTy/Weather/OblivionOutput_';
	strWeathersToPresetPath = ScriptsPath + '/FyTy/Weather/DNWWeathersToOblivionPreset.txt';
var
	outHue, outSaturation, outLightness: double;
	outRed, outGreen, outBlue: Integer;
	tstrlistWeathersToPreset, tstrlistPresetToIndex: TStringList;
	tlistRoot: TList;
	//tlistRoot['WeatherType']
		//tlistPreset
			//[0] = TStringList Colours
			//[1] = TStringList HDR
			//[2] = TStringList Data

function MaxValue(R, G, B: double): double;
var
	fMax: double;
begin

	if R > G then
		fMax := R
	else
		fMax := G;
		
	if B > fMax then
		fMax := B;
	
	Result := fMax;

end;

function MinValue(R, G, B: double): double;
var
	fMin: double;
begin
	
	if R < G then
		fMin := R
	else
		fMin := G;
	
	if B < fMin then
		fMin := B;
	
	Result := fMin;

end;

function modulo(x, y: Double): Double;
begin
  Result := x - floor(x / y) * y;
end;

function HueToColorValue(Hue, M1, M2: double): byte;
var
	V: double;
begin
	if Hue > 10 then
		Hue := Hue + 1;
	if Hue < 0 then
		Hue := Hue + 1
	else if Hue > 1 then
		Hue := Hue - 1;
	if 6 * Hue < 1 then
		V := M1 + (M2 - M1) * Hue * 6
	else if 2 * Hue < 1 then
		V := M2
	else if 3 * Hue < 2 then
		V := M1 + (M2 - M1) * (2/3 - Hue) * 6
	else
		V := M1;
	Result := round(255 * V)
end;
	
procedure HSLToRGB(H, S, L: double);
var
  M1, M2: double;
begin

  if S = 0 then begin
    outRed := round(255 * L);
    outGreen := outRed;
    outBlue := outRed;
  end
	
  else
	begin
    if L <= 0.5 then
      M2 := L * (1 + S)
    else
      M2 := L + S - L * S;
    M1 := 2 * L - M2;
    outRed := HueToColorValue(H + 1/3, M1, M2);
    outGreen := HueToColorValue(H, M1, M2);
    outBlue := HueToColorValue(H - 1/3, M1, M2)
  end;
	
end;

procedure RGBToHSL(R, G, B: Integer);
var
  rr, gg, bb, Cmax, Cmin, delta,
	H, S, L: double;
begin

  rr := R / 255;
  gg := G / 255;
  bb := B / 255;
  Cmax := MaxValue(rr, gg, bb);
  Cmin := MinValue(rr, gg, bb);
	
	//AddMessage(FloatToStr(Cmax));
	//AddMessage(FloatToStr(Cmin));
  delta := (Cmax - Cmin);
	//AddMessage('Luminosity: ' + FloatToStr(L));
	//Calculate L
	L := (Cmax + Cmin) / 2;
	
  if delta = 0 then begin
    H := 0;
    S := 0;
  end
	else begin
    // Calculate H
    if Cmax = rr then begin
				H := modulo((gg - bb) / delta, 6);
				H := H * 60;
			end
		else
			if Cmax = gg then
				H := 60 * ((bb - rr) / delta + 2)
			else
			if Cmax = bb then
				H := 60 * ((rr - gg) / delta + 4)
			else
				H := 0;
			H := H / 360;

			// Calculate S
			S := delta / (1 - abs(2 * L - 1));
			//AddMessage('Saturation: ' + FloatToStr(S));
  end;
	
	//AddMessage('==RGBToHSL: fHue: ' + FloatToStr(H) + ' fSat: ' + FloatToStr(S) + ' fLig: ' + FloatToStr(L));
	//AddMessage('==ToInt: fHue: ' + IntToStr() + ' fSat: ' + IntToStr() + ' fLig: ' + IntToStr());
	
	outHue := H;
	outSaturation := S;
	outLightness := L;
	
end;

function HueReciprocalToInt(fReciprocal: double): integer;
begin
	
	Result := Floor((fReciprocal - 0) * (239 - 0) / (1 - 0) + 0);

end;

function ReciprocalToInt(fReciprocal: double): integer;
begin
	
	Result := Floor((fReciprocal - 0) * (240 - 0) / (1 - 0) + 0);

end;

procedure PrepareRootData(strWeather: string);
var
	tlistWeather: TList;
	tstrlistColours, tstrlistHDR, tstrlistData: TStringList;
	iIndex: Integer;
begin
	
	//Clear
	
	tlistWeather := TList.Create;
	
	{
	iIndex := tstrlistCurrentWeather.AddObject('Colours', TStringList.Create);
	tstrlistColours := tstrlistCurrentWeather[iIndex];
	tstrlistColours.LoadFromFile(strLoadPath + strWeather + '_Weather.txt');
	
	iIndex := tstrlistCurrentWeather.AddObject('HDR', TStringList.Create);
	tstrlistHDR := tstrlistCurrentWeather[iIndex];
	tstrlistHDR.LoadFromFile(strLoadPath + strWeather + '_HDR.txt');
	
	iIndex := tstrlistCurrentWeather.AddObject('Data', TStringList.Create);
	tstrlistData := tstrlistCurrentWeather[iIndex];
	tstrlistData.LoadFromFile(strLoadPath + strWeather + '_Data.txt');
	}
	
	tstrlistColours := TStringList.Create;
	tstrlistColours.LoadFromFile(strLoadPath + strWeather + '_Weather.txt');
	tlistWeather.Add(tstrlistColours);
	
	tstrlistHDR := TStringList.Create;
	tstrlistHDR.LoadFromFile(strLoadPath + strWeather + '_HDR.txt');
	tlistWeather.Add(tstrlistHDR);
	
	tstrlistData := TStringList.Create;
	tstrlistData.LoadFromFile(strLoadPath + strWeather + '_Data.txt');
	tlistWeather.Add(tstrlistData);
	
	tlistRoot.Add(tlistWeather);
	
	tstrlistPresetToIndex.Add(strWeather);
	
end;

function Initialize: integer;
var
	iCounter: integer;
	tstrlistLineCurrent: TStringList;
begin

	tstrlistWeathersToPreset := TStringList.Create;
	tstrlistWeathersToPreset.LoadFromFile(strWeathersToPresetPath);
	
	tstrlistPresetToIndex := TStringList.Create;
	
	tlistRoot := TList.Create;
	PrepareRootData('Clear'); //Bright, hardly any clouds, blue sky
	PrepareRootData('Cloudy_SN'); //Somewhat sunny, clouds, blue sky
	PrepareRootData('Cloudy'); //Mid tones, clouds, blue sky
	PrepareRootData('Fog'); //Grey, thick clouds, grey sky and hidden
	PrepareRootData('NAOCloudyOvercast'); //Midtones, clouds, blue sky
	PrepareRootData('Overcast'); //Grey, thick clouds, grey sky
	PrepareRootData('Rain'); //Dark, Clouds, Grey Sky
	PrepareRootData('Thunderstorm'); //Very dark, clouds, grey sky
	PrepareRootData('Snow'); //Midtones, thick clouds, white sky
  
end;

Procedure CleanImagespaceModifierData(eIMAD: IInterface; strPath: string);
var
	eEffect: IInterface;
begin

	//AddMessage('=CleanImagespaceModifierData= ' + strPath);
	eEffect := ElementByPath(eIMAD, strPath);
	//AddMessage(Name(eEffect));
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Time', '0.000000');
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Value', '0.000000');
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Time', '1.000000');
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Value', '0.000000');
	
end;

Procedure CleanImagespaceModifierHDR(eIMAD: IInterface; strPath, strTFirst, strVFirst, strTSecond, strVSecond: string);
var
	eEffect: IInterface;
begin

	eEffect := ElementByPath(eIMAD, strPath);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Time', strTFirst);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Value', strVFirst);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Time', strTSecond);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Value', strVSecond);
	
end;

Procedure CleanImagespaceModifierBloom(eIMAD: IInterface; strPath, strTFirst, strVFirst, strTSecond, strVSecond: string);
var
	eEffect: IInterface;
begin

	eEffect := ElementByPath(eIMAD, strPath);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Time', strTFirst);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Value', strVFirst);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Time', strTSecond);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Value', strVSecond);
	
end;

Procedure CleanImagespaceModifierCinematic(eIMAD: IInterface; strPath, strTFirst, strVFirst, strTSecond, strVSecond: string);
var
	eEffect: IInterface;
begin

	eEffect := ElementByPath(eIMAD, strPath);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Time', strTFirst);
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Value', strVFirst);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Time', strTSecond);
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Value', strVSecond);
	
end;

Procedure CleanImagespaceModifier(eIMAD: IInterface);
begin

	//Base data
	CleanImagespaceModifierData(eIMAD, 'BNAM - Blur Radius');
	CleanImagespaceModifierData(eIMAD, 'VNAM - Double Vision Strength');
	CleanImagespaceModifierData(eIMAD, 'RNAM - Radial Blur Strength');
	CleanImagespaceModifierData(eIMAD, 'SNAM - Radiaul Blur Ramp Up');
	CleanImagespaceModifierData(eIMAD, 'UNAM - Radial Blur Start');
	CleanImagespaceModifierData(eIMAD, 'NAM1 - Radial Blur Ramp Down');
	CleanImagespaceModifierData(eIMAD, 'NAM2 - Radial Blur Down Start');
	CleanImagespaceModifierData(eIMAD, 'WNAM - DoF Strength');
	CleanImagespaceModifierData(eIMAD, 'XNAM - DoF Distance');
	CleanImagespaceModifierData(eIMAD, 'YNAM - DoF Range');
	CleanImagespaceModifierData(eIMAD, 'NAM4 - Motion Blur Strength');
	
	//HDR data
	CleanImagespaceModifierHDR(eIMAD, 'HDR\aIAD - Eye Adapt Speed Mult', '0.000000', '0.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\@IAD - Eye Adapt Speed Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\bIAD - Bloom Blur Radius Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\AIAD - Bloom Blur Radius Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\cIAD - Bloom Threshold Mult', '0.000000', '0.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\BIAD - Bloom Threshold Add', '0.000000', '0.900000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\dIAD - Bloom Scale Mult', '0.000000', '1.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\CIAD - Bloom Scale Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\eIAD - Target Lum Min Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\DIAD - Target Lum Min Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\fIAD - Target Lum Max Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\EIAD - Target Lum Max Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\gIAD - Sunlight Scale Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\FIAD - Sunlight Scale Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\hIAD - Sky Scale Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\GIAD - Sky Scale Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\iIAD - LUM Ramp No Tex Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\HIAD - LUM Ramp No Tex Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\jIAD - LUM Ramp Min Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\IIAD - LUM Ramp Min Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\kIAD - LUM Ramp Max Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\JIAD - LUM Ramp Max Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\lIAD - Sunlight Dimmer Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\KIAD - Sunlight Dimmer Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\mIAD - Grass Dimmer Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\LIAD - Grass Dimmer Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\nIAD - Tree Dimmer Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierHDR(eIMAD, 'HDR\MIAD - Tree Dimmer Add', '0.000000', '0.000000', '1.000000', '0.000000');
	
	//Bloom data
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\oIAD - Blur Radius Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\NIAD - Blur Radius Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\pIAD - Alpha Mult Interior Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\OIAD - Alpha Mult Interior Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\qIAD - Alpha Mult Exterior Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierBloom(eIMAD, 'Bloom\PIAD - Alpha Mult Exterior Add', '0.000000', '0.000000', '1.000000', '0.000000');
	
	//Cinematic data
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\rIAD - Saturation Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\QIAD - Saturation Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\sIAD - Contrast Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\RIAD - Contrast Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\tIAD - Contrast Avg Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\SIAD - Contrast Avg Add', '0.000000', '0.000000', '1.000000', '0.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\uIAD - Brightness Mult', '0.000000', '1.000000', '1.000000', '1.000000');
	CleanImagespaceModifierCinematic(eIMAD, 'Cinematic\TIAD - Brightness Add', '0.000000', '0.000000', '1.000000', '0.000000');
end;

Function CopyToPluginIfNotPresent(eWeather, eImageSpace: IInterface): IInterface;
begin

	Result := eImageSpace;

	if GetFileName(GetFile(eImagespace)) <> GetFileName(GetFile(eWeather)) then
		Result := wbCopyElementToFile(eImageSpace, GetFile(eWeather), false, true);

end;

Procedure ModifyWeatherImagespaces(eWTHR: IInterface);
var
	aIAD, bIAD, cIAD, dIAD, eIAD, fIAD: IInterface;
	tstrlistSplit: TStringList;
begin

	AddMessage('=ModifyWeatherImagespaces=');
	
	aIAD := LinksTo(ElementByPath(eWTHR, 'aIAD - Sunrise Image Space Modifier'));	
	bIAD := LinksTo(ElementByPath(eWTHR, 'bIAD - Day Image Space Modifier'));
	cIAD := LinksTo(ElementByPath(eWTHR, 'cIAD - Sunset Image Space Modifier'));
	dIAD := LinksTo(ElementByPath(eWTHR, 'dIAD - Night Image Space Modifier'));
	eIAD := LinksTo(ElementByPath(eWTHR, 'eIAD - High Noon Image Space Modifier'));
	fIAD := LinksTo(ElementByPath(eWTHR, 'fIAD - Midnight Image Space Modifier'));
	
	aIAD := CopyToPluginIfNotPresent(eWTHR, aIAD);
	bIAD := CopyToPluginIfNotPresent(eWTHR, bIAD);
	cIAD := CopyToPluginIfNotPresent(eWTHR, cIAD);
	dIAD := CopyToPluginIfNotPresent(eWTHR, dIAD);
	eIAD := CopyToPluginIfNotPresent(eWTHR, eIAD);
	fIAD := CopyToPluginIfNotPresent(eWTHR, fIAD);
	
	CleanImagespaceModifier(aIAD);
	//AddMessage(GetElementEditValues(aIAD, 'EDID'));
	
	CleanImagespaceModifier(bIAD);
	//AddMessage(GetElementEditValues(bIAD, 'EDID'));
	
	CleanImagespaceModifier(cIAD);
	//AddMessage(GetElementEditValues(cIAD, 'EDID'));
	
	CleanImagespaceModifier(dIAD);
	//AddMessage(GetElementEditValues(dIAD, 'EDID'));
	
	CleanImagespaceModifier(eIAD);
	//AddMessage(GetElementEditValues(eIAD, 'EDID'));
	
	CleanImagespaceModifier(fIAD);
	//AddMessage(GetElementEditValues(fIAD, 'EDID'));
	
end;

Procedure ImportSaturationLightness(eWTHR, strPreset: string);
var
	tlistWeatherPreset: TList;
	tstrlistColour, tstrlistHDR, tstrlistData: TStringList;
	iCounter, iImportRed, iImportGreen, iImportBlue,
	iCurrentRed, iCurrentGreen, iCurrentBlue: Integer;
	fImportHue, fImportSaturation, fImportLightness,
	fCurrentHue, fCurrentSaturation, fCurrentLightness: double;
	strCurrent, strPathCurrent, strValueCurrent: string;
	iGotAllThree: Integer;
begin
	
	AddMessage(strPreset);
	tlistWeatherPreset := TList(tlistRoot[tstrlistPresetToIndex.IndexOf(strPreset)]);
	
	tstrlistColour := TStringList(tlistWeatherPreset[0]);
	tstrlistData := TStringList(tlistWeatherPreset[1]);
	tstrlistHDR := TStringList(tlistWeatherPreset[2]);
	
	AddMessage(IntToStr(tstrlistColour.Count));
	
	for iCounter := 0 to tstrlistColour.Count - 1 do begin
	
		strCurrent := tstrlistColour[iCounter];
		strPathCurrent := Copy(strCurrent, 0, pos(',', strCurrent) - 1);
		StrValueCurrent := Copy(strCurrent, pos(',', strCurrent) + 1, 255);
		
		if pos('Red', strPathCurrent) > 0 then begin
		
			iImportRed := StrToInt(strValueCurrent);
			iCurrentRed := StrToInt(GetElementEditValues(eWTHR, strPathCurrent));
			
			iGotAllThree := iGotAllThree + 1;
			
		end;
		
		if pos('Green', strPathCurrent) > 0 then begin
		
			iImportGreen := StrToInt(strValueCurrent);
			iCurrentGreen := StrToInt(GetElementEditValues(eWTHR, strPathCurrent));
			
			iGotAllThree := iGotAllThree + 1;
			
		end;
		
		if pos('Blue', strPathCurrent) > 0 then begin
		
			//AddMessage(strPathCurrent);
			iImportBlue := StrToInt(strValueCurrent);
			iCurrentBlue := StrToInt(GetElementEditValues(eWTHR, strPathCurrent));
			
			iGotAllThree := iGotAllThree + 1;
			
		end;
		
		if iGotAllThree = 3 then begin
		
			iGotAllThree := 0;
			
			//Remove the colour element from the path
			strPathCurrent := Copy(strPathCurrent, 0, pos('\Blue', strPathCurrent) - 1);
			//AddMessage(strPathCurrent);
			
			//Get HSL for imported preset's colour
			RGBToHSL(iImportRed, iImportGreen, iImportBlue);
			fImportHue := outHue;
			fImportSaturation := outSaturation;
			fImportLightness := outLightness;
			
			//Get HSL for weather's current colour
			RGBToHSL(iCurrentRed, iCurrentGreen, iCurrentBlue);
			fCurrentHue := outHue;
			fCurrentSaturation := outSaturation;
			fCurrentLightness := outLightness;
			
			//Keep weather's current hue, but use imported saturation and lightness
			HSLToRGB(fCurrentHue, fImportSaturation, fImportLightness);
			
			SetElementEditValues(eWTHR, strPathCurrent + '\Red', IntToStr(outRed));
			SetElementEditValues(eWTHR, strPathCurrent + '\Green', IntToStr(outGreen));
			SetElementEditValues(eWTHR, strPathCurrent + '\Blue',IntToStr(outBlue));
		
		end;

	end;
	
end;

Procedure ImportWeatherPreset(eWTHR: IInterface);
var
	tstrlistSplit: TStringList;
	strEDID: string;
	bFound: Boolean;
	iCounter: Integer;
begin

	AddMessage('=ImportWeatherPreset=');
	tstrlistSplit := TStringList.Create;
	tstrlistSplit.Delimiter := ',';
	tstrlistSplit.StrictDelimiter := true;
	
	strEDID := GetElementEditValues(eWTHR, 'EDID');
	
	for iCounter := 0 to tstrlistWeathersToPreset.Count - 1 do begin
	
		tstrlistSplit.Clear;
		tstrlistSplit.DelimitedText := tstrlistWeathersToPreset[iCounter];
		
		
		if tstrlistSplit[0] = strEDID then begin
		
			bFound := true;
			
			//AddMessage(tstrlistSplit[1]);
			ImportSaturationLightness(eWTHR, tstrlistSplit[1]);
		
		end;
		
		if bFound then
			break;
	
	end;
	
	tstrlistSplit.Free;

end;

Procedure SetImagespaceValues(eIMGS: IInterface);
begin

	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Eye Adapt Speed', '1.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Blur Radius', '8.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Blur Passes', '8.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Emissive Mult', '1.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Target LUM', '20.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Upper LUM Clamp', '1.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Bright Scale', '6.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Bright Clamp', '0.050000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\LUM Ramp No Tex', '1.150000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\LUM Ramp Min', '0.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\LUM Ramp Max', '0.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Sunlight Dimmer', '1.650000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Grass Dimmer', '1.500000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Tree Dimmer', '1.2500000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\HDR\Skin Dimmer', '1.000000');
	
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Bloom\Blur Radius', '0.030000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Bloom\Alpha Mult Interior', '0.800000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Bloom\Alpha Mult Exterior', '0.200000');
	
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Cinematic\Saturation', '1.400000');
	
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Cinematic\Contrast\Avg Lum Value', '1.000000');
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Cinematic\Contrast\Value', '1.000000');
	
	SetElementEditValues(eIMGS, 'DNAM - DNAM\Cinematic\Cinematic - Brightness - Value', '1.000000');

end;

Procedure ModifyWorldspaceImagespace(eWTHR: IInterface);
var
	eIMGS: IInterface;
begin

	eIMGS := LinksTo(ElementBySignature(eWTHR, 'INAM'));
	
	if GetFileName(GetFile(eIMGS)) <> GetFileName(GetFile(eWTHR)) then
		eIMGS := wbCopyElementToFile(eIMGS, GetFile(eWTHR), false, true);
	
	SetImagespaceValues(eIMGS);

end;

function Process(e: IInterface): integer;
var
	iCounter: integer;
begin

	if Signature(e) = 'WTHR' then begin
	
		AddMessage('Processing Weather: ' + FullPath(e));
		ModifyWeatherImagespaces(e);
		ImportWeatherPreset(e);
		
	end;
	
	if Signature(e) = 'WRLD' then begin
	
		AddMessage('Processing Worldspace: ' + FullPath(e));
		
		ModifyWorldspaceImagespace(e);
	
	end;

end;


function Finalize: integer;
begin

	tstrlistWeathersToPreset.Free;
	tlistRoot.Free;
	tstrlistPresetToIndex.Free;
	
end;

end.