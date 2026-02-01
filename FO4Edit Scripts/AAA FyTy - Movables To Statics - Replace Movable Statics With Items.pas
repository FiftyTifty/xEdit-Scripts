unit userscript;
const
	strlistSourcePath = ScriptsPath + 'FyTy\Movable Statics To Items\Fallout4esm Source.txt';
	strlistDestPath = ScriptsPath + 'FyTy\Movable Statics To Items\Fallout4esm Dest.txt';
var
	eMyFile: IInterface;
	tstrlistSource, tstrlistDest: TStringList;
	
function Initialize: integer;
begin
  eMyFile := FileByIndex(8);
	
	tstrlistSource := TStringList.Create;
	tstrlistSource.LoadFromFile(strlistSourcePath);
	
	tstrlistDest := TStringList.Create;
	tstrlistDest.LoadFromFile(strlistDestPath);
end;


function Process(e: IInterface): integer;
var
	iPos: integer;
	strNAME: string;
	eReplace: IInterface;
begin
	
	if Signature(e) <> 'REFR' then
		exit;
	
	if Check(e) <> '' then
		exit;
	
	strNAME := GetElementEditValues(e, 'NAME');
	
	if tstrlistSource.IndexOf(strNAME) >= 0 then begin
		//AddMessage('Processing: ' + FullPath(e));
		iPos := tstrlistSource.IndexOf(strNAME);
		eReplace := wbCopyElementToFile(e, eMyFile, false, true);
		SetElementEditValues(eReplace, 'NAME', tstrlistDest[iPos])
	end;

end;


function Finalize: integer;
begin
  tstrlistSource.Free;
	tstrlistDest.Free;
end;

end.