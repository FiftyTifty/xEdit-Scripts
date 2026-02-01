unit userscript;
uses 'AAA FyTy - Aux Functions';
var
	eFile: IInterface;
	tstrlistValidMods: TStringList;

function Initialize: integer;
var
	iIndex: Integer;
begin
  
	eFile := GetFileByName('FyTy - Damage Overhaul.esp', iIndex);
	
	AddMessage(GetFileName(eFile));
	
	tstrlistValidMods := TStringList.Create;
	tstrlistValidMods.Add('_Barrel_');
	tstrlistValidMods.Add('_Receiver_');
	tstrlistValidMods.Add('_Muzzle');
	
end;

function IsValidOMOD(eOMOD: IInterface): Boolean;
var
	iCounter: Integer;
begin

	Result := false;
	
	for iCounter := 0 to tstrlistValidMods.Count - 1 do begin
	
		if pos(tstrlistValidMods[iCounter], GetElementEditValues(eOMOD, 'EDID')) > 0 then begin
		
			//AddMessage(GetElementEditValues(eOMOD, 'EDID'));
			Result := True;
			exit;
			
		end;
	
	end;

end;

procedure AddOMODsToPlugin(e: IInterface);
var
	eCombinations, eIncludes, eOMOD: IInterface;
	iCounter, iCounterIncludes: Integer;
	bRecordInMyFile: Boolean;
begin

	eCombinations := ElementByPath(e, 'Object Template\Combinations');
	
	for iCounter := 0 to ElementCount(eCombinations) - 1 do begin
	
		eIncludes := ElementByPath(ElementByIndex(eCombinations, iCounter), 'OBTS - Object Mod Template Item\Includes');
		//AddMessage(IntToStr(ElementCount(eIncludes)));
		
		for iCounterIncludes := 0 to ElementCount(eIncludes) - 1 do begin
		
			eOMOD := LinksTo(ElementByPath(ElementByIndex(eIncludes, iCounterIncludes), 'Mod'));
			
			//AddMessage(FullPath(eOMOD));
			//AddMessage(GetFileName(GetFile(RecordByFormID(eFile, FixedFormID(eOMOD), false))));
			
			bRecordInMyFile := GetFileName(GetFile(RecordByFormID(eFile, FixedFormID(eOMOD), false))) = GetFileName(eFile);				
			
			if (bRecordInMyFile = false) and (IsValidOMOD(eOMOD)) then begin
				AddMessage('Record does not exist!');
				wbCopyElementToFile(eOMOD, eFile, false, true);
			end;
		
		end;
	
	end;

end;

function Process(e: IInterface): integer;
begin
	
  if Signature(e) <> 'WEAP' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	AddOMODsToPlugin(e);  
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.