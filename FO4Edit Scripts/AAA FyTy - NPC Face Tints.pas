unit userscript;
uses 'AAA FyTy - Aux Functions';

const
	strIndexLipstickNoColor = '1339';

var
	tstrlistColorEyeshadowToLower, tstrlistColorEyeshadowToLipstick,
	tstrlistColorSkinToLipstick,
	tstrlistMakeupLayerData,
	tstrlistLayerNames, tstrlistLayerIDs, tstrlistColorIDs, tstrlistColorStrings: TStringList;
	tlistColorLayers: TList;

procedure RemoveMakeupLayers(e: IInterface);
var
	eLayer, eLayers, eTETI: IInterface;
	iCounter: Integer;
begin
	
	eLayers := ElementByPath(e, 'Face Tinting Layers');
	
	for iCounter := ElementCount(eLayers) - 1 downto 0 do begin
	
		eLayer := ElementByIndex(eLayers, iCounter);
		eTETI := ElementBypath(eLayer, 'TETI - Index');
		
		if GetElementEditValues(eTETI, 'Index') = '1168' then
			Continue;
			
		RemoveByIndex(eLayers, iCounter, true);
	
	end;
	
end;

function AddMakeupLayer(eLayers: IInterface; strType, strColorID, strStrength: string): IInterface;
var
	eLayer: IInterface;
begin

	//AddMessage('AddMakeupLayer!');
	
	eLayer := ElementAssign(eLayers, HighInteger, nil, False);
	
	SetElementEditValues(eLayer, 'TETI - Index\Data Type', 'Value/Color');
	SetElementEditValues(eLayer, 'TETI - Index\Index', strType);
	SetElementEditValues(eLayer, 'TEND - Data\Template Color Index', strColorID);
	SetElementEditValues(eLayer, 'TEND - Data\Value', strStrength);
	
	Result := eLayer;

end;

procedure SetupMakeupColorData;
var
	tstrlistSplit: TStringList;
	iCounter: Integer;
begin

	tlistColorLayers := TList.Create;
	
	for iCounter := 0 to tstrlistMakeupLayerData.Count - 1 do begin
	
		tstrlistSplit := TStringList.Create;
		tstrlistSplit.Delimiter := ',';
		tstrlistSplit.StrictDelimiter := True;
		tstrlistSplit.DelimitedText := tstrlistMakeupLayerData[iCounter];
		
		//Remove the face layer data
		tstrlistSplit.Delete(0); //Remove layer name
		tstrlistSplit.Delete(0); //Remove layer ID
		//Now we only have the colour layer data!
		
		tlistColorLayers.Add(tstrlistSplit);
	
	end;

end;

function GetMakeupLayerDataFromIndex(iTypeIndex: Integer; strIndex: string; var outID, outCLFM, outStrength, outIndex: string): Boolean;
var
	iCounter: Integer;
	tstrlistCurrent: TStringList;
	strLineIndex: string;
begin

	tstrlistCurrent := TStringList(tlistColorLayers[iTypeIndex]);
	//AddMessage('GetMakeupLayerDataFromIndex! - First line is: ' + tstrlistCurrent[0]);
	
	for iCounter := 0 to ( (tstrlistCurrent.Count - 1) div 4 ) do begin
	
		strLineIndex := tstrlistCurrent[(iCounter * 4) + 3];
		//AddMessage(strLineIndex);
	
		outID := tstrlistCurrent[(iCounter * 4)];
		outCLFM := tstrlistCurrent[(iCounter * 4) + 1];
		outStrength := tstrlistCurrent[(iCounter * 4) + 2];
		outIndex := tstrlistCurrent[(iCounter * 4) + 3];
		
		if outIndex = strIndex then begin
		
			//AddMessage('Source Index: ' + strIndex + ' - Color layer ID is: ' + outID);
			exit;
			
		end;

	end;

end;

function GetSkinLayer(e: IInterface): IInterface;
var
	eLayers, eCurrent: IInterface;
	iCounter: Integer;
begin

	eLayers := ElementByPath(e, 'Face Tinting Layers');
	
	for iCounter := 0 to ElementCount(eLayers) - 1 do begin
	
		eCurrent := ElementByIndex(eLayers, iCounter);
		
		if GetElementEditValues(eCurrent, 'TETI - Index\Index') = '1168' then begin
		
			Result := eCurrent;
			exit;
			
		end;
	
	end;

end;

procedure GetLipstickCombosFromSkinLayer(eLayer: IInterface; tstrlistDest: TStringList);
var
	tstrlistCurrent, tstrlistSplit: TStringList;
	iCounter, iIndexInList: Integer;
	strIndex, strIndexFound: string;
