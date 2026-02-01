unit userscript;
var
	tstrlistText: TStringList;
	strFilePath: string;

function Initialize: integer;
begin

  tstrlistText := TStringList.Create;
	strFilePath := ScriptsPath + 'FyTy\Movable Statics To Items\Fallout4esm Dest.txt';
	
end;

function Process(e: IInterface): integer;
var
	strFullFormID: string;
begin
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFullFormID := GetElementEditValues(e, 'Record Header\FormID');
	
	tstrlistText.Add(strFullFormID);


end;


function Finalize: integer;
begin
  tstrlistText.SaveToFile(strFilePath);
end;

end.
