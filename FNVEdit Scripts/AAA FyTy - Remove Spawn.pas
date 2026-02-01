unit userscript;
var
	tstrlistToRemove: TStringList;

function Initialize: integer;
begin
  tstrlistToRemove := TStringList.Create;
	tstrlistToRemove.LoadFromFile(ScriptsPath + 'FyTy\Spawn Remover\Raiders.txt');
end;


function Process(e: IInterface): integer;
var
	strNAME: string;
begin
	
	if Signature(e) <> 'ACRE' then
		if Signature(e) <> 'ACHR' then
			Exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	strNAME := GetElementEditValues(e, 'NAME - Base');
	
	if tstrlistToRemove.IndexOf(strNAME) = -1 then begin
		RemoveNode(e);
		AddMessage('Removing');
	end;


end;


function Finalize: integer;
begin
  tstrlistToRemove.Free;
end;

end.