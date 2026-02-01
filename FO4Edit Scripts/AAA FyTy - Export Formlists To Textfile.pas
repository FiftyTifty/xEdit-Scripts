unit userscript;
var
	tstrlistFallout4, tstrlistDLCRobot, tstrlistDLCWorkshop01, tstrlistDLCCoast,
	tstrlistDLCWorkshop02, tstrlistDLCWorkshop03, tstrlistDLCNukaWorld: TStringList;
	strSavePath, strFallout4, strDLCRobot, strDLCWorkshop01, strDLCCoast,
	strDLCWorkshop02, strDLCWorkshop03, strDLCNukaWorld: string;

function Initialize: integer;
begin

	strSavePath := ProgramPath + 'Edit Scripts\FyTy\Transfer Settlement Blueprints\';
	
  tstrlistFallout4 := TStringList.Create;
	tstrlistDLCRobot := TStringList.Create;
	tstrlistDLCWorkshop01 := TStringList.Create;
	tstrlistDLCCoast := TStringList.Create;
	tstrlistDLCWorkshop02 := TStringList.Create;
	tstrlistDLCWorkshop03 := TStringList.Create;
	tstrlistDLCNukaWorld := TStringList.Create;
	
	strFallout4 := 'Fallout4.esm';
	strDLCRobot := 'DLCRobot.esm';
	strDLCWorkshop01 := 'DLCworkshop01.esm';
	strDLCCoast := 'DLCCoast.esm';
	strDLCWorkshop02 := 'DLCworkshop02.esm';
	strDLCWorkshop03 := 'DLCworkshop03.esm';
	strDLCNukaWorld := 'DLCNukaWorld.esm';
end;


function Process(e: IInterface): integer;
var
	eFormIDs, eItem: IInterface;
	strFile, strFormID: string;
	iCounter, iFormID: integer;
begin
	
	if Signature(e) <> 'FLST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eFormIDs := ElementByName(e, 'FormIDs');
	
	for iCounter := 0 to ElementCount(eFormIDs) - 1 do begin
		
		eItem := LinksTo(ElementByIndex(eFormIDs, iCounter));
		iFormID := FixedFormID(eItem);
		strFormID := IntToStr(iFormID);
		
		strFile := GetFileName(GetFile(eItem));
		
		if strFile = strFallout4 then
			tstrlistFallout4.Add(strFormID);
		
		if strFile = strDLCRobot then
			tstrlistDLCRobot.Add(strFormID);
		
		if strFile = strDLCWorkshop01 then
			tstrlistDLCWorkshop01.Add(strFormID);
		
		if strFile = strDLCWorkshop02 then
			tstrlistDLCWorkshop02.Add(strFormID);
		
		if strFile = strDLCWorkshop03 then
			tstrlistDLCWorkshop03.Add(strFormID);
		
		if strFile = strDLCNukaWorld then
			tstrlistDLCNukaWorld.Add(strFormID);
		
	end;
	
end;


function Finalize: integer;
begin
  
	tstrlistFallout4.SaveToFile(strSavePath + 'Items - Fallout4.txt');
	tstrlistDLCRobot.SaveToFile(strSavePath + 'Items - DLCRobot.txt');
	tstrlistDLCWorkshop01.SaveToFile(strSavePath + 'Items - DLCworkshop01.txt');
	tstrlistDLCWorkshop02.SaveToFile(strSavePath + 'Items - DLCworkshop02.txt');
	tstrlistDLCWorkshop03.SaveToFile(strSavePath + 'Items - DLCworkshop03.txt');
	tstrlistDLCNukaWorld.SaveToFile(strSavePath + 'Items - DLCNukaWorld.txt');
	
	tstrlistFallout4.Free();
	tstrlistDLCRobot.Free();
	tstrlistDLCWorkshop01.Free();
	tstrlistDLCWorkshop02.Free();
	tstrlistDLCWorkshop03.Free();
	tstrlistDLCNukaWorld.Free();
	
end;

end.