unit userscript;
uses 'AAA FyTy - Aux Functions';

const strPathPresets = ScriptsPath + 'FyTy\Hot Mama\F4EE\';

var
	tstrlistHeadPartsToClean: TStringList;

function Initialize: integer;
begin
  
	tstrlistHeadPartsToClean := TStringList.Create;
	
	tstrlistHeadPartsToClean.Add('HeadHumanRearTEMP');
	tstrlistHeadPartsToClean.Add('HairFemale');
	tstrlistHeadPartsToClean.Add('HairMale');
	tstrlistHeadPartsToClean.Add('HeadHuman');
	tstrlistHeadPartsToClean.Add('MouthHumanoidDefault');
	tstrlistHeadPartsToClean.Add('EyesHuman');
	tstrlistHeadPartsToClean.Add('NeckGore');

end;

procedure CleanHeadPartsBeforeImport(e: IInterface);
var
	eHeadParts: IInterface;
	iCounter, iCounterList: Integer;
	strCurrent, strEntry: string;
begin

	eHeadParts := ElementByPath(e, 'Head Parts');
	
	for iCounter := ElementCount(eHeadParts) - 1 downto 0 do begin
	
		strCurrent := GetEditValue(ElementByIndex(eHeadParts, iCounter));
	
		for iCounterList := 0 to tstrlistHeadPartsToClean.Count - 1 do begin
		
			strEntry := tstrlistHeadPartsToClean[iCounterList];
		
			if (pos(strEntry, strCurrent) > 0) then
				if ((pos('AO', strCurrent) = 0) and (pos('Wet', strCurrent) = 0) and (pos('Lashes', strCurrent) = 0)) = true then begin
			
					RemoveByIndex(eHeadParts, iCounter, true);
					break;
					
				end;
		
		end;
	
	end;

end;

procedure SetHairColor(e: IInterface; strHairColor: string);
var
	iHairFormID, iFileIndex: integer;
	strMasterFile: string;
	eHair: IInterface;
begin

	iHairFormID := StrToInt('$' + RightStr(strHairColor, 6));
	
	strMasterFile := strHairColor;
	//We want to delete the separator, and the 6 formID characters!
	Delete(strMasterFile, pos('|', strHairColor), 7);
	
	eHair := RecordByFormID(GetFileByName(strMasterFile, iFileIndex), iHairFormID, true);
	
	SetElementEditValues(e, 'HCLF', GetElementEditValues(eHair, 'Record Header\FormID'));
	
end;

procedure SetHeadParts(e: IInterface; tjaHeadParts: TJsonArray);
var
	iCounter: integer;
	iFormID, iFileIndex: integer;
	strMasterFile, strHeadPart, strFormID: string;
	eHeadPart, eFile: IInterface;
begin

	//AddMessage('SetHeadParts! Count: ' + IntToStr(tjaHeadParts.Count));
	
	for iCounter := 0 to tjaHeadParts.Count - 1 do begin
	
		AddMessage(tjaHeadParts.S[iCounter]);
		
		strMasterFile := tjaHeadParts.S[iCounter];
		Delete(strMasterFile, pos('|', strMasterFile), 7);
		
		eFile := GetFileByName(strMasterFile, iFileIndex);
		
		if strMasterFile <> 'Fallout4.esm' then
			iFileIndex := iFileIndex - 1;
		
		AddMessage(GetFileName(eFile));
		AddMessage(IntToStr(iFileIndex));
		
		strFormID := RightStr(tjaHeadParts.S[iCounter], 6);
		strFormID := '$' + Format('%.*d', [2, iFileIndex]) + strFormID;
		
		AddMessage(strFormID);
		iFormID := StrToInt(strFormID);
		
		eHeadPart := RecordByFormID(eFile, iFormID, false);
		strHeadPart := GetElementEditValues(eHeadPart, 'Record Header\FormID');
		
		AddMessage(strHeadPart);
		
		eHeadPart := ElementAssign(ElementByPath(e, 'Head Parts'), HighInteger, nil, false);
		SetEditValue(eHeadPart, strHeadPart);
	
	end;

end;

procedure SetMorphKeysValues(e: IInterface; tjaMorphKeyValue: TJsonObject);
var
	eMorphKeys, eMorphValues, eKey, eValue: IInterface;
	iCounter: Integer;
