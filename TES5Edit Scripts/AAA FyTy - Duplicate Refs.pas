unit userscript;
uses mtefunctions;

var
	MyFile, OverridingRecord: IInterface;
	NameCheck, Replace, MasterName: string;
	i, MyFileIndex, iOverrides: integer;
	//iOverrides: cardinal;
	ListOfNPCs, ListOfFalmer, ListOfDwemer: TStringList;
	IsOverride, DoTwice, DoTheBigList, DoFalmer, DoDwemer: Boolean;
	
function Initialize: integer;
begin
	MyFile := FileSelect('Choose/create the destination file'); // Using the FileSelect function from mtefunctions.pas
	AddMessage('Assigned File');
	AddMessage('File Name Is: '+GetFileName(MyFile));
	AddMasterIfMissing(MyFile, 'Skyrim.esm'); // Make sure that we have Skyrim as a master
	
	for i := 1 to FileCount - 1 do begin // Loop through to add all the .esp and .esm files as masters. Later, we'll get rid of the ones we don't need
		MasterName := GetFileName(FileByIndex(i));
		if MasterName = GetFileName(MyFile) then // Exits the loop when we reach our destination file. Prevents xEdit from crashing.
			break;
		if MasterName <> 'Skyrim.Hardcoded.keep.this.with.the.exe.and.otherwise.ignore.it.I.really.mean.it.dat' then // Make sure we ignore it.
			AddMasterIfMissing(MyFile, MasterName);
		AddMessage('Added master '+MasterName);
	end;
	
	DoTwice := true; // If false, duplicate spawns once (2x spawns). If true, duplicate them twice (3x spawns)
	DoTheBigList := true; // If true, duplicate most of the spawns, sans Falmer and Dwemer
	DoFalmer := false; // If true, duplicate falmer spawns
	DoDwemer := false; // If true, duplicate dwemer spawns
	
	SortMasters(MyFile);
end;

procedure TStringListStuff; // Just setting up our spawn lists.
begin
	ListOfNPCs := TStringList.Create;
	ListOfNPCs.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs.txt');
	ListOfNPCs.Sort;
	
	ListOfFalmer := TStringList.Create;
	ListOfFalmer.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs - Falmer.txt');
	ListOfFalmer.Sort;
	
	ListOfDwemer := TStringList.Create;
	ListOfDwemer.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs - Dwemer.txt');
	ListOfDwemer.Sort;
end;

procedure DuplicateReferences(e: IInterface);
begin

	if (ListOfNPCs.IndexOf(NameCheck) > 0) then // Make sure that the spawn we're duplicating is the one we want
		if (DoTheBigList = true) then
			if (iOverrides > 0) then begin
				AddMessage('Duplicating override of: ' + NameCheck);
				wbCopyElementToFile(OverrideByIndex(e, iOverrides - 1), MyFile, true, true);
				AddMessage('Duplicated successfully');
			end;
	
	if (ListOfNPCs.IndexOf(NameCheck) > 0) then
		if (DoTheBigList = true) then
			if (iOverrides = 0) then begin
				AddMessage('Duplicating: ' + NameCheck);
				wbCopyElementToFile(e, MyFile, true, true);
				AddMessage('Duplicated successfully');
			end;
	
	if (ListOfFalmer.IndexOf(NameCheck) > 0) then
		if (DoFalmer = true) then
			if (DoTheBigList = false) then
				if (iOverrides > 0) then begin
					AddMessage('Duplicating override of: ' + NameCheck);
					wbCopyElementToFile(OverrideByIndex(e, iOverrides - 1), MyFile, true, true);
					AddMessage('Duplicated successfully');
				end;
	
	if (ListOfFalmer.IndexOf(NameCheck) > 0) then 
		if (DoFalmer = true) then
			if (DoTheBigList = false) then
				if (iOverrides = 0) then begin
					AddMessage('Duplicating: ' + NameCheck);
					wbCopyElementToFile(e, MyFile, true, true);
					AddMessage('Duplicated successfully');
				end;
	
	if (ListOfDwemer.IndexOf(NameCheck) > 0) then
		if (DoDwemer = true) then
			if (DoTheBigList = false) then
				if (iOverrides > 0) then begin
					AddMessage('Duplicating override of: ' + NameCheck);
					wbCopyElementToFile(OverrideByIndex(e, iOverrides - 1), MyFile, true, true);
					AddMessage('Duplicated successfully');
				end;
	
	if (ListOfDwemer.IndexOf(NameCheck) > 0) then
		if (DoDwemer = true) then
			if (DoTheBigList = false) then
				if (iOverrides = 0) then begin
					AddMessage('Duplicating: ' + NameCheck);
					wbCopyElementToFile(e, MyFile, true, true);
					AddMessage('Duplicated successfully');
				end;
	
end;

procedure FreeLists;
begin
	ListOfNPCs.Free;
	ListOfFalmer.Free;
	ListOfDwemer.Free;
end;


function Process(e: IInterface): integer;
begin
  if (Signature(e) <> 'ACHR') then
		if (Signature(e) <> 'ACRE') then
			exit;	
	
//	AddMessage('Processing: ' + FullPath(e));
	
	IsOverride := false; // Just to be safe, set our override check to false before we do stuff
	iOverrides := OverrideCount(e);
	
	NameCheck := GetEditValue(ElementByPath(e, 'NAME - Base')); // Used to ensure we're duplicating the correct spawn

	TStringListStuff;

	if DoTwice = false then
		DuplicateReferences(e);
	
	if DoTwice = true then begin
		DuplicateReferences(e);
		DuplicateReferences(e);
	end;

	FreeLists;
end;

function Finalize: integer;
begin
  CleanMasters(MyFile);
  SortMasters(MyFile);
  AddMessage('Cleaned our file masters');
end;

end.
