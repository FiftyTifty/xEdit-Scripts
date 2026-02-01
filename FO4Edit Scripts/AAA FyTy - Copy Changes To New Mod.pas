unit userscript;
var
	eFileDest: IInterface;

function Initialize: integer;
begin
  
	eFileDest := FileByIndex($9 + 1) //Load order ID + 1 because Fallout4.exe counts in the index
	
end;

function GetLastMasterOverride(e: IInterface): IInterface;
var
	eOriginal, eOverride: IInterface;
	iCounter: integer;
begin

	eOriginal := MasterOrSelf(e);
	
	for iCounter := 0 to OverrideCount(eOriginal) - 1 do begin
	
		eOverride := OverrideByIndex(eOriginal, iCounter);
		
		//AddMessage(GetFileName(GetFile(eOverride)));
		
		if GetFileName(GetFile(eOverride)) = 'FyTy - Damage Overhaul.esp' then
			break;
	
	end;
	
	Result := eOverride;

end;

procedure MergeInto(eOverride, eMaster: IInterface);
var
  tstrlistElements: TStringList;
  eNew, eFromMaster, eFromOverride, eToNew: IInterface;
  iCounter, iConflictMask: integer;
  strElement: string;
begin
  
	eNew := wbCopyElementToFile(eMaster, eFileDest, false, true);
  
  tstrlistElements := TStringList.Create;
  
  // iterate over all elements in override
  for iCounter := 0 to Pred(ElementCount(eOverride)) do begin
	
    eFromOverride := ElementByIndex(eOverride, iCounter);
    strElement := Name(eFromOverride);
		
    // build a list of all elements in override
    tstrlistElements.Add(strElement);

    // special treatment for record header
    if strElement = 'Record Header' then begin
      // copy flags
      SetElementNativeValues(eNew, 'Record Header\Record Flags', GetElementNativeValues(eOverride, 'Record Header\Record Flags'));
      Continue;
    end;
    
    // get the same element from master
    eFromMaster := ElementByName(eMaster, strElement);

    // element exists in override but not in master, copy it to the new copy
    if not Assigned(eFromMaster) then begin
		
      if Pos(' - ', strElement) = 5 then
				strElement := Copy(strElement, 1, 4); // leave only subrecord's Element signature if present
			
      eToNew := Add(eNew, strElement, True);
      ElementAssign(eToNew, LowInteger, eFromOverride, False);
			
      Continue;
			
    end;

    // element exists in both master and override, detect conflict
    iConflictMask := ConflictAllForElements(eFromMaster, eFromOverride, False, IsInjected(eMaster));
		
    // copy it into the new override if data is different
    if iConflictMask >= caConflictBenign then
      ElementAssign(eToNew, LowInteger, eFromOverride, False);
			
  end;
	
	// remove elements from the new roverride that don't exist in the source override
  for iCounter := Pred(ElementCount(eNew)) downto 0 do begin
	
    eToNew := ElementByIndex(eNew, iCounter);
		
    if tstrlistElements.IndexOf(Name(eToNew)) = -1 then
      Remove(eToNew);
			
  end;  
  
  tstrlistElements.Free;
	
end; 


function Process(e: IInterface): integer;
var
	eMaster: IInterface;
begin
	
  if GetFileName(GetFile(e)) <> 'FyTy - Damage Overhaul.esp' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eMaster := GetLastMasterOverride(e);
	
  MergeInto(e, eMaster);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.