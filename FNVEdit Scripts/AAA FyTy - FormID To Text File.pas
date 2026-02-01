unit userscript;
const
	strAntPNAM = 'AntBodyPartData [BPTD:00014C03]';
	strBarkScorpionPNAM = 'RadScorpionBodyPart [BPTD:0003161D]';
	
var
	tstrlistText: TStringList;
	strFilePath: string;

function Initialize: integer;
begin
  tstrlistText := TStringList.Create;
	strFilePath := ScriptsPath + 'FyTy\Damage Overhaul\BarkScorpions.txt';
end;


function Process(e: IInterface): integer;
var
	strFormID: string;
begin
	
	if GetElementEditValues(e, 'PNAM') <> strBarkScorpionPNAM then
		exit;
	
	if Pos('Dead', GetElementEditValues(e, 'EDID')) > 0 then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFormID := IntToStr(FixedFormID(e));
	
	tstrlistText.Add(strFormID);


end;


function Finalize: integer;
begin
  tstrlistText.SaveToFile(strFilePath);
end;

end.
