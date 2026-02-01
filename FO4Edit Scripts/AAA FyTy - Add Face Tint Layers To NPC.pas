unit userscript;
var
	tstrlistColor, tstrlistColorIndexes, tstrlistLipLayers,
	tstrlistBlemishes, tstrlistBlemishesMandatory,
	tstrlistBrows, tstrlistDamage,
	tstrlistFacePaint, tstrlistFacePaintColors,
	tstrlistFaceTattoo,
	tstrlistMakeupBlush, tstrlistMakeupBlushColor, tstrlistMakeupBlushColorIndexes,
	tstrlistMakeupEyeLiner, tstrlistMakeupEyeLinerColor, tstrlistMakeupEyeLinerColorIndexes,
	tstrlistMakeupEyeShadow, tstrlistMakeupEyeShadowColor, tstrlistMakeupEyeShadowColorIndexes,
	tstrlistMakeupLipLiner, tstrlistMakeupLipLinerColor, tstrlistMakeupLipLinerColorIndexes,
	tstrlistMakeupLipstick, tstrlistMakeupLipstickColor, tstrlistMakeupLipstickColorIndexes,
	tstrlistMakeupLipDecals,
	tstrlistSkinTints, tstrlistSkinTintsColor, tstrlistSkinTintsColorIndexes,
	tstrlistMarkings: TStringList;
	
	bPreventBlemishes, bPreventDamage, bPreventFacePaint, bPreventTattoo, bPreventBlush, bPreventEyeLiner,
	bPreventEyeShadow, bPreventLipLiner, bPreventLipstick, bPreventMakeupLipDecals, bPreventSkinTints,
	bPreventMarkings, bPreventLipDecals, bPreventGrime: boolean;
	

function Initialize: integer;
begin
	
	Randomize;
	
	SetupLayerPreventionBooleans;
	SetupTheTStringLists;
	
end;

procedure SetupLayerPreventionBooleans;
begin
	
	bPreventBlemishes := false;
	bPreventDamage := false;
	bPreventFacePaint := true;
	bPreventTattoo := true;
	bPreventBlush := true;
	bPreventEyeLiner := true;
	bPreventEyeShadow := true;
	bPreventLipLiner := true;
	bPreventLipstick := true;
	bPreventMakeupLipDecals := true;
	bPreventSkinTints := true;
	bPreventMarkings := false;
	bPreventLipDecals := true;
	bPreventGrime := false;
	
end;

