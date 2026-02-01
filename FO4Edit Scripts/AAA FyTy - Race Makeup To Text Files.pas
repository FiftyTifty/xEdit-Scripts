unit userscript;
const
	strBaseFolderPath = ScriptsPath + 'FyTy\Hot Mama\';
var
	tstrlistTintLayers: TStringList;
	
function Initialize: integer;
begin

	tstrlistTintLayers := TStringList.Create;

end;

function Process(e): integer;
var
	iGroupCounter, iOptionCounter, iColorCounter: Integer;
	eTintLayers, eGroupCurrent, eOptions, eOptionCurrent, eColors, eColorCurrent: IInterface;
	strMakeupData, strGroupName: string;
begin

	if Signature(e) <> 'RACE' then
		exit;

	eTintLayers := ElementByPath(e, 'Female Tint Layers');
	
	for iGroupCounter := 0 to ElementCount(eTintLayers) - 1 do begin
	
		eGroupCurrent := ElementByIndex(eTintLayers, iGroupCounter);
		
		strGroupName := GetElementEditValues(eGroupCurrent, 'TTGP - Group Name');
		
		if (strGroupName = 'Makeup') or (strGroupName = 'SkinTints') then begin
		
			eOptions := ElementByPath(eGroupCurrent, 'Options');
			
			for iOptionCounter := 0 to ElementCount(eOptions) - 1 do begin
				
				eOptionCurrent := ElementByIndex(eOptions, iOptionCounter);

				if ElementExists(eOptionCurrent, 'TTEC - Template Colors') then begin
				
					eColors := ElementByPath(eOptionCurrent, 'TTEC - Template Colors');
				
					for iColorCounter := 0 to ElementCount(eColors) - 1 do begin

						//Now we create the row and give it data!
						//Format is:
						//Makeup Layer Name, Layer ID, [Color Template Index, Color Name, Default Strength, Makeup number in CharGen UI]
							
						if strMakeupData = '' then begin
						
							strMakeupData := GetElementEditValues(eOptionCurrent, 'TTGP - Name') + ',';
							strMakeupData := strMakeupData + GetElementEditValues(eOptionCurrent, 'TETI - Index\Index');
							
						end;
						
						eColorCurrent := ElementByIndex(eColors, iColorCounter);
						
						if pos('None', GetElementEditValues(eColorCurrent, 'Color')) = 0 then begin
						
							strMakeupData := strMakeupData + ',' + GetElementEditValues(eColorCurrent, 'Template Index');
							strMakeupData := strMakeupData + ',' + GetElementEditValues(eColorCurrent, 'Color') + ',';
							strMakeupData := strMakeupData + GetElementEditValues(eColorCurrent, 'Alpha') + ',';
							strMakeupData := strMakeupData + IntToStr(iColorCounter);
							
						end;
					
					end;
					
					//AddMessage(Finished iterating through colours!);
					if strMakeupData <> '' then
						tstrlistTintLayers.Add(strMakeupData);
					
					strMakeupData := '';
					
				end;
			
			end;
			
			//AddMessage('Finished iterating through makeup! Exiting!');
			//exit;
		
		end;
	
	end;

end;

function Finalize: integer;
begin
	
	tstrlistTintLayers.SaveToFile(strBaseFolderPath + 'MakeupLayerData.txt');
	tstrlistTintLayers.Free;
	
end;

end.