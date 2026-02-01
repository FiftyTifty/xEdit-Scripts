unit userscript;
uses 'AAA FyTy - Aux Functions';
const
	strPathAsData = 'S:\Games\steamapps\common\Fallout 4\MO2\mods\FyTy - Classic Music\';
	strFile = 'FyTy - Classic Music.esp';
	strPrefix = 'AAAFyTy_CM_';
var
	eMyFile: IInterface;

function Initialize: integer;
var
	TDirectory: TDirectory;
	tstrarrayFiles: TStringDynArray;
	groupMUST: IwbGroupRecord;
	recMUST: IwbMainRecord;
	eEDID, eCNAM, eANAM: IInterface;
	strCurrent, strFileName, strDataPathToFile: string;
	iCounter, iFileIndex: Integer;
begin
  
	eMyFile := GetFileByName(strFile, iFileIndex);
	
	groupMUST := GroupBySignature(eMyFile, 'MUST');
	
	if not Assigned(groupMUST) then
		groupMUST := Add(eMyFile, 'MUST', False);
	
	tstrarrayFiles := TDirectory.GetFiles(strPathAsData, '*.xwm', soAllDirectories);
	AddMessage(IntToStr(Length(tstrarrayFiles) - 1));
	
	for iCounter := 0 to Length(tstrarrayFiles) - 1 do begin
	
		//AddMessage(tstrarrayFiles[iCounter]);
		
		strCurrent := tstrarrayFiles[iCounter];
		strFileName := ExtractFileName(strCurrent);
		
		strDataPathToFile := StringReplace(strCurrent, strPathAsData, 'Data\', [rfReplaceAll, rfIgnoreCase]);
		//AddMessage(strDataPathToFile);
		
		recMUST := Add(groupMUST, 'MUST', True);
		
		eEDID := Add(recMUST, 'EDID', False);
		
		AddMessage(strFileName);
		Delete(strFileName, Length(strFileName) - 3, 4);
		AddMessage(strFileName);
		SetEditValue(eEDID, strPrefix + strFileName);
		
		eCNAM := Add(recMUST, 'CNAM', False);
		SetEditValue(eCNAM, 'Single Track');
		
		eANAM := Add(recMUST, 'ANAM', False);
		SetEditValue(eANAM, strDataPathToFile);
	
	end;
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.