begin

	AddMessage('=GetLipstickCombosFromSkinLayer=');
	tstrlistSplit := TStringList.Create;
	tstrlistSplit.Delimiter := ',';
	tstrlistSplit.StrictDelimiter := True;
	
	tstrlistCurrent := TStringList(tlistColorLayers[19]);
	
	strIndex := GetElementEditValues(eLayer, 'TEND - Data\Template Color Index');
	
	for iCounter := 0 to ( (tstrlistCurrent.Count - 1) div 4 ) do begin
	
			if tstrlistCurrent[(iCounter * 4)] = strIndex then begin
			
				strIndexFound := 'Skin tone,' + tstrlistCurrent[(iCounter * 4) + 3];
				AddMessage('Found: ' + strIndexFound);
				break;
			
			end;
	
	end;
	
	//E.g: Skin tone,4
	iIndexInList := tstrlistColorSkinToLipstick.IndexOf(strIndexFound);
	
	//E.g: Lipstick,1,2,3,4,7,9,10,11,12,13,15,16,17,19,20,21,22
	tstrlistSplit.DelimitedText := tstrlistColorSkinToLipstick[iIndexInList + 1];
	
	AddMessage('tstrlistSplit is: ' + tstrlistSplit.DelimitedText);
	
	for iCounter := 1 to tstrlistSplit.Count - 1 do begin
	
		tstrlistDest.Add(tstrlistSplit[iCounter]);
	
	end;
	
	tstrlistSplit.Free;

end;

procedure RemoveInvalidLipstickCombosViaEyeshadow(eLayer: IInterface; tstrlistEyeshadow, tstrlistCombos: TStringList);
var
	tstrlistSplit: TStringList;
	iCounter, iIndexLayerType, iIndexInList: Integer;
	strLayerName, strIndexLayer, strIndexColor, strIndexFound, strCurrent,
	strColourEntryIndex: string;
begin

	AddMessage('=RemoveInvalidLipstickCombosViaEyeshadow!=');
	
	tstrlistSplit := TStringList.Create;
	tstrlistSplit.Delimiter := ',';
	tstrlistSplit.StrictDelimiter := True;
	
	strIndexLayer := GetElementEditValues(eLayer, 'TETI - Index\Index');
	strIndexColor := GetElementEditValues(eLayer, 'TEND - Data\Template Color Index');
	
	AddMessage('strIndexLayer = ' + strIndexLayer);
	iIndexLayerType := tstrlistLayerIDs.IndexOf(strIndexLayer);
	AddMessage('iIndexLayerType = ' + IntToStr(iIndexLayerType));	
	strLayerName := tstrlistLayerNames[iIndexLayerType];
	AddMessage('strLayerName = ' +strLayerName);
	
	for iCounter := 0 to ( (tstrlistEyeshadow.Count - 1) div 4 ) do begin
	
		AddMessage('tstrlistEyeshadow[(iCounter * 4)] = ' + tstrlistEyeshadow[(iCounter * 4)]);
	
		if tstrlistEyeshadow[(iCounter * 4)] = strIndexColor then begin
		
			strIndexFound := strLayerName + ',' + tstrlistEyeshadow[(iCounter * 4) + 3];
			break;
		
		end;
	
	end;
	
	AddMessage('strIndexFound = ' + strIndexFound);
	
	iIndexInList := tstrlistColorEyeshadowToLipstick.IndexOf(strIndexFound);
	
	AddMessage('iIndexInList = ' +IntToStr(iIndexInList));
	
	tstrlistSplit.DelimitedText := tstrlistColorEyeshadowToLipstick[iIndexInList + 1];
	AddMessage(tstrlistCombos.DelimitedText);
	
	for iCounter := (tstrlistCombos.Count - 1) downto 0 do begin
	
		strCurrent := tstrlistCombos[iCounter];
		
		if tstrlistSplit.IndexOf(strCurrent) = -1 then
			tstrlistCombos.Delete(iCounter);
	
	end;
	
	AddMessage(tstrlistCombos.DelimitedText);
	
	//todo
	
	tstrlistSplit.Free;

end;

function Initialize: integer;
var
	tcolTest: TColorLayer;
begin
	
	tstrlistColorEyeshadowToLower := TStringList.Create;
	tstrlistColorEyeshadowToLower.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\ColorsEyeshadow_To_LowerEyeshadow.txt');
	//Every third line after 1 is Eye Shadow. Example format:
	//Eye Shadow 1,1
	//Lower Eye Shadow 1,1,2,3,4,5,6,8,9,10,11,12 
	//Lower Eye Shadow 2,1,2,3,5,6,8,9,10,11
	
	tstrlistColorSkinToLipstick := TStringList.Create;
	tstrlistColorSkinToLipstick.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\ColorsSkin_To_Lipstick.txt');
	
	tstrlistColorEyeshadowToLipstick := TStringList.Create;
	tstrlistColorEyeshadowToLipstick.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\ColorsEyeshadow_To_Lipstick.txt');
	
	tstrlistMakeupLayerData := TStringList.Create;
	tstrlistMakeupLayerData.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\MakeupLayerData.txt');
	
	tstrlistLayerNames := TStringList.Create;
	tstrlistLayerNames.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\LayerNames.txt');
	
	tstrlistLayerIDs := TStringList.Create;
	tstrlistLayerIDs.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\LayerIds.txt');
	
	tstrlistColorIDs := TStringList.Create;
	tstrlistColorIDs.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\MakeupColorIDs.txt');
	
	tstrlistColorStrings := TStringList.Create;
	tstrlistColorStrings.LoadFromFile(ScriptsPath + 'FyTy\Hot Mama\MakeupColors.txt');
	
	SetupMakeupColorData();
	
