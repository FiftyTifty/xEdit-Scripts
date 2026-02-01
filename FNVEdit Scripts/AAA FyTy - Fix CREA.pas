unit userscript;
const
	strRecordFlagsPath = 'Record Header\Record Flags';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eTTW, eToCopy, eRecordFlags, eTPLT: IInterface;
begin
	
	if Signature(e) <> 'CREA' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eTTW:= MasterOrSelf(e);
	
	if OverrideCount(eTTW) < 2 then
		exit;
	
	eTTW := OverrideByIndex(eTTW, OverrideCount(eTTW) - 2);
	
	eRecordFlags := ElementByPath(eTTW, strRecordFlagsPath);
	
	wbCopyElementToRecord(eRecordFlags, e, false, true);
	
	if ElementExists(eTTW, 'CSCR') then begin
		eToCopy := ElementByPath(eTTW, 'CSCR');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'TPLT') then begin
		eToCopy := ElementByPath(eTTW, 'TPLT');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Items') then begin
		eToCopy := ElementByPath(eTTW, 'Items');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Actor Effects') then begin
		eToCopy := ElementBypath(eTTW, 'Actor Effects');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Model') then begin
		eToCopy := ElementBypath(eTTW, 'Model');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'NIFZ - Model List') then begin
		eToCopy := ElementBypath(eTTW, 'NIFZ - Model List');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'VTCK - Voice') then begin
		eToCopy := ElementBypath(eTTW, 'VTCK - Voice');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'PNAM - Body Part Data') then begin
		eToCopy := ElementBypath(eTTW, 'PNAM - Body Part Data');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'SCRI - Script') then begin
		eToCopy := ElementBypath(eTTW, 'SCRI - Script');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Packages') then begin
		eToCopy := ElementBypath(eTTW, 'Packages');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'ZNAM - Combat Style') then begin
		eToCopy := ElementBypath(eTTW, 'ZNAM - Combat Style');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'WNAM - Foot Weight') then begin
		eToCopy := ElementBypath(eTTW, 'WNAM - Foot Weight');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Factions') then begin
		eToCopy := ElementBypath(eTTW, 'Factions');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'LNAM - Melee Weapon List') then begin
		eToCopy := ElementBypath(eTTW, 'LNAM - Melee Weapon List');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'Sound Types') then begin
		eToCopy := ElementBypath(eTTW, 'Sound Types');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'INAM - Death item') then begin
		eToCopy := ElementBypath(eTTW, 'INAM - Death item');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'FULL - Name') then begin
		eToCopy := ElementBypath(eTTW, 'FULL - Name');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'EITM - Unarmed Attack Effect') then begin
		eToCopy := ElementBypath(eTTW, 'EITM - Unarmed Attack Effect');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	
	if ElementExists(eTTW, 'OBND - Object Bounds') then begin
		eToCopy := ElementBypath(eTTW, 'OBND - Object Bounds');
		wbCopyElementToRecord(eToCopy, e, false, true);
	end;
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.