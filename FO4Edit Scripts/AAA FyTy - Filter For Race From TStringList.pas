unit userscript;
var
	tstrlistRobotRaces: TStringList;


function Filter(e: IInterface): Boolean;
var
	eRace: IInterface;
	strRace: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	eRace := ElementBySignature(e, 'RNAM');
	strRace := GetEditValue(eRace);
		
		if (tstrlistRobotRaces.IndexOf(strRace) > (-1)) then
			Result := true
		else
			Result := false;
	
end;

function Initialize: Integer;
begin
	
	tstrlistRobotRaces := TStringList.Create;
	tstrlistRobotRaces.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Robot Races.txt');
	
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
  InheritConflictByParent := False; // color conflicts
  FilterScripted := True; // use custom Filter() function

  ApplyFilter;

  //Result := 1;
end;

end.