end;

function AddEyeshadow(e, eLowerEyeshadow: IInterface; var iEyeshadowType, iLowerType: Integer): IInterface;
var
	iRandEyeshadow, iIndexEyeshadow, iIndexLayer: Integer;
	eLayers, eLayer: IInterface;
	strFromList, strType, strColorID, strCLFM, strStrength, strIndex: string;
	tstrlistSplit: TStringList;
begin
	
	AddMessage('AddEyeshadow!');
	tstrlistSplit := TStringList.Create;
	tstrlistSplit.Delimiter := ',';
	tstrlistSplit.StrictDelimiter := True;
	
	eLayers := ElementByPath(e, 'Face Tinting Layers');
	
	Randomize;
	iRandEyeshadow := Random(tstrlistColorEyeshadowToLower.Count div 3);
	//Multiplying by 0 is ok, since that returns 0, and list starts at 0!
	iIndexEyeshadow := iRandEyeshadow * 3;
	strFromList := tstrlistColorEyeshadowToLower[iIndexEyeshadow];
	
	//AddMessage(strFromList);
	
	Randomize;
	
	tstrlistSplit.DelimitedText := strFromList;
	strType := tstrlistSplit[0];
	iIndexLayer := tstrlistLayerNames.IndexOf(strType);
	//AddMessage(IntToStr(iIndexLayer));
	GetMakeupLayerDataFromIndex(iIndexLayer, tstrlistSplit[Random(tstrlistSplit.Count - 1) + 1], strColorID, strCLFM, strStrength, strIndex);
	Result := AddMakeupLayer(eLayers, tstrlistLayerIDs[iIndexLayer], strColorID, strStrength);
	
	tstrlistSplit.Clear;
	
	if strType = 'Eye Shadow 1' then
		iEyeShadowType := 1
	else if strType = 'Eye Shadow 2' then
		iEyeShadowType := 2
	else if strType = 'Eye Shadow 3' then
		iEyeShadowType := 3;
	
	//Do lower eye shadow
	Randomize;
	strFromList := tstrlistColorEyeshadowToLower[iIndexEyeshadow + (Random(2) + 1)];
	//AddMessage(strFromList);
	
	tstrlistSplit.DelimitedText := strFromList;
	
	if tstrlistSplit[1] = '' then
		exit;
	
	strType := tstrlistSplit[0];
	iIndexLayer := tstrlistLayerNames.IndexOf(strType);
	
	Randomize;
	GetMakeupLayerDataFromIndex(iIndexLayer, tstrlistSplit[Random(tstrlistSplit.Count - 1) + 1], strColorID, strCLFM, strStrength, strIndex);
	eLowerEyeshadow := AddMakeupLayer(eLayers, tstrlistLayerIDs[iIndexLayer], strColorID, strStrength);
	
	if strType = 'Lower Eye Shadow 1' then
		iLowerType := 1
	else if strType = 'Lower Eye Shadow 2' then
		iLowerType := 2;
	
	//todo!
	tstrlistSplit.Free;

end;

function AddEyeLiner(e: IInterface): IInterface;
var
	strCurrent, strColorID, strCLFM, strStrength, strTypeEyeliner,
	strIndex: string;
	iRandomUpper, iRandomLower, iIndexEyeliner: integer;
	eLayer, eLayers: IInterface;
