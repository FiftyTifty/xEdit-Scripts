unit userscript;
const
	strPrefix = 'fyty\radio\escape\';
	strSoundPrefix = 'AAAFyTyRadioEscape01Sound';
var
	eFile, eTemplateSound, eTemplateDialogue: IInterface;
	tstrlistRadioFileNames: TStringList;


function Initialize: integer;
begin

  eFile := FileByIndex(2);
	eTemplateSound := RecordByFormID(eFile, 16780747, true);
	eTemplateDialogue := RecordByFormID(eFile, 16785853, true);
	
	tstrlistRadioFileNames := TStringList.Create;
	tstrlistRadioFileNames.LoadFromFile(ScriptsPath + 'FyTy\Radio\Escape01FileNames.txt');
end;


function Finalize: integer;
var
	iCounter: integer;
	eNewSound, eNewDialogue, eResponse: IInterface;
	strCounter, strAudioFile, strNewSoundFullFormID: string;
begin
	
	for iCounter := 0 to tstrlistRadioFileNames.Count - 1 do begin
		
		strCounter := Format('%0.3d',[iCounter]);
		strAudioFile := strPrefix + tstrlistRadioFileNames[iCounter];
		
		eNewSound := wbCopyElementToFile(eTemplateSound, eFile, true, true);
		eNewDialogue := wbCopyElementToFile(eTemplateDialogue, eFile, true, true);
		
		SetElementEditValues(eNewSound, 'EDID', strSoundPrefix + strCounter);
		SetElementEditValues(eNewSound, 'FNAM', strAudioFile);
		
		strNewSoundFullFormID := GetElementEditValues(eNewSound, 'Record Header\FormID');
		eResponse := ElementByIndex(ElementByPath(eNewDialogue, 'Responses'), 0);
		eResponse := ElementByPath(eResponse, 'TRDT\Sound');
		SetEditValue(eResponse, strNewSoundFullFormID);
		
	end;
	
  tstrlistRadioFileNames.Free;
end;

end.