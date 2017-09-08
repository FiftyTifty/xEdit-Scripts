unit userscript;
var
	tstrlistMainPackageIDs: TStringList;
	strFar, strMed, strShort: string;
	MyFile: IInterface;


function Initialize: integer;
begin
  tstrlistMainPackageIDs := TStringList.Create;
	tstrlistMainPackageIDs.LoadFromFile(ScriptsPath + 'FyTy\Follower Framework\PackageFormIDs.txt');
	
	strFar := 'wFar';
	strMed := 'wMed';
	strShort := 'wShort';
	
end;


procedure CopyFromPackage(e: IInterface; iDist: integer);
var
	ePKCU, ePackData, eXNAM: IInterface;
	ePackageFar, ePackageMed, ePackageShort: IInterface;
begin
	
	ePackageFar := RecordByFormID(MyFile, StrToInt(tstrlistMainPackageIDs[0]), true);
	ePackageMed := RecordByFormID(MyFile, StrToInt(tstrlistMainPackageIDs[1]), true);
	ePackageShort := RecordByFormID(MyFile, StrToInt(tstrlistMainPackageIDs[2]), true);
	
	
	if iDist = 0 then begin
		ePKCU := ElementBySignature(ePackageFar, 'PKCU');
		ePackData := ElementByPath(ePackageFar, 'Package Data');
		eXNAM := ElementBySignature(ePackageFar, 'XNAM');
		
		wbCopyElementToRecord(ePKCU, e, false, true);
		wbCopyElementToRecord(ePackData, e, false, true);
		wbCopyElementToRecord(eXNAM, e, false, true);
	end;
	
	if iDist = 1 then begin
		ePKCU := ElementBySignature(ePackageMed, 'PKCU');
		ePackData := ElementByPath(ePackageMed, 'Package Data');
		eXNAM := ElementBySignature(ePackageMed, 'XNAM');
		
		wbCopyElementToRecord(ePKCU, e, false, true);
		wbCopyElementToRecord(ePackData, e, false, true);
		wbCopyElementToRecord(eXNAM, e, false, true);
	end;
	
	if iDist = 2 then begin
		ePKCU := ElementBySignature(ePackageShort, 'PKCU');
		ePackData := ElementByPath(ePackageShort, 'Package Data');
		eXNAM := ElementBySignature(ePackageShort, 'XNAM');
		
		wbCopyElementToRecord(ePKCU, e, false, true);
		wbCopyElementToRecord(ePackData, e, false, true);
		wbCopyElementToRecord(eXNAM, e, false, true);
	end;
	
	
end;

function Process(e: IInterface): integer;
var
	strEDID: string;
begin
	
	if Signature(e) <> 'PACK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	MyFile := GetFile(e);
	
	strEDID := GetElementEditValues(e, 'EDID');
	
	if Pos(strFar, StrEDID) > 0 then
		CopyFromPackage(e, 0)
	else if Pos(strMed, StrEDID) > 0 then
		CopyFromPackage(e, 1)
	else if Pos(strShort, StrEDID) > 0 then
		CopyFromPackage(e, 2)
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.