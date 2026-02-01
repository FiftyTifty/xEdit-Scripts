unit userscript;
const
	strPath = 'Record Header\Record Flags\Compressed';

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin


  AddMessage('Processing: ' + FullPath(e));
	//AddMessage(GetElementEditValues(e, strPath));
	
	if GetElementEditValues(e, strPath) = '1' then
		SetElementEditValues(e, strPath, '');


end;


function Finalize: integer;
begin
	
end;

end.