unit userscript;
const
	iStaticTemplateFormID = 117460048;
	iFormlistTemplateFormID = 117460050;
	strStaticTemplateEDID = 'AAAFyTy_StaticItem_';
var
	eMyFile, eStaticTemplate, eFormlistTemplate: IInterface;


function Initialize: integer;
begin
  eMyFile := FileByIndex(08);
	eStaticTemplate := RecordByFormID(eMyFile, iStaticTemplateFormID, true);
	eFormlistTemplate := RecordByFormID(eMyFile, iFormlistTemplateFormID, true);
end;


function Process(e: IInterface): integer;
var
	iCounter: integer;
	eFormIDs, eNewFormlist, eNewRecord, eRecord, eOrigEDID, eNewEDID,
	eFormListEntry, eNewModel, eNewMODL, eNewMODC, eNewMODS, eNewMODF: IInterface;
	strSignature, strFullFormID, strX1, strY1, strZ1, strX2, strY2, strZ2,
	strMODL, strMODC, strMODS, strMODF: string;
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
		
		if strSignature <> 'ARMO' then begin
		
			if GetElementEditValues(eRecord, 'Model\MODL - Model Filename') <> '' then begin
				eNewModel := Add(eNewRecord, 'Model', false);
				eNewMODL := Add(eNewModel, 'MODL', false);
				strMODL := GetElementEditValues(eRecord, 'Model\MODL - Model Filename');
				SetEditValue(eNewMODL, strMODL);
			end;
			
			if GetElementEditValues(eRecord, 'Model\MODC - Color Remapping Index') <> '' then begin
				eNewMODC := Add(eNewModel, 'MODC', false);
				strMODC := GetElementEditValues(eRecord, 'Model\MODC - Color Remapping Index');
				SetEditValue(eNewMODC, strMODC);
			end;
			
			if GetElementEditValues(eRecord, 'Model\MODS - Material Swap') <> '' then begin
				eNewMODS := Add(eNewModel, 'MODS', false);
				strMODS := GetElementEditValues(eRecord, 'Model\MODS - Material Swap');
				SetEditValue(eNewMODS, strMODS);
			end;
			
			
			if GetElementEditValues(eRecord, 'Model\MODF - Unknown') <> '' then begin
				eNewMODF := Add(eNewModel, 'MODF', false);
				strMODF := GetElementEditValues(eRecord, 'Model\MODF - Unknown');
				SetEditValue(eNewMODF, strMODF);
			end;
		
		end;
		
		if Signature(eRecord) = 'ARMO' then begin
			
			if GetElementEditValues(eRecord, 'Male world model\MOD2 - Model Filename') <> '' then begin
				eNewModel := Add(eNewRecord, 'Model', false);
				eNewMODL := Add(eNewModel, 'MODL', false);
				strMODL := GetElementEditValues(eRecord, 'Male world model\MOD2 - Model Filename');
				SetEditValue(eNewMODL, strMODL);
			end;
			
			if GetElementEditValues(eRecord, 'Male world model\MODC - Color Remapping Index') <> '' then begin
				eNewMODC := Add(eNewModel, 'MODC', false);
				strMODC := GetElementEditValues(eRecord, 'Male world model\MODC - Color Remapping Index');
				SetEditValue(eNewMODC, strMODC);
			end;
			
			if GetElementEditValues(eRecord, 'Male world model\MO2S - Material Swap') <> '' then begin
				eNewMODS := Add(eNewModel, 'MODS', false);
				strMODS := GetElementEditValues(eRecord, 'Male world model\MO2S - Material Swap');
				SetEditValue(eNewMODS, strMODS);
			end;
			
		end;
		
		
		strFullFormID := GetElementEditValues(eNewRecord, 'Record Header\FormID');
		AddMessage(strFullFormID);
		
		if (bDoOnce = false) then begin
			eFormListEntry := ElementByIndex(ElementByPath(eNewFormlist, 'FormIDs'), 0);
			SetEditValue(eFormListEntry, strFullFormID);
			AddMessage('Edited first entry');
			bDoOnce := true;
		end;
		
		if (bDoOnce = true) then begin
			eFormListEntry := ElementAssign(ElementByName(eNewFormlist, 'FormIDs'), HighInteger, nil, false);
			SetEditValue(eFormListEntry, strFullFormID);
			AddMessage('Added new entry');
		end;
		
	end;
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.