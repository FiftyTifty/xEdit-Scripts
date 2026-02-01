unit userscript;
uses 'AAA FyTy - Aux Functions';

const

	strFogDayPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #1 (Day)\';
	strFogHighNoonPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #4 (High Noon)\';

	doubleTargetLum = 220 / 255.0;
	doubleTargetSat = 200 / 255.0;

function Process(e: IInterface): integer;
var
	byteRed, byteGreen, byteBlue: Byte;
	doubleHue, doubleSat, doubleLum: Double;
	strRed, strGreen, strBlue: string;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	byteRed := StrToInt(GetElementEditValues(e, strFogDayPath + 'Red'));
	byteGreen := StrToInt(GetElementEditValues(e, strFogDayPath + 'Green'));
	byteBlue := StrToInt(GetElementEditValues(e, strFogDayPath + 'Blue'));
	
	AddMessage(IntToStr(byteRed));
	AddMessage(IntToStr(byteGreen));
	AddMessage(IntToStr(byteBlue));
	
	AddMessage(IntToStr(doubleHue));
	AddMessage(IntToStr(doubleSat));
	AddMessage(IntToStr(doubleLum));
	
	rgb2hsl(byteRed, byteGreen, byteBlue, doubleHue, doubleSat, doubleLum);
	
	AddMessage(IntToStr(byteRed));
	AddMessage(IntToStr(byteGreen));
	AddMessage(IntToStr(byteBlue));
	
	AddMessage(IntToStr(doubleHue));
	AddMessage(IntToStr(doubleSat));
	AddMessage(IntToStr(doubleLum));
	
	hsl2rgb(doubleHue, doubleTargetSat, doubleTargetLum, byteRed, byteGreen, byteBlue);
	
	SetElementEditValues(e, strFogDayPath + 'Red', IntToStr(byteRed));
	SetElementEditValues(e, strFogDayPath + 'Green', IntToStr(byteGreen));
	SetElementEditValues(e, strFogDayPath + 'Blue', IntToStr(byteBlue));
	
	SetElementEditValues(e, strFogHighNoonPath + 'Red', IntToStr(byteRed));
	SetElementEditValues(e, strFogHighNoonPath + 'Green', IntToStr(byteGreen));
	SetElementEditValues(e, strFogHighNoonPath + 'Blue', IntToStr(byteBlue));
	
end;

end.