unit userscript;
//In a .sclp data, the scaling values are normalized at 1.0
//But in an armor addon, they are normalized at 0.0.
//Easy solution: Subtract 1.0 from the .sclp data when importing the data!

Const
	strFindBoneName = '    "Name": "';
	strFindBoneScaleX = '      "x": ';
	strFindBoneScaleY = '      "y": ';
	strFindBoneScaleZ = '      "z": ';


function Initialize: integer;
begin
  Result := 0;
end;


function GetOutfitFileFullName(strOutfitName: string): string;
begin
	strOutfitName := DataPath + 'Meshes\' + strOutfitName;
	Result := strOutfitName;
end;

procedure GetOutfitFileNamesAndPaths(e: IInterface; bIsFemale: boolean;
															 var strOutfitPath, strOutfitName: string);
var
	strEOutfit: string;
begin

	if not bIsFemale then begin
		
		strEOutfit := GetElementEditValues(e, 'Male world model\MOD2 - Model Filename');
		strOutfitPath := GetOutfitFileFullName(strEOutfit);
		
		strOutfitName := ExtractFileName(strOutfitPath);
		strOutfitName := Copy(strOutfitName, 1, Length(strOutfitName) - 3);
		strOutfitPath := ExtractFilePath(strOutfitPath);
		
	end;
	
	if bIsFemale then begin
		
		strEOutfit := GetElementEditValues(e, 'Female world model\MOD3 - Model Filename');
		strOutfitPath := GetOutfitFileFullName(strEOutfit);
		
		strOutfitName := ExtractFileName(strOutfitPath);
		strOutfitName := Copy(strOutfitName, 1, Length(strOutfitName) - 3);
		strOutfitPath := ExtractFilePath(strOutfitPath);
		
	end;
	
end;


procedure GetDataFromSCLP(tstrlistSCLP: TStringList; var iNumBones: integer; var tstrlistDest: TStringList);
var
	iCounter, iLength: integer;
	tstrlistBones: TStringList;
	strName, strScaleX, strScaleY, strScaleZ: string;
begin
	
	tstrlistBones := TStringList.Create;
	
	iNumBones := 0;
	
	iCounter := tstrlistSCLP.Count - 1;
	
	while iCounter >= 0 do begin
	
		if Pos(strFindBoneName, tstrlistSCLP[iCounter]) = 1 then begin
			
			iLength := ( (Length(tstrlistSCLP[iCounter]) + 2) - Length(strFindBoneName) ) - 2; //So we don't get '",'
			strName := Copy(tstrlistSCLP[iCounter], Length(strFindBoneName) + 1, iLength - 2);
			ShowMessage(strName);
			
			iLength := ( Length(tstrlistSCLP[iCounter + 2]) - Length(strFindBoneScaleX) ) - 1; // X
			ShowMessage(tstrlistSCLP[iCounter + 2]);
			strScaleX := Copy(tstrlistSCLP[iCounter + 2], Length(strFindBoneScaleX), iLength);
			
			
			iLength := ( Length(tstrlistSCLP[iCounter + 3]) - Length(strFindBoneScaleY) ) - 1; // Y
			strScaleY := Copy(tstrlistSCLP[iCounter + 3], Length(strFindBoneScaleY), iLength);
			//ShowMessage(strScaleY);
			
			iLength := ( Length(tstrlistSCLP[iCounter + 4]) - Length(strFindBoneScaleZ) ); // Z
			strScaleZ := Copy(tstrlistSCLP[iCounter + 4], Length(strFindBoneScaleZ), iLength);
			//ShowMessage(strScaleZ);
			
			tstrlistBones.Add(strName);
			tstrlistBones.Add(FloatToStr(StrToFloat(strScaleX) - 1.0)); //ARMA bone data is normalized at 0.0, SCLP bone data @ 1.0
			tstrlistBones.Add(FloatToStr(StrToFloat(strScaleY) - 1.0));
			tstrlistBones.Add(FloatToStr(StrToFloat(strScaleZ) - 1.0));
			
			inc(iNumBones);
			iCounter := iCounter - 7;
			
		end;
		
		dec(iCounter);
		
	end;
	
	//ShowMessage('Number of bones: ' + IntToStr(iNumBones));
	
	tstrlistDest := tstrlistBones;
	
end;

procedure AddBoneData(e: IInterface;
											var strSCLPFullFilePathF, strSCLPFullFilePathM: string);
var
	tstrlistSCLPM, tstrlistSCLPF, tstrlistBonesM, tstrlistBonesF: TStringList;
	eBoneDataM, eBoneDataF, eAddedBone: IInterface;
	iCounter, iRealCounter, iNumBonesM, iNumBonesF: integer;
	bSkip, bFilledFirstBone: boolean;
