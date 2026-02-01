unit userscript;
const
	strPath = 'S:\Games\steamapps\common\Fallout 4\enbseries\_weatherlist.ini';
var
	tstringlistWeathers: TStringList;
	iIndexWeather: integer;

function Initialize: integer;
begin
  
	tstringlistWeathers := TStringList.Create;
	
	iIndexWeather := 001
	
end;


function Process(e: IInterface): integer;
var
	strWeather: string;
begin
  
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strWeather := GetElementEditValues(e, 'EDID');
	
	tstringlistWeathers.Append('[WEATHER' + format(' %.5d', [iIndexWeather]) + ']');
	tstringlistWeathers.Append('FileName=' + strWeather + '.ini');
	tstringlistWeathers.Append('WeatherIDs=' + (IntToHex(FixedFormID(e), 8)) );
	
	iIndexWeather := iIndexWeather + 1
	
end;


function Finalize: integer;
begin
	
	tstringlistWeathers.SaveToFile(strPath);
	tstringlistWeathers.Free;
	
end;

end.