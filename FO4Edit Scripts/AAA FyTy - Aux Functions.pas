unit fytyauxfunctions;

function GetFileByName(strFile: string; var outIndex: integer): IInterface;
var
	iCounter: integer;
begin

	for iCounter := 0 to FileCount - 1 do begin
	
		if GetFileName(FileByIndex(iCounter)) = strFile then begin
		
			outIndex := iCounter;
			Result := FileByIndex(iCounter);
			exit;
		
		end;
	
	end;

end;

function ModifyRange(OldValue, OldMin, OldMax, NewMin, Newmax: integer): integer;
var
	NewValue, OldRange, NewRange: integer;
begin
	
	OldRange := OldMax - OldMin;
	NewRange := NewMax - NewMin;
	
	NewValue := Round((((OldValue - OldMin) * NewRange) / OldRange) + NewMin);
	
	Result := NewValue;
end;

 
procedure SetFlag(eFlags: IInterface; flagName: string; flagValue: boolean);
var
  tstrlistFlags: TStringList;
  iCounter: Integer;
  iRawFlags, f2: Cardinal;
begin
 
  tstrlistFlags := TStringList.Create;
  tstrlistFlags.Text := FlagValues(eFlags); //Give each flag their own line. Value is the flag's name as a string
  iRawFlags := GetNativeValue(eFlags); //Get the binary result of the flags as an integer
   
  for iCounter := 0 to Pred(tstrlistFlags.Count) do //Iterate through each individual flag
    if SameText(tstrlistFlags[iCounter], flagName) then begin //If current line in the TStringList has the specified flag
           
      if flagValue then //If we want to set the flag to true
        f2 := iRawFlags or (1 shl iCounter)
      else //If we want to set the flag to false
        f2 := iRawFlags and not (1 shl iCounter);
           
      if iRawFlags <> f2 then SetNativeValue(eFlags, f2);
      Break;
           
    end;
       
  tstrlistFlags.Free;
   
end;


procedure GetRGBFromCLFM(strWithCLFMFormID: string; var outstrRed, outstrGreen, outstrBlue: string);
var
	fileFallout4, eRec: IInterface;
	strFormID: string;
	iFormID: integer;
	
	strRGBA, strTemp, strRed, strGreen, strBlue: string;
begin
	
	fileFallout4 := FileByIndex(0);
	
	strFormID := Copy(strWithCLFMFormID, Pos('CLFM:', strWithCLFMFormID) + 5, 8); // CLFM: has five characters, so we add that to what Pos returns
	//AddMessage(strFormID);
	iFormID := StrToInt('$'+strFormID); // By putting a $ in front of a string, that only has hex chars, we get painless str -> hex -> int conversions
	eRec := RecordByFormID(fileFallout4, iFormID, true);
	
	strRGBA := GetEditValue(ElementBySignature(eRec, 'CNAM'));
	strTemp := Copy(strRGBA, Pos('(', strRGBA) + 1, Length(strRGBA) - 4);
	
	strRed := Copy(strTemp, 1, Pos(',', strTemp) - 1);
	Delete(strTemp, 1, Length(strRed + ', '));
	
	strGreen := Copy(strTemp, 1, Pos(',', strTemp) - 1);
	Delete(strTemp, 1, Length(strGreen + ', '));
	
	strBlue := Copy(strTemp, 1, Pos(', ', strTemp) - 1);
	
	outstrRed := strRed;
	outstrGreen := strGreen;
	outstrBlue := strBlue;
end;


procedure GetRGBFromLayer(eLayer: IInterface; var iRed, iGreen, iBlue: Integer);
var
	iIndex, iR, iG, iB: Integer;
	strRed, strGreen, strBlue: string;
