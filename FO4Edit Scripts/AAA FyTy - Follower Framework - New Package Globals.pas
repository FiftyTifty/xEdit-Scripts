unit userscript;
var
	tstrlistGlobalFollow, tstrlistGlobalGuard,
	tstrlistGlobalSandbox, tstrlistGlobalWait: TStringList;
	
	strFindFollow, strFindGuard, strFindSandbox, strFindWait,
	strResourceDir: string;


function Initialize: integer;
begin
  tstrlistGlobalFollow := TStringList.Create;
	tstrlistGlobalGuard := TStringList.Create;
	tstrlistGlobalSandbox := TStringList.Create;
	tstrlistGlobalWait := TStringList.Create;
	
	strResourceDir := ScriptsPath + 'FyTy\Follower Framework\';
	
	tstrlistGlobalFollow.LoadFromFile(strResourceDir + 'GlobalFollow.txt');
	tstrlistGlobalGuard.LoadFromFile(strResourceDir + 'GlobalGuard.txt');
	tstrlistGlobalSandbox.LoadFromFile(strResourceDir + 'GlobalSandbox.txt');
	tstrlistGlobalWait.LoadFromFile(strResourceDir + 'GlobalWait.txt');
	
	strFindFollow := '_Follow';
	strFindGuard := '_Guard';
	strFindSandbox := '_Sandbox';
	strFindWait := '_Wait';
end;


procedure UpdateGlobalCondition(e: IInterface; iPackageType: integer);
var
	eCondition: IInterface;
	strEDID, strNewEDID, strSuffix: string;
	iCounter, iSuffix, iIndex: integer;
begin
	
	strEDID := GetElementEditValues(e, 'EDID');
	
	eCondition := ElementByPath(e, 'Conditions');
	eCondition := ElementByIndex(eCondition, 0);
	eCondition := ElementByPath(eCondition, 'CTDA - \Global');
	
	
	strNewEDID := Copy(strEDID, 1, Length(strEDID) - 2);
	strSuffix := Copy(strEDID, Length(strEDID) - 1, 2);
	//ShowMessage(strNewEDID);
	//ShowMessage(strSuffix);
	
	iSuffix := StrToInt(strSuffix);
	iIndex := iSuffix - 2;
	
	if iPackageType = 1 then
		SetEditValue(eCondition, tstrlistGlobalFollow[iIndex])
	else if iPackageType = 2 then
		SetEditValue(eCondition, tstrlistGlobalGuard[iIndex])
	else if iPackageType = 3 then
		SetEditValue(eCondition, tstrlistGlobalSandbox[iIndex])
	else if iPackageType = 4 then
		SetEditValue(eCondition, tstrlistGlobalWait[iIndex])
	
	
end;


function Process(e: IInterface): integer;
var
	strEDID: string;
	iPackageType: integer;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	strEDID := GetElementEditValues(e, 'EDID');
	
	
	if Pos(strFindFollow, strEDID) >= 0 then
		iPackageType := 1
	else if Pos(strFindGuard, strEDID) >= 0 then
		iPackageType := 2
	else if Pos(strFindSandbox, strEDID) >= 0 then
		iPackageType := 3
	else if Pos(strFindWait, strEDID) >= 0 then
		iPackageType := 4;
	
	UpdateGlobalCondition(e, iPackageType);
		
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.