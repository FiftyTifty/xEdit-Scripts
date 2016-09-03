unit userscript;

var
	i: integer;
	ePath, ePathFromIndex: IInterface;
	eString, FolderString, String01, String02: string;

function Initialize: integer;
begin
String01 := 'agentbrea';
String02 := 'calyps';
FolderString := '0Custom\';
end;


function Process(e: IInterface): integer;
begin
	if Signature(e) <> 'ARMA' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	ePath := ElementByPath(e, 'Felame World Model\MOD3 - Model Filename');
	
	for i := 0 to ElementCount(ePath) - 1 do begin
		AddMessage('Looping');
		ePathFromIndex := ElementByIndex(ePath, i);
		if pos(String01, GetEditValue(ePathFromIndex) > 0 then
			SetEditValue(ePathFromIndex, AppendStr(GetEditValue(ePathFromIndex), FolderString));
	end;

end;


function Finalize: integer;
begin

end;

end.