begin

	eMorphKeys := ElementByPath(e, 'MSDK - Morph Keys');
	eMorphValues := ElementByPath(e, 'MSDV - Morph Values');
	
	for iCounter := 0 to tjaMorphKeyValue.Count - 1 do begin
	
		eKey := ElementByIndex(eMorphKeys, iCounter);
		eValue := ElementByIndex(eMorphValues, iCounter);
		
		//AddMessage(tjaMorphKeyValue.Names[iCounter]);
		//AddMessage(tjaMorphKeyValue.S[tjaMorphKeyValue.Names[iCounter]]);
		
		SetEditValue(eKey, tjaMorphKeyValue.Names[iCounter]);
		SetEditValue(eValue, tjaMorphKeyValue.S[tjaMorphKeyValue.Names[iCounter]]);
	
	end;
	
end;

procedure SetFaceMorphs(e: IInterface; tjoFaceMorphs: TJsonObject);
var
	eMorphs, eMorph, eValues: IInterface;
	tjaMorphValues: TJsonObject;
	strMorphIndex: string;
	fValue: Double;
	iCounterRegion, iCounterValue: integer;
begin
	
	RemoveElement(e, 'Face Morphs');
	eValues := Add(eMorph, 'FMRS - Values', false);
	
	AddMessage('Number of morph entries: ' + IntToStr(tjoFaceMorphs.Count));
	AddMessage(tjoFaceMorphs.Names[tjoFaceMorphs.Count - 1]);

	for iCounterRegion := 0 to tjoFaceMorphs.Count - 1 do begin
	
		if ElementExists(e, 'Face Morphs') = false then begin
		
			eMorphs := Add(e, 'Face Morphs', false);
			eMorph := ElementByIndex(eMorphs, 0);
		
		end
		else begin
		
			eMorph := ElementAssign(eMorphs, HighInteger, nil, false);
			eValues := Add(eMorph, 'FMRS - Values', false);
			
		end;
		
		strMorphIndex := tjoFaceMorphs.Names[iCounterRegion];
		
		SetElementEditValues(eMorph, 'FMRI - Index', tjoFaceMorphs.Names[iCounterRegion]);
		
		//tjaMorphValues := tjoFaceMorphs.S[iCounterRegion];
		for iCounterValue := 0 to tjoFaceMorphs.A[strMorphIndex].Count - 2 do begin
		
			fValue := tjoFaceMorphs.A[strMorphIndex].F[iCounterValue];
			
			SetEditValue(ElementByIndex(eValues, iCounterValue), FloatToStr(fValue));
		
		end;
	
	end;

end;

function ImportLooksmenuValues(e: IInterface; strPath: string): Boolean;
var
	iCounter: integer;
	tstrlistJSON: TStringList;
	tjobjPreset: TJsonObject;
begin
	
	CleanHeadPartsBeforeImport(e);
	
	tstrlistJSON := TStringList.Create;
	tstrlistJSON.LoadFromFile(strPath);
	
	//tjobjPreset := TJsonArray.Create;
	//tjobjPreset.LoadFromFile(strPath);
	tjobjPreset := TJsonObject.Parse(tstrlistJSON.Text);
	AddMessage('Number of elements in tjobjPreset: ' + IntToStr(tjobjPreset.Count));
	
	SetHairColor(e, tjobjPreset.S['HairColor']);
	SetHeadParts(e, tjobjPreset.A['HeadParts']);
	//AddMessage(IntToStr(tjobjPreset.O['Morphs'].O['Presets'].Count));
	SetMorphKeysValues(e, tjobjPreset.O['Morphs'].O['Presets']);
	SetFaceMorphs(e, tjobjPreset.O['Morphs'].O['Regions']);
	//todo
	
	//end
	tstrlistJSON.Free;

end;

function Process(e: IInterface): integer;
var
	strEDID: string;
begin
	
  if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strEDID := GetElementEditValues(e, 'EDID');
	
	//AddMessage('Headpart: ' +GetEditValue(ElementByIndex(ElementByPath(e, 'Head Parts'), 0)));
	
	if FileExists(strPathPresets + strEDID + '.json') then
		ImportLooksmenuValues(e, strPathPresets + strEDID + '.json');
	
end;


function Finalize: integer;
begin
  
	tstrlistHeadPartsToClean.Free;
	
end;

end.