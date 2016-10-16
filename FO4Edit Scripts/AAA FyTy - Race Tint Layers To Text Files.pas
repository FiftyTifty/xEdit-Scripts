unit userscript;
var
	fileFallout4, eHumanRace, eTintLayerContainer: IInterface;
	strBaseFolderPath: string;
	tstrlistTintLayers, tstrlistTintLayerIndexes, tstrlistFullTintLayers,
	tstrlistTemplateColors, tstrlistTemplateColorIndexes: TStringList;

function Initialize: integer;
begin
	
	SetupBaseFolderPath;
	
	
	strBaseFolderPath := ProgramPath + 'Edit Scripts\FyTy\Face Tint Groups\';
	fileFallout4 := FileByIndex(0);
	eHumanRace := RecordByFormID(fileFallout4, 79686, false);
	eTintLayerContainer := ElementByPath(eHumanRace, 'Female Tint Layers');
	
	
	OutputTintGroupsToFolder;
	
end;


procedure SetupBaseFolderPath;
begin
	if not DirectoryExists(ProgramPath + 'Edit Scripts\FyTy') then
		CreateDir(ProgramPath + 'Edit Scripts\FyTy');
		
	if not DirectoryExists(ProgramPath + 'Edit Scripts\FyTy\Face Tint Groups') then
		CreateDir(ProgramPath + 'Edit Scripts\FyTy\Face Tint Groups');
end;


procedure OutputTintGroupsToFolder;
var
	eCurrentTintContainer, eCurrentTintLayer, eTemplateColors: IInterface;
	iCounter, iSubCounter, iCounterForColors: integer;
	strTintGroup, strTintLayerIndex, strTintLayerName, strNewFolderPath: string;
begin
	
	
	for iCounter := 0 to ElementCount(eTintLayerContainer) - 1 do begin // Iterate through every tint layer category
	
		strTintGroup := GetElementEditValues(ElementByIndex(eTintLayerContainer, iCounter), 'TTGP'); // This contains the individual tint layers
		strNewFolderPath := strBaseFolderPath + strTintGroup + '\';
		
		if not DirectoryExists(strNewFolderPath) then // If we haven't already made it
			if not CreateDir (strNewFolderPath) then // Try to create the directory. If the script fails
				AddMessage('Failed to create: ' + strNewFolderPath); // Output the directory to FO4Edit
		
		tstrlistTintLayers := TStringList.Create;
		tstrlistTintLayerIndexes := TStringList.Create;
		
		eCurrentTintContainer := ElementByPath(ElementByIndex(eTintLayerContainer, iCounter), 'Options');
		
		
		for iSubCounter := 0 to ElementCount(eCurrentTintContainer) - 1 do begin // Iterate through every tint layer variation (e.g, all tattoos)
			
			eCurrentTintLayer := ElementByIndex(eCurrentTintContainer, iSubCounter);
			
			strTintLayerIndex := GetElementEditValues(eCurrentTintLayer, 'TETI - Index\Index');
			strTintLayerName := GetElementEditValues(eCurrentTintLayer, 'TTGP - Name');
			
			tstrlistTintLayerIndexes.Add(strTintLayerIndex);
			tstrlistTintLayers.Add(strTintLayerName);
			
			
			// Some tint layers can have colour variations, which is embedded in the tint layer itself.
			// So we have to iterate through each colour for the current tint layer.
			// We're gonna have a nice repetoire of text files goin'
			if ElementExists(eCurrentTintLayer, 'TTEC - Template Colors') then begin
				
				
				eTemplateColors := ElementBySignature(eCurrentTintLayer, 'TTEC');
				
				tstrlistTemplateColors := TStringList.Create;
				tstrlistTemplateColorIndexes := TStringList.Create;
				
				
				for iCounterForColors := 0 to ElementCount(eTemplateColors) - 1 do begin
					
					tstrlistTemplateColors.Add(GetElementEditValues(ElementByIndex(eTemplateColors, iCounterForColors), 'Color'));
					tstrlistTemplateColorIndexes.Add(GetElementEditValues(ElementByIndex(eTemplateColors, iCounterForColors), 'Template Index'));
					
				end;
				
				
			tstrlistTemplateColors.SaveToFile(strNewFolderPath + strTintLayerName + ' - Color.txt');
			tstrlistTemplateColorIndexes.SaveToFile(strNewFolderPath + strTintLayerName + ' - Color Indexes.txt');
			
			tstrlistTemplateColors.Free;
			tstrlistTemplateColorIndexes.Free;
				
			end;
			
			
		end;
		
		
		tstrlistTintLayerIndexes.SaveToFile(strNewFolderPath + strTintGroup + ' - Layer Indexes.txt');
		tstrlistTintLayers.SaveToFile(strNewFolderPath + strTintGroup + ' - Layer Names.txt');
		
		
		tstrlistFullTintLayers := TStringList.Create;
		
		for iSubCounter := 0 to tstrlistTintLayers.Count - 1 do begin
		
			tstrlistFullTintLayers.Add(tstrlistTintLayerIndexes[iSubCounter] + ' ' + strTintGroup + ' - ' + tstrlistTintLayers[iSubCounter]);
		end;
		
		tstrlistFullTintLayers.SaveToFile(strNewFolderPath + strTintGroup + ' - Full Layer IDs.txt');
		
		tstrlistFullTintLayers.Free;
		tstrlistTintLayerIndexes.Free;
		tstrlistTintLayers.Free;
		
	end;
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.