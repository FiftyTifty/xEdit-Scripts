unit userscript;
var
	tstrlistFogPaths, tstrlistHorizonPaths: TStringList;
const
	
	strFogDayPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #1 (Day)\';
	strFogHighNoonPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #4 (High Noon)\';
	strFogSunrisePath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #0 (Sunrise)\';
	strFogSunsetPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #2 (Sunset)\';
	
	strHorizonSunrisePath = 'NAM0 - Colors by Types/Times\Type #8 (Horizon)\Time #0 (Sunrise)\';
	strHorizonDayPath = 'NAM0 - Colors by Types/Times\Type #8 (Horizon)\Time #1 (Day)\';
	strHorizonHighNoonPath = 'NAM0 - Colors by Types/Times\Type #8 (Horizon)\Time #4 (High Noon)\';
	strHorizonSunsetPath = 'NAM0 - Colors by Types/Times\Type #8 (Horizon)\Time #2 (Sunset)\';


function Initialize: integer;
begin
	
  tstrlistFogPaths := TStringList.Create;
	tstrlistFogPaths.LoadFromFile(ScriptsPath + 'FyTy\Weather\FogPaths.txt');
	
	tstrlistHorizonPaths := TStringList.Create;
	tstrlistHorizonPaths.LoadFromFile(ScriptsPath + 'FyTy\Weather\HorizonPaths.txt');
	
end;


function Process(e: IInterface): integer;
var
	strHorizonR, strHorizonG, strHorizonB, strFogR, strFogG, strFogB: string;
	iCounter: integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	for iCounter := 0 to tstrlistFogPaths.Count - 1 do begin
	
		strHorizonR := GetElementEditValues(e, tstrlistHorizonPaths[iCounter] + 'Red');
		strHorizonG := GetElementEditValues(e, tstrlistHorizonPaths[iCounter] + 'Green');
		strHorizonB := GetElementEditValues(e, tstrlistHorizonPaths[iCounter] + 'Blue');
		
		SetElementEditValues(e, tstrlistFogPaths[iCounter] + 'Red', strHorizonR);
		SetElementEditValues(e, tstrlistFogPaths[iCounter] + 'Green', strHorizonG);
		SetElementEditValues(e, tstrlistFogPaths[iCounter] + 'Blue', strHorizonB);
	
	end;
	
end;


function Finalize: integer;
begin
  
	tstrlistFogPaths.Free;
	tstrlistHorizonPaths.Free;
	
end;

end.