begin

	AddMessage('AddEyeLiner!');
	//Starting Eyeliner 1 is tstrlistMakeupLayerData[6] so add +7, and we have 6 combinations so Random(6)
	Randomize;
	iRandomUpper := Random(6) + 6;
	Randomize;
	iRandomLower := Random(2);
	
	eLayers := ElementByPath(e, 'Face Tinting Layers');
	
	strTypeEyeliner := tstrlistLayerNames[iRandomUpper];
	//AddMessage(strTypeEyeliner);
	iIndexEyeliner := tstrlistLayerNames.IndexOf(strTypeEyeliner);
	//AddMessage(IntToStr(iIndexEyeliner));
	
	//'1309' = black
	GetMakeupLayerDataFromIndex(iIndexEyeliner, '1', strColorID, strCLFM, strStrength, strIndex);
	//AddMessage('Got makeup data!');
	
	eLayer := AddMakeupLayer(eLayers, tstrlistLayerIDs[iIndexEyeliner], strColorID, strStrength);
	
	//Do lower eyeliner
	
	if iRandomLower = 0 then
		iIndexEyeliner := tstrlistLayerNames.IndexOf('Eye Liner Waterline')
	else
		iIndexEyeliner := tstrlistLayerNames.IndexOf('Eye Liner Lower 1');
		
	GetMakeupLayerDataFromIndex(iIndexEyeliner, '1', strColorID, strCLFM, strStrength, strIndex);
	
	eLayer := AddMakeupLayer(eLayers, tstrlistLayerIDs[iIndexEyeliner], strColorID, strStrength);
		

end;

function AddLipstick(e, eSkin, eEyeshadow, eEyeshadowLower: IInterface; iEyeshadowType, iLowerType: Integer): IInterface;
var
	tstrlistDataSkin, tstrlistDataEyeshadow, tstrlistDataLipstick,
	tstrlistLipstickDest, tstrlistSplit: TStringList;
	strColorID, strCLFM, strStrength, strIndex: string;
	iCounter, iIndexLayer: Integer;
begin

	tstrlistDataSkin := TStringList.Create;
	tstrlistDataEyeshadow := TStringList.Create;
	tstrlistDataLipstick := TStringList.Create;
	tstrlistLipstickDest := TStringList.Create;
	
	tstrlistSplit := TStringList.Create;
	tstrlistSplit.Delimiter := ',';
	tstrlistSplit.StrictDelimiter := True;
	
	iIndexLayer := tstrlistLayerNames.IndexOf('Lipstick');
	
	tstrlistDataSkin.AddStrings(TStringList(tlistColorLayers[19]));
	
	if iEyeshadowType = 1 then
		tstrlistDataEyeshadow.AddStrings(TStringList(tlistColorLayers[14]))
	else if iEyeshadowType = 2 then
		tstrlistDataEyeshadow.AddStrings(TStringList(tlistColorLayers[15]))
	else if iEyeshadowType = 3 then
		tstrlistDataEyeshadow.AddStrings(TStringList(tlistColorLayers[16]));
		
	AddMessage('tstrlistDataEyeShadow.Count = ' +IntToStr(tstrlistDataEyeshadow.Count));
		
	//todo: Lower eyeshadow data
	
	GetLipstickCombosFromSkinLayer(eSkin, tstrlistLipstickDest);
	AddMessage('tstrlistLipstickDest = ' + tstrlistLipstickDest.DelimitedText);
	RemoveInvalidLipstickCombosViaEyeshadow(eEyeshadow, tstrlistDataEyeshadow, tstrlistLipstickDest);
	AddMessage('tstrlistLipstickDest = ' + tstrlistLipstickDest.DelimitedText);
	
	tstrlistSplit.DelimitedText := tstrlistLipstickDest.DelimitedText;
	
	Randomize;
	
	GetMakeupLayerDataFromIndex(iIndexLayer, tstrlistSplit[Random(tstrlistSplit.Count - 1)], strColorID, strCLFM, strStrength, strIndex);
	Result := AddMakeupLayer(ElementByPath(e, 'Face Tinting Layers'), tstrlistLayerIDs[iIndexLayer], strColorID, strStrength);
	
	//todo
	//Result := eLayer;
	
	tstrlistDataSkin.Free;
	tstrlistDataEyeshadow.Free;
	tstrlistDataLipstick.Free;
	tstrlistLipstickDest.Free;
	tstrlistSplit.Free;

end;

function Process(e: IInterface): integer;
var
	eEyeshadow, eLowerEyeshadow, eEyeliner, eLipstick, eSkin: IInterface;
	iEyeshadowType, iLowerEyeshadowType: Integer;
begin
  
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	RemoveMakeupLayers(e);
	
	eSkin := GetSkinLayer(e);
	
	eEyeshadow := AddEyeshadow(e, eLowerEyeshadow, iEyeshadowType, iLowerEyeshadowType);
	eEyeliner := AddEyeLiner(e);
	eLipstick := AddLipstick(e, eSkin, eEyeshadow, eLowerEyeshadow, iEyeshadowType, iLowerEyeshadowType);
	
end;


function Finalize: integer;
begin
	
	tstrlistColorEyeshadowToLower.Free;
	tstrlistMakeupLayerData.Free;
	
	tstrlistLayerNames.Free;
	tstrlistLayerIDs.Free;
	tlistColorLayers.Free;
	
	tstrlistColorIDs.Free;
	tstrlistColorStrings.Free;
	
	tstrlistColorSkinToLipstick.Free;
	tstrlistColorEyeshadowToLipstick.Free;
	
end;

end.