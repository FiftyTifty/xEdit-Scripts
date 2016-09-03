unit userscript;

var
	eRoadLeathers, ArmourOffsets: IInterface;
	Fallout4File: IInterface;

function Initialize: integer;
begin
	Fallout4File := FileByIndex(0);
	
	eRoadLeathers := RecordByFormID(Fallout4File, 717025, true);
	ArmourOffsets := ElementByPath(eRoadLeathers, 'Unknown');
end;


function Process(e: IInterface): integer;
begin
	if Signature(e) <> 'ARMA' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
  AddElement(e, ArmourOffsets);

end;


function Finalize: integer;
begin
	
end;

end.