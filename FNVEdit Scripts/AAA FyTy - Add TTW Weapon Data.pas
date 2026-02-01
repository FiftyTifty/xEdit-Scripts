unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
var
	eOriginal: IInterface;
	iOverrideIndex, iNumOverrides: integer;
	strValue: string;
begin

	if Signature(e) <> 'WEAP' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	if IsWinningOverride(e) = true then begin
	
		eOriginal := MasterOrSelf(e);
		
		iNumOverrides := OverrideCount(eOriginal);
		
		AddMessage(IntToStr(iNumOverrides));
		
		if iNumOverrides > 1 then
			eOriginal := OverrideByIndex(eOriginal, iNumOverrides - 2);
			
		AddMessage('Checking: ' + FullPath(eOriginal));
			
		//Begin copying over new data

		if ElementExists(e, 'DNAM') then
			wbCopyElementToRecord(ElementBySignature(eOriginal, 'DNAM'), e, false, true);
		
		if ElementExists(e, 'OBND') then
			wbCopyElementToRecord(ElementBySignature(eOriginal, 'OBND'), e, false, true);
			
		strValue := GetElementEditValues(eOriginal, 'DATA - DATA\Value');
		AddMessage(strValue);
		
		SetElementEditValues(e, 'DATA - DATA\Value', strValue);
			
		
	end;


end;


function Finalize: integer;
begin
	
end;

end.