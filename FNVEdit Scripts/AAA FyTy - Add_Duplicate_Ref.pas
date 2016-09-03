unit userscript;
uses mtefunctions;

var
	MyFile, OverridingRecord: IInterface;
	Check, Replace, MasterName: string;
	i, MyFileIndex, iOverrides: integer;
	//iOverrides: cardinal;
	ListOfNPCs: TStringList;
	IsOverride: Boolean;
	
function Initialize: integer;
begin
	MyFile := FileSelect('Choose/create the destination file');
	AddMessage('Assigned File');
	AddMessage('File Name Is: '+GetFileName(MyFile));
	AddMasterIfMissing(MyFile, 'FalloutNV.esm');
	
	for i := 1 to FileCount - 1 do begin
		MasterName := GetFileName(FileByIndex(i));
		if MasterName = GetFileName(MyFile) then
			break;
		if MasterName <> 'FalloutNV.Hardcoded.keep.this.with.the.exe.and.otherwise.ignore.it.I.really.mean.it.dat' then
			AddMasterIfMissing(MyFile, MasterName);
		AddMessage('Added master '+MasterName);
	end;
	
	SortMasters(MyFile);
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'ACHR' then
		exit;	
		//ACHR or ACRE
//	AddMessage('Processing: ' + FullPath(e));
	
	IsOverride := false;
//	AddMessage(inttostr(OverrideCount(e)));
	iOverrides := OverrideCount(e);
//	AddMessage(inttostr(iOverrides));
	
//	AddMessage('Set IsOverride to false, as that is the initial state');
	
	ListOfNPCs := TStringList.Create;
	//AddMessage('Created String List');
	ListOfNPCs.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\LvlNPC FormIDs.txt');
	//AddMessage('Loaded List From File');
	ListOfNPCs.Sort;
	//AddMessage('Sorted List');
		
		
	Check := GetEditValue(ElementByPath(e, 'NAME - Base'));
//	AddMessage('Assigned Check Variable: '+Check);
//	AddMessage(inttostr(ListOfNPCs.IndexOf(Check)));
	
	if (ListOfNPCs.IndexOf(Check) > 0) then begin
		if iOverrides > 0 then
			wbCopyElementToFile(OverrideByIndex(e, iOverrides - 1), MyFile, true, true);
		if iOverrides = 0 then
			wbCopyElementToFile(e, MyFile, true, true);
	end;
		
	ListOfNPCs.Free;

end;

function Finalize: integer;
begin
  //CleanMasters(MyFile);
  //SortMasters(MyFile);
  //AddMessage('Cleaned our file masters');
end;

end.