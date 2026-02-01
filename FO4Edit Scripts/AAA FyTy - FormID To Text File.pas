unit userscript;
var
	tstrlistText: TStringList;
	strFilePath: string;

function Initialize: integer;
begin
  tstrlistText := TStringList.Create;
	strFilePath := ScriptsPath + 'FyTy\Records From Formlist\DestFormlists.txt';
end;


function Process(e: IInterface): integer;
var
	strFormID: string;
begin
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFormID := FixedFormID(e);
	
	tstrlistText.Add(strFormID);


end;


function Finalize: integer;
begin
  tstrlistText.SaveToFile(strFilePath);
	tstrlistText.Free;
end;

end.
