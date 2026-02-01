unit userscript;
var
	eFile: IInterface;
	tstrMovableStatics, tstrMiscItems: TStringList;


function Initialize: integer;
begin
	
	eFile := FileByIndex($11 + 1);
	AddMessage(GetFileName(eFile));
	
  tstrMovableStatics := TStringList.Create;
	tstrMiscItems := TStringList.Create;
	tstrMovableStatics.LoadFromFile(ScriptsPath + 'FyTy\Movable Statics To Items\Item_FormIDs_Source.txt');
	tstrMiscItems.LoadFromFile(ScriptsPath + 'FyTy\Movable Statics To Items\Item_FormIDs_Dest.txt');
	
	AddMessage(ScriptsPath);
end;


function Process(e: IInterface): integer;
var
	strFullFormID, strNewFullFormID: string;
	iIndex: integer;
	eNew, eOrig: IInterface;
begin
	
	if Signature(e) <> 'REFR' then
		exit;
	
  //AddMessage('=References To Misc Items = Processing: ' + FullPath(e));
	
	eOrig := MasterOrSelf(e);
	
	if OverrideCount(eOrig) > 0 then
		eOrig := OverrideByIndex(eOrig, OverrideCount(eOrig) - 1);
		
	strFullFormID := GetElementEditValues(eOrig, 'NAME');
	
	try
		if (tstrMovableStatics.IndexOf(strFullFormID) >= 0) then begin
		
			iIndex := tstrMovableStatics.IndexOf(strFullFormID);
			eNew := wbCopyElementToFile(eOrig, eFile, false, true);
			strNewFullFormID := tstrMiscItems[iIndex];
			//AddMessage('Processing: ' + strFullFormID);
			//AddMessage('New Full FormID is: ' + strNewFullFormID);
			SetElementEditValues(eNew, 'NAME', strNewFullFormID);
			
		end;
	except
	
		AddMessage(strFullFormID);
		AddMessage(strNewFullFormID);
		
	end;
	
end;


function Finalize: integer;
begin
	tstrMovableStatics.Free;
	tstrMiscItems.Free;
end;

end.