procedure SetupTheTStringLists;
begin
	tstrlistColor := TStringList.Create;
	tstrlistColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Blemishes\Lip Color - Color.txt');
	
	tstrlistColorIndexes := TStringList.Create;
	tstrlistColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Blemishes\Lip Color - Color Indexes.txt');
	
	tstrlistLipLayers := TStringList.Create;
	tstrlistLipLayers.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Blemishes\Lip Color - Tint Layer.txt');
	
	
	tstrlistBlemishes := TStringList.Create;
	tstrlistBlemishes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Blemishes.txt');
	
	tstrlistBlemishesMandatory := TStringList.Create;
	tstrlistBlemishesMandatory.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Blemishes - Mandatory.txt');
	
	
	tstrlistBrows := TStringList.Create;
	tstrlistBrows.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Brows.txt');
	
	
	tstrlistDamage := TStringList.Create;
	tstrlistDamage.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Damage.txt');
	
	
	tstrlistFacePaint := TStringList.Create;
	tstrlistFacePaint.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Face Paint\Face Paint - Full Layer IDs.txt');
	
	tstrlistFacePaintColors := TStringList.Create;
	tstrlistFacePaintColors.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Face Paint\All Face Paint - Colors.txt');
	
	
	tstrlistFaceTattoo := TStringList.Create;
	tstrlistFaceTattoo.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Face Tattoos.txt');
	
	
	tstrlistMakeupBlush := TStringList.Create;
	tstrlistMakeupBlush.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Blush.txt');
	
	tstrlistMakeupBlushColor := TStringList.Create;
	tstrlistMakeupBlushColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Blush - Color.txt');
	
	tstrlistMakeupBlushColorIndexes := TStringList.Create;
	tstrlistMakeupBlushColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Blush - Color Indexes.txt');
	
	
	tstrlistMakeupEyeLiner := TStringList.Create;
	tstrlistMakeupEyeLiner.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Liner.txt');
	
	tstrlistMakeupEyeLinerColor := TStringList.Create;
	tstrlistMakeupEyeLinerColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Liner - Color.txt');
	
	tstrlistMakeupEyeLinerColorIndexes := TStringList.Create;
	tstrlistMakeupEyeLinerColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Liner - Color Indexes.txt');
	
	
	tstrlistMakeupEyeShadow := TStringList.Create;
	tstrlistMakeupEyeShadow.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Shadow.txt');
	
	tstrlistMakeupEyeShadowColor := TStringList.Create;
	tstrlistMakeupEyeShadowColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Shadow - Color.txt');
	
	tstrlistMakeupEyeShadowColorIndexes := TStringList.Create;
	tstrlistMakeupEyeShadowColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Eye Shadow - Color Indexes.txt');
	
	
	tstrlistMakeupLipLiner := TStringList.Create;
	tstrlistMakeupLipLiner.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lip Liner.txt');
	
	tstrlistMakeupLipLinerColor := TStringList.Create;
	tstrlistMakeupLipLinerColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lip Liner - Color.txt');
	
	tstrlistMakeupLipLinerColorIndexes := TStringList.Create;
	tstrlistMakeupLipLinerColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lip Liner - Color Indexes.txt');
	
	
	tstrlistMakeupLipstick := TStringList.Create;
	tstrlistMakeupLipstick.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lipstick.txt');
	
	tstrlistMakeupLipstickColor := TStringList.Create;
	tstrlistMakeupLipstickColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lipstick - Color.txt');
	
	tstrlistMakeupLipstickColorIndexes := TStringList.Create;
	tstrlistMakeupLipstickColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\Makeup\Lipstick - Color Indexes.txt');
	
	
	tstrlistMakeupLipDecals := TStringList.Create;
	tstrlistMakeupLipDecals.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Makeup.txt');
	
	
	tstrlistSkinTints := TStringList.Create;
	tstrlistSkinTints.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\SkinTints\SkinTints.txt');
	
	tstrlistSkinTintsColor := TStringList.Create;
	tstrlistSkinTintsColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\SkinTints\Skin tone - Color.txt');
	
	tstrlistSkinTintsColorIndexes := TStringList.Create;
	tstrlistSkinTintsColorIndexes.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Colors\SkinTints\Skin tone - Color Indexes.txt');
	
	
	tstrlistMarkings := TStringList.Create;
	tstrlistMarkings.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Decals\Markings.txt');
	
end;

procedure GetRGBFromCLFM(strWithCLFMFormID: string; var outstrRed, outstrGreen, outstrBlue: string);
var
	fileFallout4, eRec: IInterface;
	strFormID: string;
	iFormID: integer;
	
	strRGBA, strTemp, strRed, strGreen, strBlue: string;
begin
	
	fileFallout4 := FileByIndex(0);
	
	strFormID := Copy(strWithCLFMFormID, Pos('CLFM:', strWithCLFMFormID) + 5, 8); // CLFM: has five characters, so we add that to what Pos returns
	//AddMessage(strFormID);
	iFormID := StrToInt('$'+strFormID); // By putting a $ in front of a string, that only has hex chars, we get painless str -> hex -> int conversions
	eRec := RecordByFormID(fileFallout4, iFormID, true);
	
	strRGBA := GetEditValue(ElementBySignature(eRec, 'CNAM'));
	strTemp := Copy(strRGBA, Pos('(', strRGBA) + 1, Length(strRGBA) - 4);
	
	strRed := Copy(strTemp, 1, Pos(',', strTemp) - 1);
	Delete(strTemp, 1, Length(strRed + ', '));
	
	strGreen := Copy(strTemp, 1, Pos(',', strTemp) - 1);
	Delete(strTemp, 1, Length(strGreen + ', '));
	
	strBlue := Copy(strTemp, 1, Pos(', ', strTemp) - 1);
	
	outstrRed := strRed;
	outstrGreen := strGreen;
	outstrBlue := strBlue;
end;

procedure SetColorLayer(eLayer: IInterface);
begin
	SetElementEditValues(eLayer, 'TETI - Index\Data Type', 'Value/Color');
end;

procedure SetDecalLayer(eLayer: IInterface);
begin
	SetElementEditValues(eLayer, 'TETI - Index\Data Type', 'Value');
end;

procedure SetLayerIndex(eLayer: IInterface; strIndex: string;);
begin
	SetElementEditValues(eLayer, 'TETI - Index\Index', strIndex);
