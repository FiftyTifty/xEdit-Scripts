unit userscript;
const
	strPath = 'S:\Games\steamapps\common\Fallout 4\enbseries.ini';
	strDest = 'S:\Games\steamapps\common\Fallout 4\enbseries\';

function Process(e: IInterface): integer;
var
	strWeather: string;
begin
  
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strWeather := GetElementEditValues(e, 'EDID');
	
	CopyFile(strPath, strDest + strWeather + '.ini', false)
	
end;

end.