begin
	
	tstrlistSCLPM := TStringList.Create;
	tstrlistSCLPF := TStringList.Create;
	tstrlistBonesM := TStringList.Create;
	tstrlistBonesF := TStringList.Create;
	
	
	tstrlistSCLPM.LoadFromFile(strSCLPFullFilePathM);
	tstrlistSCLPF.LoadFromFile(strSCLPFullFilePathF);
	
	tstrlistBonesM := GetDataFromSCLP(tstrlistSCLPM, iNumBonesM, tstrlistBonesM);
	tstrlistBonesF := GetDataFromSCLP(tstrlistSCLPF, iNumBonesF, tstrlistBonesF);
	
	eBoneDataM := Add(e, 'Bone Data', false);
	//ShowMessage('Bone Data Path: '+FullPath(eBoneDataM));
	eBoneDataM := ElementByIndex(eBoneDataM, 0);
	//ShowMessage('Data Path: '+FullPath(eBoneDataM));
	eBoneDataM := ElementAssign(eBoneDataM, 1, nil, false);
	//ShowMessage('Bones Path: '+FullPath(eBoneDataM));
	
	eBoneDataF := ElementAssign(ElementByPath(e, 'Bone Data'), HighInteger, nil, false);
	SetElementEditValues(eBoneDataF, 'BSMP - Gender', 'Female');
	eBoneDataF := ElementAssign(eBoneDataF, 1, nil, false);
	
	
	iCounter := iNumBonesM - 1;
	iRealCounter := 0;
	while iCounter >= 0 do begin
		
		if tstrlistBonesM[iRealCounter + 1] = '0.0000' then
			if tstrlistBonesM[iRealCounter + 2] = '0.0000' then
				if tstrlistBonesM[iRealCounter + 3] = '0.0000' then
					bSkip := true;
		
		if not bSkip then begin
		
			if bFilledFirstBone = false then
				eAddedBone := ElementByIndex(eBoneDataM, 0)
			else
				eAddedBone := ElementAssign(eBoneDataM, HighInteger, nil, false);
			
			bFilledFirstBone := true;
			
			ShowMessage('Added Bone Path: ' + FullPath(eAddedBone));
			
			ElementAssign(eAddedBone, 1, nil, false); // Add BSMS element
			ShowMessage('Path: ' + FullPath(eAddedBone));
			ElementAssign(ElementByPath(eAddedBone, 'BSMS - Values'), HighInteger, nil, false); // Add X
			ElementAssign(ElementByPath(eAddedBone, 'BSMS - Values'), HighInteger, nil, false); // Add Y
			ElementAssign(ElementByPath(eAddedBone, 'BSMS - Values'), HighInteger, nil, false); // Add Z
			
			//ShowMessage('Adding Male bone: ' + tstrlistBonesM[iRealCounter]);
			SetElementEditValues(eAddedBone, 'BSMB - Name', tstrlistBonesM[iRealCounter]);
			
			//ShowMessage('Scale X: ' + tstrlistBonesM[iRealCounter + 1]);
			SetElementEditValues(eAddedBone, 'BSMS - Values\Value #0', tstrlistBonesM[iRealCounter + 1]);
			
			//ShowMessage('Scale Y: ' + tstrlistBonesM[iRealCounter + 2]);
			SetElementEditValues(eAddedBone, 'BSMS - Values\Value #1', tstrlistBonesM[iRealCounter + 2]);
			
			//ShowMessage('Scale Z: ' + tstrlistBonesM[iRealCounter + 3]);
			SetElementEditValues(eAddedBone, 'BSMS - Values\Value #2', tstrlistBonesM[iRealCounter + 3]);
			
		end;
		
		
		iRealCounter := iRealCounter + 4;
		Dec(iCounter);
		
	end;
	
	bFilledFirstBone := false;
	
	
	{
	iCounter := iNumBonesF - 1;
	iRealCounter := 0;
	while iCounter >= 0 do begin
	
		if bFilledFirstBone = false then
			eAddedBone := ElementByIndex(eBoneDataF, 0)
		else
			eAddedBone := ElementAssign(eBoneDataF, HighInteger, nil, false);
		
		bFilledFirstBone := true;
		
		ShowMessage(FullPath(eAddedBone));
		
		ElementAssign(eAddedBone, 1, nil, false); // Add X
		ElementAssign(eAddedBone, 2, nil, false); // Add Y
		ElementAssign(eAddedBone, 3, nil, false); // Add Z
		
		//ShowMessage('Adding Female bone: 'tstrlistBonesF[iRealCounter]);
		SetElementEditValues(eAddedBone, 'BSMB - Name', tstrlistBonesF[iRealCounter]);
		
		//ShowMessage('Scale X: ' + tstrlistBonesF[iRealCounter + 1]);
		SetElementEditValues(eAddedBone, 'BSMS - Values\Value #0', tstrlistBonesF[iRealCounter + 1]);
		
		//ShowMessage('Scale Y: ' + tstrlistBonesF[iRealCounter + 2]);
		SetElementEditValues(eAddedBone, 'BSMS - Values\Value #1', tstrlistBonesF[iRealCounter + 2]);
		
		//ShowMessage('Scale Z: ' + tstrlistBonesF[iRealCounter + 3]);
		SetElementEditValues(eAddedBone, 'BSMS - Values\Value #2', tstrlistBonesF[iRealCounter + 3]);
		
		iRealCounter := iRealCounter + 4;
		Dec(iCounter);
		
	end;
	}
	
end;


function Process(e: IInterface): integer;
var
	strOutfitPathM, strOutfitNameM, strOutfitPathF, strOutfitNameF,
	strSCLPFileM, strSCLPFileF: string;
begin

	if Signature(e) <> 'ARMA' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'Bone Data') then
		RemoveElement(e, ElementByPath(e, 'Bone Data'));
	
	
	//Get the outfit mesh names, and the outfit folders
	GetOutfitFileNamesAndPaths(e, false, strOutfitPathM, strOutfitNameM);
	GetOutfitFileNamesAndPaths(e, true, strOutfitPathF, strOutfitNameF);
	//End
	
	//Get the .sclp files
	strSCLPFileM := strOutfitPathM + strOutfitNameM + 'sclp';
	strSCLPFileF := strOutfitPathF + strOutfitNameF + 'sclp';
	//End
	
	//Add bone data from .sclp files
	AddBoneData(e, strSCLPFileM, strSCLPFileF);
	//End
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.