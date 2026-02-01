unit userscript;
const
	strSourceListPath = ScriptsPath + 'FyTy\Records From Formlist\SourceFormlists.txt';
	strDestListPath = ScriptsPath + 'FyTy\Records From Formlist\DestFormlists.txt';
	strFormIDPath = 'Record Header\FormID';
var
	eMyFile, eConstructibleTemplate, eScrapRecipeTemplate: IInterface;
	tstrlistSourceList, tstrlistDestList: TStringList;


function Initialize: integer;
begin

	eMyFile := FileByIndex(8);
  eConstructibleTemplate := RecordByFormID(eMyFile, 117501597, true);
	eScrapRecipeTemplate := RecordByFormID(eMyFile, 117501596, true);
	
	tstrlistSourceList := TStringList.Create;
	tstrlistSourceList.LoadFromFile(strSourceListPath);
	
	tstrlistDestList := TStringList.Create;
	tstrlistDestList.LoadFromFile(strDestListPath);
	
end;

function Finalize: integer;
var
	iCounter, iFormlistCounter: integer;
	strSourceEDID, strSourceItemFullFormID, strDestStaticFullFormID, strScrapRecipeFullFormID: string;
	eFormlistSource, eFormlistDest, eSourceItem, eDestStatic, eSourceFormIDs, eDestFormIDs,
	eNewScrapRecipe, eNewConstructible, eRecipeFormIDs, eConstructibleComponents: IInterface;
begin
  
	for iCounter := 0 to tstrlistSourceList.Count - 1 do begin
		
		eFormlistSource := RecordByFormID(eMyFile, StrToInt(tstrlistSourceList[iCounter]), true);
		eFormlistDest := RecordByFormID(eMyFile, StrToInt(tstrlistDestList[iCounter]), true);
		
		eSourceFormIDs := ElementByPath(eFormlistSource, 'FormIDs');
		eDestFormIDs := ElementByPath(eFormlistDest, 'FormIDs');
		
		for iFormlistCounter := 0 to ElementCount(eSourceFormIDs) - 1 do begin
			
			eSourceItem := LinksTo(ElementByIndex(eSourceFormIDs, iFormlistCounter));
			eDestStatic := LinksTo(ElementByIndex(eDestFormIDs, iFormlistCounter));
			
			strSourceEDID := GetElementEditValues(eSourceItem, 'EDID');
			strSourceItemFullFormID := GetElementEditValues(eSourceItem, strFormIDPath);
			strDestStaticFullFormID := GetElementEditValues(eDestStatic, strFormIDPath);
			
			
			eNewScrapRecipe := wbCopyElementToFile(eScrapRecipeTemplate, eMyFile, true, true);
			SetElementEditValues(eNewScrapRecipe, 'EDID', GetElementEditValues(eNewScrapRecipe, 'EDID') + strSourceEDID);
			strScrapRecipeFullFormID := GetElementEditValues(eNewScrapRecipe, strFormIDPath);
			
			eRecipeFormIDs := Add(eNewScrapRecipe, 'FormIDs', false);
			SetEditValue(ElementByIndex(eRecipeFormIDs, 0), strDestStaticFullFormID);
			
			
			eNewConstructible := wbCopyElementToFile(eConstructibleTemplate, eMyFile, true, true);
			SetElementEditValues(eNewConstructible, 'EDID', GetElementEditValues(eNewConstructible, 'EDID') + strSourceEDID);
			eConstructibleComponents := ElementBySignature(eNewConstructible, 'FVPA');
			
			SetElementEditValues(ElementByIndex(eConstructibleComponents, 0), 'Component', strSourceItemFullFormID);
			SetElementEditValues(ElementByIndex(eConstructibleComponents, 0), 'Count', 1);
			
			SetElementEditValues(eNewConstructible, 'CNAM', strScrapRecipeFullFormID);
			
			
			
		end;
		
	end;
	
end;

end.