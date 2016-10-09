unit userscript;
var
	strFind, strReplace: string;

function Initialize: integer;
begin
	
	strFind := '_TempList_';
	strReplace := '_FaceF_List_';
	
end;


function Process(e: IInterface): integer;
var
	iPos: integer;
	strEDID: string;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	strEDID:= GetEditValue(ElementBySignature(e, 'EDID'));
	
	iPos := Pos(strFind, strEDID);
	Delete(strEDID, iPos, Length(strFind));
	Insert(strReplace, strEDID, iPos);
	
	//AddMessage(strEDID);
	SetEditValue(ElementBySignature(e, 'EDID'), strEDID);

end;


function Finalize: integer;
begin
	
	
	
end;

end.