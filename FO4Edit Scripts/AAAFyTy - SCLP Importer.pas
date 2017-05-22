unit userscript;
//In a .sclp data, the scaling values are normalized at 1.0
//But in an armor addon, they are normalized at 0.0.
//Easy solution: Subtract 1.0 from the .sclp data when importing the data!

type
	recBone = record
		strBoneName: string;
		fScaleX, fScaleY, fScaleZ: single;
	end;

type
	arrayRecBone = array of recBone;

Const
	strFindBoneName := '    "Name": "';
	strFindBoneScaleX := '      "x": ';
	strFindBoneScaleY := '      "y": ';
	strFindBoneScaleZ := '      "z": ';


function Initialize: integer;
begin
  Result := 0;
end;


function GetOutfitFileFullName(strOutfitName: string): string;
begin
	strOutfitName := DataPath + 'Meshes\' + strOutfitName;
	Result := strOutfitName;
end;

procedure GetFileNamesAndPaths(e: IInterface; bIsFemale: boolean;
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


function GetDataFromSCLP(tstrlistSCLP: TStringList): arrayRecBone;
var
	iCounter, iNumBones, iLength: integer;
	arrayBones: arrayRecBone;
	strName, strScaleX, strScaleY, strScaleZ: string;
begin
	
	for iCounter := 0 to tstrlistSCLP.Count - 1 do begin
	
		if Pos(strFindBoneName, tstrlistSCLP[iCounter]) > 0 then begin
		
			Inc(iNumBones);
			SetLength(arrayBones, iNumBones);
			
			iLength := ( Length(tstrlistSCLP[iCounter]) - Length(strFindBoneName) ) - 2; //So we don't get '",'
			strName := Copy(tstrlistSCLP[iCounter], Length(strFindBoneName), iLength);
			
			iLength := ( Length(tstrlistSCLP[iCounter + 2]) - Length(strFindBoneScaleX) ) - 1; // X
			strScaleX := Copy(tstrlistSCLP[iCounter + 2], Length(strFindBoneScaleX), iLength);
			
			iLength := ( Length(tstrlistSCLP[iCounter + 2]) - Length(strFindBoneScaleY) ) - 1; // Y
			strScaleY := Copy(tstrlistSCLP[iCounter + 2], Length(strFindBoneScaleX), iLength);
			
			iLength := ( Length(tstrlistSCLP[iCounter + 2]) - Length(strFindBoneScale|) ) - 1; // Z
			strScaleZ := Copy(tstrlistSCLP[iCounter + 2], Length(strFindBoneScaleX), iLength);
			
			arrayBones[iNumBones - 1].strBoneName := strName;
			arrayBones[iNumBones - 1].fScaleX := StrToFloat(strScaleX) - 1.0; //ARMA bone data is normalized at 0.0, SCLP bone data @ 1.0
			arrayBones[iNumBones - 1].fScaleY := StrToFloat(strScaleY) - 1.0;
			arrayBones[iNumBones - 1].fScale| := StrToFloat(strScaleZ) - 1.0;
			
		end;
		
	end;
	
	Result := arrayBones;
	
end;

procedure AddBoneData(e: IInterface;
											var strSCLPFullFilePathF, strSCLPFullFilePathM: string);
var
	tstrlistSCLPM, tstrlistSCLPF: TStringList;
	arrayBonesM, arrayBonesF: arrayRecBone;
	eBoneDataM, eBoneDataF, eAddedBone: IInterface;
	iCounter: integer;
begin
	
	tstrlistSCLPM := TStringList.Create;
	tstrlistSCLPF := TStringList.Create;
	
	tstrlistSCLPM.LoadFromFile(strSCLPFullFilePathM);
	tstrlistSCLPF.LoadFromFile(strSCLPFullFilePathF);
	
	arrayBonesM := GetDataFromSCLP(tstrlistSCLPM);
	arrayBonesF := GetDataFromSCLP(tstrlistSCLPF);
	
	eBoneDataM := Add(e, 'Bone Data', false);
	eBoneDataM := ElementByPath(eBoneDataM, 'Bones');
	
	eBoneDataF := Add(e, 'Bone Data', false);
	SetElementEditValues(eBoneDataF, 'BSMP - Gender', 'Female');
	eBoneDataF := ElementByPath(eBoneDataF, 'Bones');
	
	for iCounter := 0 to Length(arrayBonesM) - 1 do begin
		eAddedBone := ElementAssign(eBoneDataM, HighInteger, nil, false);
		SetElementEditValues(eAddedBone, 'BSMS - Name', arrayBonesM[iCounter].strBoneName);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #0', arrayBonesM[iCounter].fScaleX);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #1', arrayBonesM[iCounter].fScaleY);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #2', arrayBonesM[iCounter].fScaleZ);
	end;
	
	for iCounter := 0 to Length(arrayBonesF) - 1 do begin
		eAddedBone := ElementAssign(eBoneDataF, HighInteger, nil, false);
		SetElementEditValues(eAddedBone, 'BSMS - Name', arrayBonesF[iCounter].strBoneName);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #0', arrayBonesF[iCounter].fScaleX);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #1', arrayBonesF[iCounter].fScaleY);
		SetElementEditValues(eAddedBone, 'BSMB - Values\Value #2', arrayBonesF[iCounter].fScaleZ);
	end;
	
	
end;


function Process(e: IInterface): integer;
var
	strOutfitPathM, strOutfitNameM, strOutfitPathF, strOutfitNameF,
	strOutfitDir, strSCLPFileM, strSCLPFileF: string;
begin

	if Signature(e) <> 'ARMA' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'Bone Data') then
		RemoveElement(e, ElementByPath(e, 'Bone Data'));
	
	
	//Get the outfit mesh names, and the outfit folders
	GetFileNamesAndPaths(e, false, strOutfitPathM, strOutfitNameM);
	GetFileNamesAndPaths(e, false, strOutfitPathF, strOutfitNameF);
	//End
	
	//Get the .sclp files
	strSCLPFileM := strOutfitPathM + strOutfitNameM + 'sclp';
	strSCLPFileF := strOutfitPathF + strOutfitNameF + 'sclp';
	//End
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.