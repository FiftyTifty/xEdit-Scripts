unit userscript;

var
	fileMyFile: IInterface;


function Process(e: IInterface): integer;
var
	eOrig, eOrigMSDV, eOverMSDV: IInterface;
	iConflictStatus: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	if ConflictAllForMainRecord(e) < caOverride then
    exit;
	
	
	fileMyFile := GetFile(e);
	
  AddMessage('Processing: ' + FullPath(e));
	
	eOrig := MasterOrSelf(e);
	
	if (ElementExists(e, 'MSDV - Morph Values')) and (not ElementExists(eOrig, 'MSDV - Morph Values')) then
		exit;
	
	if (not ElementExists(eOrig, 'MSDV - Morph Values')) and (not ElementExists(e, 'MSDV - Morph Values')) then begin
		
		RemoveNode(e);
		exit;
		
	end;
	
	eOrigMSDV := ElementBySignature(eOrig, 'MSDV');
	eOverMSDV := ElementBySignature(e, 'MSDV');
	
	iConflictStatus := ConflictAllForElements(eOverMSDV, eOrigMSDV, False, False);
	
	//caConflictBenign = 3, 0-2 are not conflicts, 3-6 are conflicts
	if (iConflictStatus < caConflictBenign) and (iConflictStatus <> caOnlyOne) then
    RemoveNode(e);
	
	
	
end;

end.