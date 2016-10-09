unit userscript;
var
	eBaseSettlerRecord, fileDestination: IInterface;
	
	strEDIDMain, strSuffix, strName, strACBSflags: string;
	strarrayFemaleSettlerVoices: array [1..3] of string;
	
	iTally: integer;

function Initialize: integer;
begin
	
	iTally := 000;
	strarrayFemaleSettlerVoices[1] := 'FemaleBoston [VTYP:00023324]';
	strarrayFemaleSettlerVoices[2] := 'FemaleRough [VTYP:0000002E]';
	strarrayFemaleSettlerVoices[3] := 'FemaleEvenToned [VTYP:00013ADD]';
	
	strEDIDMain := 'AAA_HotMama_EncSettlerFaceF_';
	strName := 'Settler';
	
	strACBSflags := '101010000001';
	
	fileDestination := FileByIndex(10);
	
	eBaseSettlerRecord := RecordByFormID(FileByIndex(1), 2400303, false);
	
end;


function UnFuckulateNameEDID(eName, eEDID): string;
begin
end;


function Process(e: IInterface): integer;
var
	eCopiedRecord,
	eHeadParts, eHairColor, eWeight, eHeadTexture, eTextureLighting, eMorphKeys,
	eMorphValues, eFaceLayers, eBodyMorph, eFaceMorph: IInterface;
	
	strNewEDID: string;
	iCounter, iRand: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	if GetElementEditValues(e, 'ACBS\Flags\Female') <> '1' then
		exit;
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	Randomize;
	
	eCopiedRecord := wbCopyElementToFile(eBaseSettlerRecord, fileDestination, true, true);
	
	
	//Create a unique EDID
	inc(iTally);
	strNewEDID := strEDIDMain + Format('%0.3d',[iTally]);
	setEditValue(ElementBySignature(eCopiedRecord, 'EDID'), strNewEDID);
	//end
	
	
	//Changing the voice to 1 of the 3 valid vanilla voicetypes.
	iRand := Random(3) + 1;
	SetEditValue(ElementBySignature(eCopiedRecord, 'VTCK'), strarrayFemaleSettlerVoices[iRand]);
	//end
	
	
	if ElementExists(e, 'Head Parts') then begin
		
		eHeadParts := ElementByPath(e, 'Head Parts');
		wbCopyElementToRecord(eHeadParts, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'HCLF') then begin
		
		eHairColor := ElementBySignature(e, 'HCLF');
		wbCopyElementToRecord(eHairColor, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'MWGT') then begin
		
		eWeight := ElementBySignature(e, 'MWGT');
		wbCopyElementToRecord(eWeight, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'FTST') then begin
		
		eHeadTexture := ElementBySignature(e, 'FTST');
		wbCopyElementToRecord(eHeadTexture, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'QNAM') then begin
		
		eTextureLighting := ElementBySignature(e, 'QNAM');
		wbCopyElementToRecord(eTextureLighting, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'MSDK') then begin
		
		eMorphKeys := ElementBySignature(e, 'MSDK');
		wbCopyElementToRecord(eMorphKeys, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'MSDV') then begin
		
		eMorphValues := ElementBySignature(e, 'MSDV');
		wbCopyElementToRecord(eMorphValues, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'Face Tinting Layers') then begin
		
		eFaceLayers := ElementByPath(e, 'Face Tinting Layers');
		wbCopyElementToRecord(eFaceLayers, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'MRSV') then begin
		
		eBodyMorph := ElementBySignature(e, 'MRSV');
		wbCopyElementToRecord(eBodyMorph, eCopiedRecord, true, true);
		
	end;
	
	
	if ElementExists(e, 'Face Morphs') then begin
		
		eFaceMorph := ElementByPath(e, 'Face Morphs');
		wbCopyElementToRecord(eFaceMorph, eCopiedRecord, true, true);
		
	end;
	
end;


function Finalize: integer;
begin
	
	
	
end;

end.