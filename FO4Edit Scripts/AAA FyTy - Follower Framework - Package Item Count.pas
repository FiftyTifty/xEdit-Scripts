unit userscript;
var
	tstrlistSubstrings, tstrlistItemCounts: TStringList;

function Initialize: integer;
begin
  tstrlistSubstrings := TStringList.Create;
	tstrlistSubstrings.LoadFromFile(ScriptsPath + 'FyTy\Follower Framework\PackageConditionSubstrings.txt');
	
	tstrlistItemCounts := TStringList.Create;
	tstrlistItemCounts.LoadFromFile(ScriptsPath + 'FyTy\Follower Framework\PackageConditionSubstrings.txt');
end;


function GetItemCountForCondition(strEDID: string): string;
var
	iCounter: integer;
begin
	
	for iCounter := 0 to tstrlistSubstrings.Count - 1 do begin
		if Pos(tstrlistSubstrings[iCounter], strEDID) > 0 then
			break;
	end;
	
	inc(iCounter);
	Result := IntToStr(iCounter);
	
end;


function Process(e: IInterface): integer;
var
	eCondition: IInterface;
	strItemCount: string;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strItemCount := GetItemCountForCondition(GetElementEditValues(e, 'EDID - Editor ID'));
	
	eCondition := ElementByPath(e, 'Conditions');
	eCondition := ElementByIndex(eCondition, 0);
	eCondition := ElementByPath(eCondition, 'CTDA - ');
	
	SetElementEditValues(eCondition, 'Comparison Value - Float', strItemCount);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.