end;

procedure SetLayerColorIndex(eLayer: IInterface; strColorIndex: string;);
begin
	SetElementEditValues(eLayer, 'TEND - Data\Template Color Index', strColorIndex);
end;

procedure SetLayerColorsRGB(eLayer: IInterface; iRed, iGreen, iBlue: integer);
begin
	SetElementEditValues(eLayer, 'TEND - Data\Color\Red', IntToStr(iRed));
	SetElementEditValues(eLayer, 'TEND - Data\Color\Green', IntToStr(iGreen));
	SetElementEditValues(eLayer, 'TEND - Data\Color\Blue', IntToStr(iBlue));
end;

procedure SetLayerIntensity(eLayer: IInterface; fIntensity: float);
begin
	SetElementEditValues(eLayer, 'TEND - Data\Value', FloatToStr(fIntensity));
end;


procedure SetLipColor(eLayer: IInterface);
var
	iRandIndex, iRandColorIndex, iRandIntensity: Integer;
	strR, strG, strB: string;
	bShowTintLayer: boolean;
begin
	AddMessage('Adding Lip Color');
	SetColorLayer(eLayer);
	
	iRandIndex := Random(tstrlistLipLayers.Count);
	SetLayerIndex(eLayer, tstrlistLipLayers[iRandIndex]);
	
	iRandColorIndex := Random(tstrlistColor.Count); // Don't need to - 1. Good ol' Random() function.
	GetRGBFromCLFM(tstrlistColor[iRandColorIndex], strR, strG, strB);
	
	SetLayerColorIndex(eLayer, tstrlistColorIndexes[iRandColorIndex]);
	SetLayerColorsRGB(eLayer, StrToInt(strR), StrToInt(strG), StrToInt(strB));
	
	bShowTintLayer := Random(2);
	
	if bShowTintLayer then begin
		iRandIntensity := Random(301) + 700;
		SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	end
	else
		SetLayerIntensity(eLayer, 0.0);
	
end;