begin
	
	//AddMessage('GetRGBFromLayer: ' +GetElementEditValues(eLayer, 'TEND - Data\Color\Red'));
	
	if GetElementEditValues(eLayer, 'TEND - Data\Template Color Index') <> '-1' then begin
	
		AddMessage('Color Index: ' + GetElementEditValues(eLayer, 'TEND - Data\Template Color Index'));
		iIndex := tstrlistColorIDs.IndexOf(GetElementEditValues(eLayer, 'TEND - Data\Template Color Index'));
		AddMessage('GetRGBFromLayer: ' +IntToStr(iIndex));
		
		GetRGBFromCLFM(tstrlistColorStrings[iIndex], iR, iG, iB);
	
	end
	else begin
	
	//AddMessage('Custom color!');
	strRed := GetElementEditValues(eLayer, 'TEND - Data\Color\Red');
	strGreen := GetElementEditValues(eLayer, 'TEND - Data\Color\Green');
	strBlue := GetElementEditValues(eLayer, 'TEND - Data\Color\Blue');
	//AddMessage(strRed);
	
	iR := StrToIntDef(strRed, 0);
	iG := StrToIntDef(strGreen, 0);
	iB := StrToIntDef(strBlue, 0);
	
	end;
	
	//AddMessage('IR: ' +IntToStr(iR));
	iRed := iR;
	iGreen := iG;
	iBlue := iB;

end;

//Begin Mathematics functions
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

//MaxValue = 1.0 for reciprocals
function Modulo(HueValue, MaxValue: Double): Double;
begin
  Result := HueValue - floor(HueValue / MaxValue) * MaxValue;
end;

function ModuloInt(HueValue, MaxValue: Integer): Integer;
begin
  Result := HueValue - (HueValue div MaxValue) * MaxValue;
end;

function LerpInt(iSource, iDest: integer; fReciprocal: double): integer;
begin
	
	Result := floor(iSource + fReciprocal * (iDest - iSource));

end;

function LerpDouble(fSource, fDest, fReciprocal: double): double;
begin
	
	Result := fSource + fReciprocal * (fDest - fSource);

end;

function GetLightnessRGB(R, G, B: Integer): Integer;
var
	rr, gg, bb, Cmax, Cmin, delta,
	L: double;
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
	//Calculate lightness
	Result := ReciprocalToInt((Cmax + Cmin) / 2);

end;

function GetHueRGB(R, G, B: Integer): Integer;
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
	
	Result := HueReciprocalToInt(H);
	
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
	
procedure HSLToRGB(H, S, L: double; var outRed, outGreen, outBlue: byte);
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

procedure RGBToHSL(R, G, B: Integer; var outHue, outSaturation, outLightness: Double);
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

function IntToReciprocal(iInt: integer): double;
begin

	Result := 1.0 / iInt;

end;

function GetComplementaryColour(fHue: double): double;
begin

	//0.00277777778 = (1.0 / 360)
	fHue := fHue + ( (0.00277777778) * 180);
	fHue := modulo(fHue, 1.0);
	
	Result := fHue;

end;

function GetNextAdjacentColour(fHue: double): double;
begin

	Randomize;
	
	fHue := fHue + ( 0.00277777778 * (30 + Random(16)) );
	fHue := modulo(fHue, 1.0);
	
	Result := fHue;

end;

function GetMiddleHue(fHueSource, fHueDest: double): double;
var
	fHue, fHueAlt, fHueDifference: double;
begin

	fHue := modulo(fHueSource - fHueDest, 1.0);
	fHueAlt := modulo(fHueDest - fHueSource, 1.0);
	
	//Get "closest" value between these two Hues.
	if fHueAlt < fHue then
		fHueDifference := fHueAlt
	else
		fHueDifference := fHue;
	
	Result := modulo( fHueSource + (fHueDifference / 2), 1.0);

	//todo
	
end;

function GetPreviousAdjacentColour(fHue: double): double;
begin

	Randomize;
	
	//Perfect adjacent colour: fHue + ((1.0 / 360) * 45)
	//Adjacent colours are ideally within 30-45, so we'll use 30 + random number below 16
	//We can do a micro optimization by using the result of 1.0/360 instead
	fHue := fHue + ( 0.00277777778 * (30 + Random(16)) );
	fHue := modulo(fHue, 1.0);
	
	Result := fHue;

end;


end.