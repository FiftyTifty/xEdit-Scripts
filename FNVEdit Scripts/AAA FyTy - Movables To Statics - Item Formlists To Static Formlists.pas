unit userscript;
const
	iStaticTemplateFormID = 218207551;
	iFormlistTemplateFormID = 218216773;
	strStaticTemplateEDID = 'AAAFyTy_StaticItem_';
var
	eMyFile, eStaticTemplate, eFormlistTemplate: IInterface;


function Initialize: integer;
begin
  eMyFile := FileByIndex(14);
	eStaticTemplate := RecordByFormID(eMyFile, iStaticTemplateFormID, true);
	eFormlistTemplate := RecordByFormID(eMyFile, iFormlistTemplateFormID, true);
end;


function Process(e: IInterface): integer;
var
	iCounter, iAltTextureCount: integer;
	eFormIDs, eNewFormlist, eNewRecord, eRecord, eOrigEDID, eNewEDID,
	eFormListEntry, eNewAltTextures, eNewAltTexture,
	eOrigAltTextures, eOrigAltTexture: IInterface;
	strSignature, strFullFormID, strX1, strY1, strZ1, strX2, strY2, strZ2,
	strModel, str3DName, strNewTexture, str3DIndex: string;
	bDoOnce: boolean;
begin
	if Signature(e) <> 'FLST' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	bDoOnce := false;
	
	eFormIDs := ElementByPath(e, 'FormIDs');
	
	eNewFormlist := wbCopyElementToFile(eFormlistTemplate, eMyFile, true, true);
	
	for iCounter := 0 to ElementCount(eFormIDs) - 1 do begin
	
		eRecord := LinksTo(ElementByIndex(eFormIDs, iCounter));
		
		strX1 := GetElementEditValues(eRecord, 'OBND - Object Bounds\X1');
		strY1 := GetElementEditValues(eRecord, 'OBND - Object Bounds\Y1');
		strZ1 := GetElementEditValues(eRecord, 'OBND - Object Bounds\Z1');
		strX2 := GetElementEditValues(eRecord, 'OBND - Object Bounds\X2');
		strY2 := GetElementEditValues(eRecord, 'OBND - Object Bounds\Y2');
		strZ2 := GetElementEditValues(eRecord, 'OBND - Object Bounds\Z2');
		
		eNewRecord := wbCopyElementToFile(eStaticTemplate, eMyFile, true, true);
		SetElementEditValues(eNewRecord, 'EDID', strStaticTemplateEDID + GetElementEditValues(eRecord, 'EDID'));
		
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\X1', strX1);
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\Y1', strY1);
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\Z1', strZ1);
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\X2', strX2);
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\Y2', strY2);
		SetElementEditValues(eNewRecord, 'OBND - Object Bounds\Z2', strZ2);
		
		strSignature := Signature(eRecord);
		
		if strSignature = 'ARMO' then begin
			AddMessage('Processing armor');
			SetEditValue(ElementByPath(eNewRecord, 'Model\MODL'), GetElementEditValues(eRecord, 'Male biped model\MODL'));
			
			if ElementCount(ElementByPath(eRecord, 'Male world model\MO2S - Alternate Textures')) > 0 then begin
				AddMessage('Processing alt textures');
				eOrigAltTextures := ElementByPath(eRecord, 'Male world model\MO2S - Alternate Textures');
				iAltTextureCount := ElementCount(eOrigAltTextures);
				AddMessage(IntToStr(iAltTextureCount));
				SetEditValue(ElementByPath(eNewRecord, 'Model\MODL'), GetElementEditValues(eRecord, 'Male world model\MOD2'));
				AddMessage('Set model path');
				eNewAltTextures := Add(ElementByPath(eNewRecord, 'Model'), 'MODS', false);
				//AddMessage('Added alt textures container');
				
				for iCounter := 0 to iAltTextureCount - 1 do begin
					AddMessage('Processing each alt texture');
					eOrigAltTexture := ElementByIndex(eOrigAltTextures, iCounter);
					AddMessage(GetElementEditValues(eOrigAltTexture, '3D Name'));
					str3DName := GetElementEditValues(eOrigAltTexture, '3D Name');
					strNewTexture := GetElementEditValues(eOrigAltTexture, 'New Texture');
					str3DIndex := GetElementEditValues(eOrigAltTexture, '3D Index');
					
					eNewAltTexture := ElementAssign(eNewAltTextures, HighInteger, nil, false);
					SetElementEditValues(eNewAltTexture, '3D Name', str3DName);
					SetElementEditValues(eNewAltTexture, 'New Texture', strNewTexture);
					SetElementEditValues(eNewAltTexture, '3D Index', str3DIndex);
				end;
				
			end;
			
		end;
		
		
		if strSignature <> 'ARMO' then begin
			
			SetEditValue(ElementByPath(eNewRecord, 'Model\MODL'), GetElementEditValues(eRecord, 'Model\MODL'));
			
			eOrigAltTextures := ElementByPath(eRecord, 'Model\MODS');
			iAltTextureCount := ElementCount(eOrigAltTextures);
			
			if iAltTextureCount > 0 then begin
				
				eNewAltTextures := Add(ElementByPath(eNewRecord, 'Model'), 'MODS', false);
				//AddMessage(iAltTextureCount);
				
				for iCounter := 0 to iAltTextureCount do begin
					
					eOrigAltTexture := ElementByIndex(eOrigAltTextures, iCounter);
					str3DName := GetElementEditValues(eOrigAltTexture, '3D Name');
					strNewTexture := GetElementEditValues(eOrigAltTexture, 'New Texture');
					str3DIndex := GetElementEditValues(eOrigAltTexture, '3D Index');
					
					eNewAltTexture := ElementAssign(eNewAltTextures, HighInteger, nil, false);
					SetElementEditValues(eNewAltTexture, '3D Name', str3DName);
					SetElementEditValues(eNewAltTexture, 'New Texture', strNewTexture);
					SetElementEditValues(eNewAltTexture, '3D Index', str3DIndex);
					
				end;
				
			end;
			
		end;
		
		
		strFullFormID := GetElementEditValues(eNewRecord, 'Record Header\FormID');
		AddMessage(strFullFormID);
		
		if (bDoOnce = true) then begin
			eFormListEntry := ElementAssign(ElementByName(eNewFormlist, 'FormIDs'), HighInteger, nil, false);
			SetEditValue(eFormListEntry, strFullFormID);
			AddMessage('Added new entry');
		end;
		
		if (bDoOnce = false) then begin
			eFormListEntry := ElementByIndex(ElementByPath(eNewFormlist, 'FormIDs'), 0);
			SetEditValue(eFormListEntry, strFullFormID);
			AddMessage('Edited first entry');
			bDoOnce := true;
		end;
		
	end;
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.
