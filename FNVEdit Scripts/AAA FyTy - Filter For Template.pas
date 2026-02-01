unit userscript;
const
	strAudioTemplate = 'AudioTemplate';
	strDead = 'Dead';
	strDead2 = 'DEAD';


function Filter(e: IInterface): Boolean;
var
	eTemplateFlags: IInterface;
	strFlag, strEDID: string;
begin
	
	if Signature(e) <> 'CREA' then
		exit;
	
	strEDID := GetElementEditValues(e, 'EDID');
	
	if Pos(strAudioTemplate, strEDID) > 0 then
		exit;
		
	if Pos(strDead, strEDID) > 0 then
		exit;
	
	if Pos(strDead2, strEDID) > 0 then
		exit;
	
	eTemplateFlags := ElementByPath(e, 'ACBS - Configuration\Template Flags\Use Stats');
	strFlag := GetEditValue(eTemplateFlags);
		
		if (strFlag <> '') then
			Result := false // Show
		else
			Result := true; // Hide
	
end;

function Initialize: Integer;
begin
  FilterConflictAll := False;
  FilterConflictThis := False;
  FilterByInjectStatus := False;
  FilterInjectStatus := False;
  FilterByNotReachableStatus := False;
  FilterNotReachableStatus := False;
  FilterByReferencesInjectedStatus := False;
  FilterReferencesInjectedStatus := False;
  FilterByEditorID := False;
  FilterEditorID := '';
  FilterByName := False;
  FilterName := '';
  FilterByBaseEditorID := False;
  FilterBaseEditorID := '';
  FilterByBaseName := False;
  FilterBaseName := '';
  FilterScaledActors := False;
  FilterByPersistent := False;
  FilterPersistent := False;
  FilterUnnecessaryPersistent := False;
  FilterMasterIsTemporary := False;
  FilterIsMaster := False;
  FilterPersistentPosChanged := False;
  FilterDeleted := False;
  FilterByVWD := False;
  FilterVWD := False;
  FilterByHasVWDMesh := False;
  FilterHasVWDMesh := False;
  FilterBySignature := True;
  FilterSignatures := 'CREA';
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := False; // color conflicts
  FilterScripted := True; // use custom Filter() function

  ApplyFilter;

  //Result := 1;
end;

end.
