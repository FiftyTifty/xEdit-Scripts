unit userscript;
var
	strPoodle, strScarf: string;


function Filter(e: IInterface): Boolean;
var
	eHeadParts, eHeadPart: IInterface;
	iCounter: integer;
	strHair: string;
begin
	eHeadParts := ElementByPath(e, 'Head Parts');
	
	for iCounter := ElementCount(eHeadParts) - 1 downto 0 do begin
	
		eHeadPart := ElementByIndex(eHeadParts, iCounter);
		strHair := GetEditValue(eHeadPart);
		
		if (strHair = strPoodle) or (strHair = strScarf) then
			Result := true;
			
	end;

	
end;

function Initialize: Integer;
begin
	strScarf := 'DLC04HairFemale40_Scarf "DLC04HairFemale40_Scarf" [HDPT:0601951B]';
	strPoodle := 'DLC04HairFemale40 "Poodleskirt" [HDPT:0601951A]';
	
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
  FilterSignatures := 'NPC_';
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := True; // color conflicts
  FilterScripted := True; // use custom Filter() function

  ApplyFilter;

  Result := 1;
end;

end.