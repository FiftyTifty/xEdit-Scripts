unit userscript;


var
	tstrlistHairFormIDs, tstrlistHairlineFormIDs: TStringList;
	strHairTextFilename, strHairlineTextFilename: string;

function Initialize: integer;
begin
	tstrlistHairFormIDs := TStringList.Create;
	tstrlistHairFormIDs.Sorted := true;
	tstrlistHairFormIDs.Duplicates := dupIgnore;
	
	tstrlistHairlineFormIDs := TstringList.Create;
	tstrlistHairlineFormIDs.Sorted := true;
	tstrlistHairlineFormIDs.Duplicates := dupIgnore;
	
	strHairTextFilename := 'Hair FormIDs.txt';
	strHairlineTextFilename := 'Hairline FormIDs.txt';
	
end;

function IsPlayableFemale(eFlags: IInterface): boolean;
begin
	if GetElementNativeValues(eFlags, 'Playable') = '1' then
		if GetElementNativeValues(eFlags, 'Female') = '1' then
			Result := true
		else
			Result := false;
end;

function Process(e: IInterface): integer;
var
	strFullFormID, strFullFormIDLower: string;
	strEDID: string;
	
begin
	
	if Signature(e) <> 'HDPT' then 
		exit;
	
	if not IsPlayableFemale(ElementByPath(e, 'DATA - Flags')) then
		exit;
	
	strFullFormIDLower := AnsiLowerCase(GetEditValue(ElementByPath(e, 'Record Header\FormID')));
	strFullFormID := GetEditValue(ElementByPath(e, 'Record Header\FormID'));
	
	if Pos('hairfemale', strFullFormIDLower) = 0 then
		if Pos('_hairline', strFullFormIDLower) = 0 then
			exit;
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFullFormID := GetEditValue(ElementByPath(e, 'Record Header\FormID'));
	
	if Pos('_hairline', strFullFormIDLower) > 0 then
		tstrlistHairlineFormIDs.Add(strFullFormID)
	else
		tstrlistHairFormIDs.Add(strFullFormID);

end;


function Finalize: integer;
begin
	
	if not DirectoryExists(ProgramPath + 'Edit Scripts\FyTy\Hair\') then
		CreateDir(ProgramPath + 'Edit Scripts\FyTy\Hair\');
	
	tstrlistHairFormIDs.SaveToFile(ProgramPath + 'Edit Scripts\FyTy\Hair\' + strHairTextFilename);
	tstrlistHairlineFormIDs.SaveToFile(ProgramPath + 'Edit Scripts\FyTy\Hair\' + strHairlineTextFilename);
	
	tstrlistHairFormIDs.Free;
	tstrlistHairlineFormIDs.Free;
end;

end.