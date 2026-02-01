unit userscript;


function Process(e: IInterface): integer;
var
	strPath: string;
begin
	
  if Signature(e) <> 'MUST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  strPath := GetElementEditValues(e, 'ANAM - Track Filename');
	SetElementEditValues(e, 'ANAM - Track Filename', ChangeFileExt(strPath, '.wav'));
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.