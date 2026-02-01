unit AAAFyTyFilterForNPCSpawns;


function Filter(e: IInterface): Boolean;
var
	eBase, eBaseOverride, eReference: IInterface;
	strFlag, strEDID, strName, strSignature: string;
	iCounter, iOverrides, iNumReferences: integer;
begin
	
	{
	if (Signature(e) <> 'CREA') or (Signature(e) <> 'NPC_') then begin
		Result := 0;
		exit;
	end;
	}
	
	eBase := MasterOrSelf(e);
	
	if OverrideCount(eBase) > 0 then
		eBaseOverride := WinningOverride(eBase)
	else
		eBaseOverride := eBase;
	
	strEDID := GetElementEditValues(eBaseOverride, 'EDID - Editor ID');
	strName := GetElementEditValues(eBaseOverride, 'FULL - Name');
	
	if (pos('DEAD', strName) > 0) or (pos('Dead', strName) > 0)
			or (pos('DEAD', strEDID) > 0) or (pos('Dead', strEDID) > 0) then begin
			
		Result := false;
		exit;
		
	end;
	
	iNumReferences := ReferencedByCount(eBase);
	
	iOverrides := 0;
	
	if (iNumReferences > 1) then
		for iCounter := 0 to iNumReferences - 1 do begin
		
			eReference := ReferencedByIndex(eBase, iCounter);
			strSignature := Signature(eReference);
			//AddMessage(BaseName(eReference));
				
			if (strSignature = 'ACHR') or (strSignature = 'ACRE') then				
				inc(iOverrides);
				
			if iOverrides > 1 then begin
			
				Result := true;
				exit;
				
			end;
		
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
  FilterSignatures := 'CREA,NPC_';
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
