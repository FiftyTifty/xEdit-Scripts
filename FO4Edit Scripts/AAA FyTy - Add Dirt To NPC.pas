unit userscript;
uses 'AAA FyTy - Aux Functions';

var
	strDirtySkin: string;
	tstrlistDirtyLayerIndex, tstrlistDirtyLayerColor, tstrlistDirtyLayerColorIndex: TStringList;


function Initialize: integer;
begin
  strDirtySkin := 'SkinNakedDirty [ARMO:000ADA90]';
	
	tstrlistDirtyLayerIndex := TStringList.Create;
	tstrlistDirtyLayerIndex.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Grime\_All - Layer Index.txt');
	
	tstrlistDirtyLayerColor := TStringList.Create;
	tstrlistDirtyLayerColor.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Grime\_All - Layer Color.txt');
	
	tstrlistDirtyLayerColorIndex := TStringList.Create;
	tstrlistDirtyLayerColorIndex.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Face Tints - Final\Grime\_All - Color Indexes.txt');
end;


function Process(e: IInterface): integer;
var
	eFaceTintingLayers, eAddedLayer: IInterface;
	bDoFaceDirt: boolean;
	iRand, iRandColorIntensity: integer;
	fRandColorIntensity: float;
	strColorIntensity, strColorR, strColorG, strColorB: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	Randomize();
	
	bDoFaceDirt := Random(2);
	
	if (bDoFaceDirt = true) then begin
		iRand := Random(10);
		iRandColorIntensity := Random(40) + 57;
		fRandColorIntensity := iRandColorIntensity / 100;
		strColorIntensity := FloatToStr(fRandColorIntensity);
		
		eFaceTintingLayers := ElementByName(e, 'Face Tinting Layers');
		eAddedLayer := ElementAssign(eFaceTintingLayers, HighInteger, nil, false);
		
		GetRGBFromCLFM(tstrlistDirtyLayerColor[iRand], strColorR, strColorG, strColorB);
		
		
		SetElementEditValues(eAddedLayer, 'TETI\Data Type', 'Value/Color');
		SetElementEditValues(eAddedLayer, 'TETI\Index', tstrlistDirtyLayerIndex[iRand]);
		
		SetElementEditValues(eAddedLayer, 'TEND\Value', strColorIntensity);
		SetElementEditValues(eAddedLayer, 'TEND\Template Color Index', tstrlistDirtyLayerColorIndex[iRand]);
		SetElementEditValues(eAddedLayer, 'TEND\Color\Red', strColorR);
		SetElementEditValues(eAddedLayer, 'TEND\Color\Green', strColorG);
		SetElementEditValues(eAddedLayer, 'TEND\Color\Blue', strColorB);
	end;
	
	Add(e, 'WNAM', false);
	SetElementEditValues(e, 'WNAM', strDirtySkin);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.