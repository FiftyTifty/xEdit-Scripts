unit userscript;
var
	eFile: IInterface;


function Initialize: integer;
begin
  eFile := FileByIndex(11);
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'PERK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if (GetElementEditValues(e, 'DATA - Data\Playable') = 'Yes') then
		if (GetElementEditValues(e, 'DATA - Data\Hidden') = 'No') then begin
			e := wbCopyElementToFile(e, eFile, false, true);
			SetElementEditValues(e, 'DATA - Data\Min level', 1);
		end;

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.