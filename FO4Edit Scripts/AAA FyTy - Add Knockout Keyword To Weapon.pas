unit userscript;
const
	strFileDest = 'FyTy - Knockout Framework Weapon Keywords.esp';
var
	fileDest: IInterface;

procedure AddKnockoutKeyword(eKWDA: IInterface);
var
	eAdded: IInterface;
begin

	eAdded := ElementAssign(eKWDA, HighInteger, nil, false);
	
	SetEditValue(eAdded, 'KFWeaponCanKnockoutKeyword [KYWD:08000FA2]')
	
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
	eKWDA, eOverride: IInterface;
begin
	
  if Signature(e) <> 'WEAP' then
		exit;
		
  //AddMessage('Processing: ' + FullPath(e));
	
	eOverride := GetSecondLastOverride(e);
	
	//AddMessage(GetFileName(GetFile(eOverride)));
	
	eOverride := wbCopyElementToFile(eOverride, fileDest, false, true);
	
	//AddMessage(GetFileName(GetFile(eOverride)));
	
	if ElementExists(eOverride, 'KWDA') = false then
		eKWDA := Add(eOverride, 'KWDA', true)
	else
		eKWDA := ElementByPath(eOverride, 'KWDA');
	
  AddKnockoutKeyword(eKWDA);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.