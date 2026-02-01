unit userscript;

var
	tstrlistAll: TStringList;

function Initialize: integer;
begin

	tstrlistAll := TStringList.Create;
	tstrlistAll.Sorted := true;
	tstrlistAll.Duplicates := dupIgnore;
	
end;

function Process(e: IInterface): integer;
var
	eRec: IInterface;
	strFullFormID: string;
begin
	
	if (Signature(e) <> 'NPC_') and (Signature(e) <> 'CREA') then
		exit;
	
	eRec := MasterOrSelf(e);
	
	if OverrideCount(eRec) > 0 then
		eRec := WinningOverride(eRec);
	
	strFullFormID := GetEditValue(ElementByPath(eRec, 'Record Header\FormID'));
	
	tstrlistAll.Add(strFullFormID);
	
end;


function Finalize: integer;
begin

	tstrlistAll.SaveToFile(ScriptsPath + 'FyTy\More Spawns\xEditOutput.txt');
  tstrlistAll.Free;
	
end;

end.
