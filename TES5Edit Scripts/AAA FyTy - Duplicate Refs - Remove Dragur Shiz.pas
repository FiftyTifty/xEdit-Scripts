unit userscript;

var
	i, DraugrIndex: integer;
	bRemoveUnneededData, bReplaceDraugr, bRemoveScript, bRemoveLinked, bRemoveActive: Boolean;
	Check: IInterface;
	ListOfAmbushDraugr, ListOfReplaceDraugr: TStringList;
	ReplacementDraugr: string;

	
//Setting the booleans; we need them to keep things concise.
function Initialize: integer;
begin
	bRemoveUnneededData := true;
	bReplaceDraugr := true;
	bRemoveScript := false;
	bRemoveLinked := true;
	bRemoveActive := true;
end;

//Simple procedures to remove elements from ACHR refs
procedure RemoveScriptFromRef(e: IInterface);
begin
		AddMessage('Has a script');
		AddMessage('Removing Script');
		Remove(ElementByPath(e, 'VMAD - Virtual Machine Adapter'));
end;

procedure RemoveLinkedReferencesFromRef(e: IInterface);
begin
		AddMessage('Has Linked References');
		AddMessage('Removing Linked References');
		Remove(ElementByPath(e, 'Linked References'));
end;

//This seems to be what was the issue; the ambush draugr need to be "activated" by the player before they have their AI processed.
procedure RemoveActivateParentsFromRef(e: IInterface);
begin
		AddMessage('Has Activate Parents');
		AddMessage('Removing Activate Parents');
		Remove(ElementByPath(e, 'Activate Parents'));
end;

procedure CallRemovalProcedures(e: IInterface);
begin
	AddMessage('Removing Stuff');
	
	if bRemoveScript = true then
		RemoveScriptFromRef(e);
		
	if bRemoveLinked = true then
		RemoveLinkedReferencesFromRef(e);
		
	if bRemoveActive = true then
		RemoveActivateParentsFromRef(e);
end;

//I organized the draugr FormID lists so that we have the original ambush draugr record(s) being on the same line
//as the non-ambush draugr records. That allows the script to just find the line number from the first list, to get
//the record we want to replace it with from the second list.
procedure ReplaceDraugr(e: IInterface);
begin
	AddMessage('Replacing Draugr');
	DraugrIndex := ListOfAmbushDraugr.IndexOf(Check);
	AddMessage(IntToStr(DraugrIndex));
	ReplacementDraugr := ListOfReplaceDraugr[DraugrIndex];
	AddMessage(ReplacementDraugr);
	
	SetElementEditValues(e, 'NAME - Base', ReplacementDraugr);
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'ACHR' then
		exit;
	
  //AddMessage('Processing: ' + FullPath(e));
	
	ListOfAmbushDraugr := TStringList.Create;
	ListOfAmbushDraugr.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs - Ambush Draugr.txt');
	ListOfAmbushDraugr.Sort;
	
	ListOfReplaceDraugr := TStringList.Create;
	ListOfReplaceDraugr.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs - Non-Ambush Draugr.txt');
	ListOfReplaceDraugr.Sort;
	
	Check := GetEditValue(ElementByPath(e, 'NAME - Base'));
	
	if (ListOfAmbushDraugr.IndexOf(Check) > 0) then
		ReplaceDraugr(e);
	
	if (ListOfAmbushDraugr.IndexOf(Check) > 0) then
		if (bRemoveUnneededData = true) then
			CallRemovalProcedures(e);
	
	if (ListOfReplaceDraugr.IndexOf(Check) > 0) then
		if (bRemoveUnneededData = false) then
			CallRemovalProcedures(e);
	
	ListOfAmbushDraugr.free;
	ListOfReplaceDraugr.free;
	
end;


function Finalize: integer;
begin
	
end;

end.