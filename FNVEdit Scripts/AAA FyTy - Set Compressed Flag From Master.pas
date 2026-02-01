unit userscript;

const
	strPath = 'Record Header\Record Flags\Compressed';

function Process(e: IInterface): integer;
var
	eMaster, eFlags: IInterface;
	iNumOverrides: integer;
	strFlag: string;
begin

	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eMaster := MasterOrSelf(e);
	
	iNumOverrides := OverrideCount(eMaster);
	
	if OverrideCount(eMaster) > 1 then
		eMaster := OverrideByIndex(eMaster, iNumOverrides - 2); //Get the 2nd last override
		
	eFlags := ElementByPath(e, 'Record Header\Record Flags');
	
	if GetElementEditValues(eMaster, strPath) = '1' then
		SetElementNativeValues(e, strPath, True)
	else
		SetElementNativeValues(e, strPath, False);


end;


function Finalize: integer;
begin
	
end;

end.