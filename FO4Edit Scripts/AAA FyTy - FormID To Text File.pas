unit userscript;
var
	tstrlistNPCFormIDs: TStringList;
	strTextFileName: string;

function Initialize: integer;
begin
	tstrlistNPCFormIDs := TStringList.Create;
	strTextFileName := 'Hot Mama Leveled Lists.txt';
end;


function Process(e: IInterface): integer;
var
	strFullFormID: string;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	strFullFormID := GetEditValue(ElementByPath(e, 'Record Header\FormID'));
	tstrlistNPCFormIDs.Add(strFullFormID);

end;


function Finalize: integer;
begin
	tstrlistNPCFormIDs.SaveToFile(ProgramPath + 'Edit Scripts\FyTy\' + strTextFileName);
	tstrlistNPCFormIDs.Free;
end;

end.