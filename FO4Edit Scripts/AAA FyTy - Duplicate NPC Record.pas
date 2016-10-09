unit userscript;

var
	intToStartFrom, intNumberOfDuplicates: integer;
	bAlreadyDuplicatedCheck: integer;
	
function Initialize: integer;
begin
	
	intToStartFrom := 003; // This is taken from the highest, pre-existing duplicate.
	//We increase it by one during the loop, so we don't have to worry about overwriting.
	
	intNumberOfDuplicates := 7;
	bAlreadyDuplicatedCheck := false;
	
end;


function Process(e: IInterface): integer;
var
	strEDID, strDuplicateIndex, strFinalEDID: string;
	eDuplicate: IInterface;
	iCounter, iDuplicateIndex: integer;
begin

	if bAlreadyDuplicatedCheck = true then
		exit;
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	iDuplicateIndex := intToStartFrom;
	strEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	
	AddMessage(strEDID);
	
	//Now we remove the last three chars
	Delete(strEDID, Length(strEDID) - 2, 3);
	
	for iCounter := 1 to intNumberOfDuplicates do begin
	
		inc(iDuplicateIndex);
		strDuplicateIndex := Format('%0.3d',[iDuplicateIndex]);
		
		eDuplicate := wbCopyElementToFile(e, GetFile(e), true, true);
		
		AddMessage(strEDID);
		AddMessage(strDuplicateIndex);
		
		SetElementEditValues(eDuplicate, 'EDID - Editor ID', strEDID + strDuplicateIndex);
	end;
	
	bAlreadyDuplicatedCheck := true;

end;


function Finalize: integer;
begin
	
	
	
end;

end.