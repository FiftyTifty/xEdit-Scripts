unit fytyauxfunctions;

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

procedure AdjustHumanNPCHealth(e: IInterface; iBaseHealth: integer);
var
	eHealth: IInterface;
	iHealth, iRandHealth: IInterface;
begin
	
	Randomize;
	
	eHealth := ElementByPath(e, 'DATA - DATA\Base Health');
	iHealth := StrToInt(GetEditValue(eHealth));
	
	if (iHealth < 100) and (iHealth > 0) then begin
		iRandHealth := Random(50);
		SetEditValue(eHealth, iBaseHealth + iRandHealth);
	end
	
end;


function IsNPCStatsTemplate(e: IInterface): boolean;
begin
	if GetElementEditValues(e, 'ACBS - Configuration\Template Flags (sorted)\Use Stats\') then
		Result := true;
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


procedure rgb2hsl(red, green, blue: Byte; var h, s, l: Double);
var
  r, g, b, cmax, cmin, d, dd: double;
begin
  cmin := Min(red, Min(green, blue)) / 255;
  cmax := Max(red, Max(green, blue)) / 255;
  r := red / 255;
  g := green / 255;
  b := blue / 255;
  h := (cmax + cmin) / 2;
  s := (cmax + cmin) / 2;
  l := (cmax + cmin) / 2;
  if cmax = cmin then begin
    h := 0;
    s := 0;
  end
  else begin
    d := cmax - cmin;
    if l > 0.5 then s := d / (2 - cmax - cmin) else s := d / (cmax + cmin);
    if g < b then dd := 6 else dd := 0;
    if cmax = r then
      h := (g - b) / d + dd
    else if cmax = g then
      h := (b - r) / d + 2
    else if cmax = b then
      h := (r - g) / d + 4;
    h := h / 6;
  end;
end;

function hue2rgb(p, q, t: Double): Double;
begin
  if t < 0 then t := t + 1;
  if t > 1 then t := t - 1;
  if t < 1 / 6 then
    Result := p + (q - p) * 6 * t
  else if t < 1 / 2 then
    Result := q
  else if t < 2 / 3 then
    Result := p + (q - p) * (2/3 - t) * 6
  else
    Result := p;
end;

procedure hsl2rgb(h, s, l: Double; var red, green, blue: Byte);
var
  r, g, b, p, q: double;
begin
  if s = 0 then begin
    r := l;
    g := l;
    b := l;
  end
  else begin
    if l < 0.5 then q := l * (1 + s) else q := l + s - l * s;
    p := 2 * l - q;
    r := hue2rgb(p, q, h + 1/3);
    g := hue2rgb(p, q, h);
    b := hue2rgb(p, q, h - 1/3);
  end;
	
	AddMessage(IntToStr(Round(r * 255)));
  red := Round(r * 255);
	AddMessage(IntToStr(Round(g * 255)));
  green := Round(g * 255);
	AddMessage(IntToStr(Round(b * 255)));
  blue := Round(b * 255);
end;

end.