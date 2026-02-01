unit userscript;
const
	strFileDest = 'FyTy - Knockout Framework Weapon Keywords.esp';
	bSetRemoveKeyword = true;
var
	fileDest: IInterface;

procedure AddKnockoutKeyword(eProperties: IInterface; bRemove: boolean);
var
	eAdded: IInterface;
	strType, strValue: string;
begin

	eAdded := ElementAssign(eProperties, HighInteger, nil, false);
	
	strValue := '1';
	
	if bRemove then
		strType := 'REM'
	else
		strType := 'ADD';
	
	SetElementEditValues(eAdded, 'Value Type', 'FormID,Int');
	SetElementEditValues(eAdded, 'Function Type', strType);
	SetElementEditValues(eAdded, 'Property', 'Keywords');
	SetElementEditValues(eAdded, 'Value 1 - FormID', 'KFWeaponCanKnockoutKeyword [KYWD:08000FA2]');
	SetElementEditValues(eAdded, 'Value 2 - Int', strValue);

end;

function GetSecondLastOverride(e: IInterface): IInterface;
var
	iCounter: integer;
	eOriginal, eOverride: IInterface;
begin

	eOriginal := MasterOrSelf(e);
	
	for iCounter := 0 to OverrideCount(eOriginal) - 1 do begin

		eOverride := OverrideByIndex(eOriginal, iCounter);
		
		if GetFileName(GetFile(eOverride)) = strFileDest then
			break;

	end;
	
	//AddMessage(GetFileName(GetFile(eOverride)));
	Result := eOverride;

end;

function Initialize: integer;
var
	iCounter: integer;
begin
  
	for iCounter := 0 to FileCount - 1 do begin
	
		if GetFileName(FileByIndex(iCounter)) = strFileDest then
			fileDest := FileByIndex(iCounter);
	
	end;
	
	//AddMessage(GetFileName(fileDest));
	
end;


function Process(e: IInterface): integer;
var
	eDATA, eProperties, eOverride: IInterface;
begin
	
  if Signature(e) <> 'OMOD' then
		exit;
		
  //AddMessage('Processing: ' + FullPath(e));
	
	eOverride := GetSecondLastOverride(e);
	
	//AddMessage(GetFileName(GetFile(eOverride)));
	
	eOverride := wbCopyElementToFile(eOverride, fileDest, false, true);
	
	//AddMessage(GetFileName(GetFile(eOverride)));
	
	eDATA := ElementByPath(eOverride, 'DATA - Data');
	
	if ElementExists(eDATA, 'Properties') = false then
		eProperties := Add(eDATA, 'Properties', true)
	else
		eProperties := ElementByPath(eDATA, 'Properties');
	
  AddKnockoutKeyword(eProperties, bSetRemoveKeyword);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.