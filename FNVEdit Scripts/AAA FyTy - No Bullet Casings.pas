unit userscript;
const
	strFileNamePrefix = 'FyTy - No Bullet Casings';

var
	fileDest: IInterface;

function Initialize: integer;
begin

	FileDest := FileByIndex(20);
  
end;

function Process(e: IInterface): integer;
var
	eRecord: IInterface;
begin

	if Signature(e) <> 'WEAP' then
		exit;
	
	if ElementExists(e, 'Shell Casing Model') = false then
		exit;
	
	eRecord := e;
	
	if OverrideCount(eRecord) > 0 then
		eRecord := WinningOverride(eRecord);
	
  AddMessage('Processing: ' + FullPath(e));
	
	eRecord := wbCopyElementToFile(eRecord, fileDest, false, true);
	
	RemoveElement(eRecord, 'Shell Casing Model');


end;

function Finalize: integer;
begin

	CleanMasters(fileDest);
	SortMasters(fileDest);
	
end;

end.