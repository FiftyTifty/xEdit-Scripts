unit userscript;

const
	strMyEDIDPath = ScriptsPath + 'FyTy\Movable Statics To Items\My EDIDs to Replace.txt';
	strSourceEDIDPath = ScriptsPath + 'FyTy\Movable Statics To Items\Source EDIDs to Replace.txt';

var
	tstrlistMyEDIDs, tstrlistSourceEDIDs: TStringList;
	
function Initialize: integer;
begin

	tstrlistMyEDIDs := TStringList.Create;
	tstrlistSourceEDIDs := TStringList.Create;
	
	tstrlistMyEDIDs.LoadFromFile(strMyEDIDPath);
	tstrlistSourceEDIDs.LoadFromFile(strSourceEDIDPath);
	
end;


function Process(e: IInterface): integer;
var
	strFormID, strFullFormID: string;
	iCounter: integer;
begin

	if Signature(e) <> 'LVLI' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strFormID := FormID(e);
	strFullFormID := GetElementEditValues(e, 'Record Header\FormID');
	
	for iCounter := 0 to tstrlistMyEDIDs.Count - 1 do begin
		
		if tstrlistMyEDIDs[iCounter] = strFullFormID then begin
			AddMessage('Changing tstrlistMyEDIDs entry!');
			tstrlistMyEDIDs[iCounter] := strFormID;
		end;
		
	end;
	
	for iCounter := 0 to tstrlistSourceEDIDs.Count - 1 do begin
		
		if tstrlistSourceEDIDs[iCounter] = strFullFormID then begin
			AddMessage('Changing tstrlistSourceEDIDs entry!');
			tstrlistSourceEDIDs[iCounter] := strFormID;
		end;
		
	end;
	
end;


function Finalize: integer;
begin
	
	tstrlistMyEDIDs.SaveToFile(strMyEDIDPath);
	tstrlistSourceEDIDs.SaveToFile(strSourceEDIDPath);
	
	tstrlistMyEDIDs.Free;
	tstrlistSourceEDIDs.Free;
	
end;

end.