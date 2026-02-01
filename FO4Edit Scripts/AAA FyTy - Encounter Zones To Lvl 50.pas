unit userscript;
var
	fileDestination: IInterface;
	bEditFlags: boolean;

function Initialize: integer;
begin
	
	//fileDestination := FileByIndex(9);
	bEditFlags := false;
	
end;


function Process(e: IInterface): integer;
var
	eCopiedZone, eFlags: IInterface;
	strFlags: string;
begin
	
	if Signature(e) <> 'ECZN' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	//eCopiedZone := wbCopyElementToFile(e, fileDestination, false, true);
	eFlags := ElementByPath(e, 'DATA - DATA\Flags');
	
	SetElementEditValues(e, 'DATA - DATA\Min Level', '50');
	SetElementEditValues(e, 'DATA - DATA\Max Level', '51');
	
	if GetElementEditValues(eFlags, 'Match PC Below Minimum level') = '1' then
		SetElementEditValues(eFlags, 'Match PC Below Minimum level', '0');
	
	if bEditFlags then
		begin
		
			strFlags := GetEditValue(eFlags);
			
			if Length(strFlags) > 2 then
				if strFlags[3] = '0' then
					begin
						Delete(strFlags, 3, 1);
						Insert('1', strFlags, 3);
					end;
			
			if Length(strFlags) = 2 then
				strFlags := strFlags + '1';
			
			if Length(strFlags) = 1 then
				strFlags := strFlags + '01';
			
			SetEditValue(eFlags, strFlags);
			
		end;
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.