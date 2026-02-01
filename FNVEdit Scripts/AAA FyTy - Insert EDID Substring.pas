unit userscript;
const
	strToInsert = 'FW';
	strToFind = 'AAAFyTy';

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
var
	strEDID: string;
	iPos: integer;
begin

  AddMessage('Processing: ' + FullPath(e));
  
  strEDID := GetElementEditValues(e, 'EDID');
	
	iPos := Pos(strToFind, strEDID);
	
	if iPos > 0 then begin
	
		Insert(strToInsert, strEDID, iPos + Length(strToFind));
		SetElementEditValues(e, 'EDID', strEDID);
		
	end;


end;


function Finalize: integer;
begin
	
end;

end.