procedure SetBlemishes(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandNumberOfBlemishes, iRandIndex, iRandIntensity, iCounter: integer;
begin
	AddMessage('Adding blemishes');
	iRandNumberOfBlemishes := Random(4);
	
	if iRandNumberOfBlemishes > 0 then
		for iCounter := 0 to iRandNumberOfBlemishes - 1 do begin
			
			eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
			iRandIndex := Random(tstrlistBlemishes.Count);
			iRandIntensity := Random(401) + 350;
			
			SetDecalLayer(eLayer);
			SetLayerIndex(eLayer, tstrlistBlemishes[iRandIndex]);
			SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
			
		end;
	
end;

procedure SetBlemishesMandatory(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIntensity, iCounter: integer;
	bOldLady: boolean;
begin
	AddMessage('Adding age blemishes');
	bOldLady := Random(2);
	
	for iCounter := 0 to tstrlistBlemishesMandatory.Count - 1 do begin
		
		eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		
		if bOldLady then
			iRandIntensity := Random(251) + 750
		else
			iRandIntensity := Random(251) + 400;
		
		SetDecalLayer(eLayer);
		SetLayerIndex(eLayer, tstrlistBlemishesMandatory[iCounter]);
		SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
		
	end;
	
end;

procedure SetBrows(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIndex: integer;
begin
	AddMessage('Adding brows');
	iRandIndex := Random(tstrlistBrows.Count);
	
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	SetDecalLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistBrows[iRandIndex]);
	SetLayerIntensity(eLayer, 1.0);
	
end;

procedure SetDamage(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandNumberOfScars, iRandIndex, iRandIntensity, iCounter: integer;
	bFreshScar: boolean;
begin
	AddMessage('Adding damage');
	iRandNumberOfScars := Random(6);
	
	if iRandNumberOfScars > 0 then
		for iCounter := 0 to iRandNumberOfScars do begin
			
			eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
			iRandIndex := Random(tstrlistDamage.Count);
			
			bFreshScar := Random(2);
			
			if bFreshScar then
				iRandIntensity := Random(301) + 500
			else
				iRandIntensity := Random(300) + 100;
			
			SetDecalLayer(eLayer);
			SetLayerIndex(eLayer, tstrlistDamage[iRandIndex]);
			SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
			
		end;
	
end;

procedure SetFacePaint(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	tstrlistCurrentFacePaintIndex: TStringList;
	iRandIndex, iRandColor, iRandColorIndex, iRandIntensity,
	iNumberOfCharsInStr, iNumberOfIndexChars, iNumberOfCharsToCopy: integer;
	bFadedPaint: boolean;
	strCurrentFacePaint, strFacePaintPath, strR, strG, strB: string;
begin
	AddMessage('Adding face paint');
	iRandIndex := Random(tstrlistFacePaint.Count);
	iRandColor := Random(tstrlistFacePaintColors.Count);
	bFadedPaint := Random(2);
	
	if bFadedPaint then
		iRandIntensity := Random(251) + 350
	else
		iRandIntensity := Random(251) + 550;
	
	iNumberOfIndexChars := Length('1697 Face Paint - '); // From the first line in the TStringList
	iNumberOfCharsInStr := Length(tstrlistFacePaint[iRandIndex]);
	iNumberOfCharsToCopy := iNumberOfCharsInStr - iNumberOfIndexChars;
	
	strCurrentFacePaint := Copy(tstrlistFacePaint[iRandIndex], Pos(' - ', tstrlistFacePaint[iRandIndex]) + 3, iNumberOfCharsToCopy);
	strFacePaintPath := 'Edit Scripts\FyTy\Face Tints - Final\Colors\Face Paint\' + strCurrentFacePaint + ' - Color Indexes.txt';
	
	tstrlistCurrentFacePaintIndex := TStringList.Create;
	tstrlistCurrentFacePaintIndex.LoadFromFile(ProgramPath + strFacePaintPath);
	iRandColorIndex := Random(tstrlistCurrentFacePaintIndex.Count);
	
	GetRGBFromCLFM(tstrlistFacePaintColors[iRandColor], strR, strG, strB);
	
	
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	SetColorLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistFacePaint[iRandIndex]);
	SetLayerColorIndex(eLayer, tstrlistCurrentFacePaintIndex[iRandColorIndex]);
	SetLayerColorsRGB(eLayer, IntToStr(strR), IntToStr(strG), IntToStr(strB));
	
	SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	
	
	tstrlistCurrentFacePaintIndex.Free;
	
end;

procedure SetFaceTattoo(eFaceTintingLayers: IInterface;);
var
	eLayer: IInterface;
	iRandIndex, iRandIntensity: integer;
	bFadedTattoo: boolean;
begin
	AddMessage('Adding tattoo');
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	iRandIndex := Random(tstrlistFaceTattoo.Count);
	bFadedTattoo := Random(2);
	
	if bFadedTattoo then
		iRandIntensity := Random(251) + 250
	else
		iRandIntensity := Random(451) + 350;
	
	SetDecalLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistFaceTattoo[iRandIndex]);
	SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	
end;


procedure SetBlush(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandColor, iRandIntensity, iCounter: integer;
	strR, strG, strB: string;
	bLayItOnThick: boolean;
begin
	
	bLayItOnThick := Random(2);
	
	if bLayItOnThick then
		AddMessage('Adding thick blush')
	else
		AddMessage('Adding blush');
	
	iRandColor := Random(tstrlistMakeupBlushColor.Count);
	
	if bLayItOnThick then
		iRandIntensity := Random(601) + 200
	else
		iRandIntensity := Random(401) + 100;
	
	
	for iCounter := 0 to tstrlistMakeupBlush.Count - 1 do begin
		
		eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		
		SetColorLayer(eLayer);
		SetLayerIndex(eLayer, tstrlistMakeupBlush[iCounter]);
		
		GetRGBFromCLFM(tstrlistMakeupBlushColor[iRandColor], strR, strG, strB);
		
		SetLayerColorIndex(eLayer, tstrlistMakeupBlushColorIndexes[iRandColor]);
		SetLayerColorsRGB(eLayer, StrToInt(strR), StrToInt(strG), StrToInt(strB));
		SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
		
	end;
	
end;

procedure SetEyeLiner(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iNumOfLayers, iRandIndex, iRandColor, iRandIntensity, iCounter: integer;
	strR, strG, strB: string;
begin
	AddMessage('Adding eye liner');
	iNumOfLayers := Random(tstrlistMakeupEyeLiner.Count);
	
	iRandColor := Random(tstrlistMakeupEyeLinerColor.Count);
	GetRGBFromCLFM(tstrlistMakeupEyeLinerColor[iRandColor], strR, strG, strB);
	
	iRandIntensity := Random(301) + 700;
	
	for iCounter := 0 to iNumOfLayers do begin
		
		iRandIndex := Random(tstrlistMakeupEyeLiner.Count);
		
		eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		
		SetColorLayer(eLayer);
		SetLayerIndex(eLayer, tstrlistMakeupEyeLiner[iRandIndex]);
		SetLayerColorIndex(eLayer, tstrlistMakeupEyeLinerColorIndexes[iRandColor]);
		SetLayerColorsRGB(eLayer, strR, strG, strB);
		SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
		
	end;
	
end;

procedure SetEyeShadow(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandColor, iRandColorLower, iRandIntensity, iIntensityMod, iCounter: integer;
	bDoCurrentShadow, bDoDiffLowerColor, bDoDiffIntensity, bDiffForLowerOrUpper: boolean;
	strR, strG, strB: string;
begin
	AddMessage('Adding eye shadow');
	iRandColor := Random(tstrlistMakeupEyeShadowColor.Count);
	iIntensityMod := (Random(9) + 1);
	iRandIntensity := Random(301) + 500;
	
	bDoDiffLowerColor := Random(2);
	if bDoDiffLowerColor then
		iRandColorLower := Random(tstrlistMakeupEyeShadowColor.Count)
	else
		iRandColorLower := iRandColor;
	
	bDoDiffIntensity := Random(2);
	bDiffForLowerOrUpper := Random(2);
	
	
	for iCounter := 0 to tstrlistMakeupEyeShadow.Count - 1 do begin
		
		bDoCurrentShadow := Random(2);
		if not bDoCurrentShadow then
			Continue; // Skip current loop iteration
		
		eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		
		SetColorLayer(eLayer);
		SetLayerIndex(eLayer, tstrlistMakeupEyeShadow[iCounter]);
		
		
		if pos('Lower', tstrlistMakeupEyeShadow[iCounter]) > 0 then begin
			
			GetRGBFromCLFM(tstrlistMakeupEyeShadowColor[iRandColorLower], strR, strG, strB);
			
			SetLayerColorIndex(eLayer, tstrlistMakeupEyeShadowColorIndexes[iRandColorLower]);
			SetLayerColorsRGB(eLayer, StrToInt(strR), StrToInt(strG), StrToInt(strB));
			
			SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
			
			if not bDiffForLowerOrUpper then
				if bDoDiffIntensity then
					SetLayerIntensity(eLayer, (iRandIntensity / iIntensityMod) / 1000.0);
			
		end
		else begin
			
			GetRGBFromCLFM(tstrlistMakeupEyeShadowColor[iRandColor], strR, strG, strB);
			
			SetLayerColorIndex(eLayer, tstrlistMakeupEyeShadowColorIndexes[iRandColor]);
			SetLayerColorsRGB(eLayer, strR, strG, strB);
			
			SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
			
			if bDiffForLowerOrUpper then
				if bDoDiffIntensity then
					SetLayerIntensity(eLayer, (iRandIntensity / iIntensityMod) / 1000.0);
			
		end;
		
	end;
	
end;

procedure SetLipLiner(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIndex, iRandColor, iRandIntensity: integer;
	strR, strG, strB: string;
begin
	AddMessage('Adding lip liner');
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	if tstrlistMakeupLipLiner.Count = 1 then
		iRandIndex := 0
	else
		iRandIndex := Random(tstrlistMakeupLipLiner.Count);
		
	iRandColor := Random(tstrlistMakeupLipLinerColor.Count);
	iRandIntensity := Random(601) + 200;
	
	GetRGBFromCLFM(tstrlistMakeupLipLinerColor[iRandColor], strR, strG, strB);
	
	SetColorLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistMakeupLipLiner[iRandIndex]);
	SetLayerColorIndex(eLayer, tstrlistMakeupLipLinerColorIndexes[iRandColor]);
	SetLayerColorsRGB(eLayer, StrToInt(strR), StrToInt(strG), StrToInt(strB));
	SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	
end;

procedure SetLipstick(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIndex, iRandColor, iRandIntensity: integer;
	strR, strG, strB: string;
	bLayItOnThick: boolean;
begin
	AddMessage('Adding lipstick');
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	if tstrlistMakeupLipstick.Count = 1 then
		iRandIndex := 0
	else
		iRandIndex := Random(tstrlistMakeupLipstick.Count);
	
	bLayItOnThick := Random(2);
	if bLayItOnThick then
		iRandIntensity := Random(201) + 650
	else
		iRandIntensity := Random(401) + 300;
	
	iRandColor := Random(tstrlistMakeupLipstickColor.Count);
	
	GetRGBFromCLFM(tstrlistMakeupLipstickColor[iRandColor], strR, strG, strB);
	
	SetColorLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistMakeupLipstick[iRandIndex]);
	SetLayerColorIndex(eLayer, tstrlistMakeupLipstickColorIndexes[iRandColor]);
	SetLayerColorsRGB(eLayer, IntToStr(strR), IntToStr(strG), IntToStr(StrB));
	SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	
end;

procedure SetLipDecals(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIndex, iRandIntensity: integer;
	bLayItOnThick: boolean;
begin
	AddMessage('Adding lip decals');
	iRandIndex := Random(tstrlistMakeupLipDecals.Count);
	
	bLayItOnThick := Random(2);
	if bLayItOnThick then
		iRandIntensity := Random(201) + 650
	else
		iRandIntensity := Random(401) + 100;
	
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	SetDecalLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistMakeupLipDecals[iRandIndex]);
	SetLayerIntensity(eLayer, iRandIntensity / 1000.0);
	
end;

procedure SetSkinTints(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIndex, iRandColor: integer;
	strR, strG, strB: string;
begin
	AddMessage('Adding skin color');
	eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
	
	if tstrlistSkinTints.Count = 1 then
		iRandIndex := 0
	else
		iRandIndex := Random(tstrlistSkinTints.Count);
	
	iRandColor := Random(tstrlistSkinTintsColor.Count);
	
	GetRGBFromCLFM(tstrlistSkinTintsColor[iRandColor], strR, strG, strB);
	
	SetColorLayer(eLayer);
	SetLayerIndex(eLayer, tstrlistSkinTints[iRandIndex]);
	SetLayerColorIndex(eLayer, tstrlistSkinTintsColorIndexes[iRandColor]);
	SetLayerColorsRGB(eLayer, IntToStr(strR), IntToStr(strG), IntToStr(strB));
	SetLayerIntensity(eLayer, 1.0000);
end;

procedure SetMarkings(eFaceTintingLayers: IInterface);
var
	eLayer: IInterface;
	iRandIntensity, iCounter: integer;
	bSkipCurrent: boolean;
begin
	AddMessage('Adding markings');
	iRandIntensity := Random(701) + 300;
	
	for iCounter := 0 to tstrlistMarkings.Count - 1 do begin
	
		bSkipCurrent := Random(2);
		if bSkipCurrent then
			Continue;
		
		eLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		SetDecalLayer(eLayer);
		SetLayerIndex(eLayer, tstrlistMarkings[iCounter]);
		SetLayerIntensity(eLayer, iRandIntensity / 1000.0)
		
	end;
	
end;


procedure RemoveDuplicates(eFaceTintingLayers: IInterface);
var
	eCurrentLayer: IInterface;
	tstrlistLayers: TStringList;
	strIndex, strIndexPath: string;
	iCounter, iDummy: integer;
begin
	
	AddMessage('Removing duplicates');
	tstrlistLayers := TStringList.Create;
	tstrlistLayers.Sorted := true;
	strIndexPath := 'TETI - Index\Index';
	
	for iCounter := Pred(ElementCount(eFaceTintingLayers)) downto 0 do begin
		eCurrentLayer := ElementByIndex(eFaceTintingLayers, iCounter);
		strIndex := GetElementEditValues(eCurrentLayer, strIndexPath);
		
		if not tstrlistLayers.Find(strIndex, iDummy) then
			tstrlistLayers.Add(strIndex)
		else
			Remove(eCurrentLayer);
	end;
	
	tstrlistLayers.Free;
	
end;


function Process(e: IInterface): integer;
var
	eFaceTintingLayers: IInterface;
	iRandDoFacePaint, iRandDoTattoo, iRandDoLipLiner, iRandDoLipDecals: integer;
	bDoFacePaint, bDoTattoo, bDoBlush, bDoEyeLiner, bDoEyeShadow, bDoLipstick, bDoMarkings: boolean;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	{
	if ElementExists(e, 'Face Tinting Layers') then
		Remove(ElementByName(e, 'Face Tinting Layers'));
	}
	
	//eFaceTintingLayers := Add(e, 'Face Tinting Layers', false);
	eFaceTintingLayers := ElementByPath(e, 'Face Tinting Layers');
	
	
	//SetLipColor(ElementByIndex(eFaceTintingLayers, 0)); // Lip Color will use the auto-created, null tint layer
	
	if not bPreventBlemishes then
		SetBlemishes(eFaceTintingLayers);
	
	SetBlemishesMandatory(eFaceTintingLayers);
	
	SetBrows(eFaceTintingLayers);
	
	if not bPreventDamage then
		SetDamage(eFaceTintingLayers);
	
	if not bPreventTattoo then begin
		iRandDoTattoo := Random(6) + 1;
		if iRandDoTattoo = 6 then
			bDoTattoo := true;
	
		if bDoTattoo then
			SetFaceTattoo(eFaceTintingLayers);
	end;
	
	if not bPreventFacePaint then
		if bDoTattoo = false then begin
			iRandDoFacePaint := Random(6) + 1;
			if iRandDoFacePaint = 6 then
				bDoFacePaint := true;
			
			if bDoFacePaint then
				SetFacePaint(eFaceTintingLayers);
		end;
	
	
	if not bPreventBlush then begin
		bDoBlush := Random(2);
		if bDoBlush then
			SetBlush(eFaceTintingLayers);
	end;
	
	if not bPreventEyeLiner then begin
		bDoEyeLiner := Random(2);
		if bDoEyeLiner then
			SetEyeLiner(eFaceTintingLayers);
	end;
	
	if not bPreventEyeShadow then begin
		bDoEyeShadow := Random(2);
		if bDoEyeShadow then
			SetEyeShadow(eFaceTintingLayers);
	end;
	
	if not bPreventLipLiner then begin
		iRandDoLipLiner := Random(6) + 1;
		if iRandDoLipLiner = 6 then
			SetLipLiner(eFaceTintingLayers);
	end;
	
	if not bPreventLipstick then begin
		bDoLipstick := Random(2);
		if bDoLipstick then
			SetLipstick(eFaceTintingLayers);
	end;
	
	if not bPreventLipDecals then begin
		iRandDoLipDecals := Random(4);
		if iRandDoLipDecals = 3 then
			SetLipDecals(eFaceTintingLayers);
	end;
	
	if not bPreventSkinTints then
		SetSkinTints(eFaceTintingLayers);
	
	if not bPreventMarkings then begin
		bDoMarkings := Random(2);
		if bDoMarkings then
			SetMarkings(eFaceTintingLayers);
	end;
	
	RemoveDuplicates(eFaceTintingLayers);
	
end;


procedure FreeTheTStringLists;
begin
	
	tstrlistColor.Free;
	
	tstrlistColorIndexes.Free;
	
	tstrlistLipLayers.Free;
	
	
	tstrlistBlemishes.Free;
	
	tstrlistBlemishesMandatory.Free;
	
	
	tstrlistBrows.Free;
	
	
	tstrlistDamage.Free;
	
	
	tstrlistFacePaint.Free;
	
	tstrlistFacePaintColors.Free;
	
	
	tstrlistFaceTattoo.Free;
	
	
	tstrlistMakeupBlush.Free;
	
	tstrlistMakeupBlushColor.Free;
	
	tstrlistMakeupBlushColorIndexes.Free;
	
	
	tstrlistMakeupEyeLiner.Free;
	
	tstrlistMakeupEyeLinerColor.Free;
	
	tstrlistMakeupEyeLinerColorIndexes.Free;
	
	
	tstrlistMakeupEyeShadow.Free;
	
	tstrlistMakeupEyeShadowColor.Free;
	
	tstrlistMakeupEyeShadowColorIndexes.Free;
	
	
	tstrlistMakeupLipLiner.Free;
	
	tstrlistMakeupLipLinerColor.Free;
	
	tstrlistMakeupLipLinerColorIndexes.Free;
	
	
	
	tstrlistMakeupLipstick.Free;
		
	tstrlistMakeupLipstickColor.Free;
	
	tstrlistMakeupLipstickColorIndexes.Free;
	
	
	tstrlistMakeupLipDecals.Free;
	
	
	tstrlistSkinTints.Free;
	
	tstrlistSkinTintsColor.Free;
	
	tstrlistSkinTintsColorIndexes.Free;
	
	
	tstrlistMarkings.Free;
	
end;

function Finalize: integer;
begin
	
	FreeTheTStringLists;
	
end;

end.