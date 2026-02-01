unit userscript;

var
	tstrlistOutput: TStringList;

function Initialize: integer;
begin
	
	tstrlistOutput := TStringList.Create;

end;

function GetLastOverride(e: IInterface): IInterface;
var
	eRec: IInterface;
begin

	eRec := MasterOrSelf(e);
	//AddMessage('eRec is: ' + Signature(eRec));
	
	if OverrideCount(eRec) > 0 then
		eRec := WinningOverride(eRec);
		
	Result := eRec;

end;

function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'LVLI' then
		exit;
	
	AddMessage('Processing: ' + FullPath(e));
	
	e := GetLastOverride(e);
	
	tstrlistOutput.Add(IntToHex(GetLoadOrderFormID(e), 8) + ',' + GetElementEditValues(e, 'Record Header\FormID'));
	
end;


function Finalize: integer;
begin
	
	tstrlistOutput.SaveToFile(ScriptsPath + 'FyTy\NPCsUseAmmo\TTW.txt');
	tstrlistOutput.Free;
	
end;

end.