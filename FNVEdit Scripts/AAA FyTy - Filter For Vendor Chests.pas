unit AAAFyTyFilterForNPCSpawns;

var
	fileMyFile: IInterface;


function Filter(e: IInterface): Boolean;
var
	eBase, eBaseOverride: IInterface;
	strEDID, strName, strSignature: string;
	bRespawns: Boolean;
begin
	
	eBase := MasterOrSelf(e);
	
	if OverrideCount(eBase) > 0 then
		eBaseOverride := WinningOverride(eBase)
	else
		eBaseOverride := eBase;
	
	strEDID := GetElementEditValues(eBaseOverride, 'EDID - Editor ID');
	strName := GetElementEditValues(eBaseOverride, 'FULL - Name');
	
	bRespawns := (GetElementEditValues(eBaseOverride, 'DATA - Data\Flags\Respawns') = '1');
	
	if ((bRespawns = true) or (Signature(eBase) = 'REFR')) and ((pos('Vendor', strName) > 0) or (pos('Vendor', strEDID) > 0) ) then begin
			
		wbCopyElementToFile(eBaseOverride, fileMyFile, false, true);
		Result := true;
		exit;
		
	end;
	
	Result := false;
	
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
  FilterSignatures := 'CONT,REFR';
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := False; // color conflicts
  FilterScripted := True; // use custom Filter() function

	fileMyFile := FileByLoadOrder($0E);
	
  ApplyFilter;

  //Result := 1;
end;

end.
