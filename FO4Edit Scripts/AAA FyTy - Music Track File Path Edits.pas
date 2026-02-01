unit userscript;


function Process(e: IInterface): integer;
var
	strPath: string;
begin
	
  if Signature(e) <> 'MUST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  strPath := GetElementEditValues(e, 'ANAM - Track Filename');
	strPath := StringReplace(strPath, '\sound\', '\music\', [rfReplaceAll, rfIgnoreCase]);
	SetElementEditValues(e, 'ANAM - Track Filename', strPath);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.