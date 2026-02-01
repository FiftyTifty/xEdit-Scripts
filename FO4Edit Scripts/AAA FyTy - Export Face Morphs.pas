unit userscript;
var
	tstrlistEyes, tstrlistForehead, tstrlistNose, tstrlistEars,
	tstrlistCheeks, tstrlistMouth, tstrlistNeck: TStringList;


function Initialize: integer;
begin
  tstrlistEyes := TStringList.Create;
	tstrlistForehead := TStringList.Create;
	tstrlistNose := TStringList.Create;
	tstrlistEars := TStringList.Create;
	tstrlistCheeks := TStringList.Create;
	tstrlistMouth := TStringList.Create;
	tstrlistNeck := TStringList.Create;
end;


function GetIndices(eMorphPresets: IInterface): TStringList;
var
	eMorphPreset: IInterface;
	tstrlistIndices: TStringList;
	iCounter: integer;
	strIndex: string;
begin

	tstrlistIndices := TStringList.Create;
	
	for iCounter := 0 to ElementCount(eMorphPresets) - 1 do begin
		eMorphPreset := ElementByIndex(eMorphPresets, iCounter);
		
		strIndex := GetElementEditValues(eMorphPreset, 'MPPI - Index');
		strIndex := strIndex + ' - ';
		strIndex := strIndex + GetElementEditValues(eMorphPreset, 'MPPN - Name');
		tstrlistIndices.Add(strIndex);
	end;
	
	Result := tstrlistIndices;
	
end;


function Process(e: IInterface): integer;
var
	eMorphGroups, eMorphGroupEyes, eMorphGroupForehead,
	eMorphGroupNose, eMorphGroupEars, eMorphGroupCheeks,
	eMorphGroupMouth, eMorphGroupNeck: IInterface;
begin
	
	if Signature(e) <> 'RACE' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eMorphGroups := ElementByPath(e, 'Female Morph Groups');
	eMorphGroupEyes := ElementByIndex(eMorphGroups, 0);
	eMorphGroupForehead := ElementByIndex(eMorphGroups, 1);
	eMorphGroupNose := ElementByIndex(eMorphGroups, 2);
	eMorphGroupEars := ElementByIndex(eMorphGroups, 3);
	eMorphGroupCheeks := ElementByIndex(eMorphGroups, 4);
	eMorphGroupMouth := ElementByIndex(eMorphGroups, 6);
	eMorphGroupNeck := ElementByIndex(eMorphGroups, 8);

	tstrlistEyes := GetIndices(ElementByPath(eMorphGroupEyes, 'Morph Presets'));
	tstrlistForehead := GetIndices(ElementByPath(eMorphGroupForehead, 'Morph Presets'));
	tstrlistNose := GetIndices(ElementByPath(eMorphGroupNose, 'Morph Presets'));
	tstrlistEars := GetIndices(ElementByPath(eMorphGroupEars, 'Morph Presets'));
	tstrlistCheeks := GetIndices(ElementByPath(eMorphGroupCheeks, 'Morph Presets'));
	tstrlistMouth := GetIndices(ElementByPath(eMorphGroupMouth, 'Morph Presets'));
	tstrlistNeck := GetIndices(ElementByPath(eMorphGroupNeck, 'Morph Presets'));
	
end;


function Finalize: integer;
begin

  tstrlistEyes.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Eyes Texture\Eyes - Indexes + Names.txt');
	tstrlistForehead.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Forehead Texture\Forehead - Indexes + Names.txt');
	tstrlistNose.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Nose Texture\Nose - Indexes + Names.txt');
	tstrlistEars.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Ears Texture\Ears - Indexes + Names.txt');
	tstrlistCheeks.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Cheeks Texture\Cheeks - Indexes + Names.txt');
	tstrlistMouth.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Mouth Texture\Mouth - Indexes + Names.txt');
	tstrlistNeck.SaveToFile(ScriptsPath + '\FyTy\Face Tints - Sorted\Textures\Neck Texture\Neck - Indexes + Names.txt');
	
	tstrlistEyes.Free;
	tstrlistForehead.Free;
	tstrlistNose.Free;
	tstrlistEars.Free;
	tstrlistCheeks.Free;
	tstrlistMouth.Free;
	tstrlistNeck.Free;
	
end;

end.