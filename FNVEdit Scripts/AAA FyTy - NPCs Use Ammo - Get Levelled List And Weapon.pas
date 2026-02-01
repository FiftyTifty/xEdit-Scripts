unit userscript;
const
	strPath = ScriptsPath + 'FyTy\NPCsUseAmmo\WeapToLLI.txt';
var
	tstrlistOutput: TStringList;

function Initialize: integer;
begin
  
	tstrlistOutput := TStringList.Create;
	
end;


function Process(e: IInterface): integer;
var
	eWEAP, eWeapLLI, eEntries: IInterface;
	strFormID, strWeapFormID, strEDID: string;
begin

	strEDID := GetElementEditValues(e, 'EDID');
	
	if (Signature(e) <> 'LVLI') or (pos('FyTy', strEDID) = 0) or (pos('WithAmmo', strEDID) = 0) then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	strFormID := GetElementEditValues(e, 'Record Header\FormID');
	
	eWeapLLI := LinksTo(ElementByPath(e, 'Leveled List Entries\[1]\LVLO - Base Data\Reference'));
	
	eEntries := ElementByPath(eWeapLLI, 'Leveled List Entries');
	AddMessage(GetElementEditValues(ElementByIndex(eEntries, ElementCount(eEntries) - 1), 'LVLO - Base Data\Reference'));
	eWEAP := LinksTo(ElementByPath(ElementByIndex(eEntries, ElementCount(eEntries) - 1), 'LVLO - Base Data\Reference'));
	
	strWeapFormID := GetElementEditValues(eWEAP, 'Record Header\FormID');
	
	tstrlistOutput.Add(strWeapFormID + ',' + strFormID);


end;

function Finalize: integer;
begin
  
	tstrlistOutput.SaveToFile(strPath);
	tstrlistOutput.Free;
	
end;

end.