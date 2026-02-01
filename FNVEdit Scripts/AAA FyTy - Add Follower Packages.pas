unit userscript;
var
	tstrlistFollowerPackages: TStringList;


function Initialize: integer;
begin
  tstrlistFollowerPackages := TStringList.Create;
	tstrlistFollowerPackages.LoadFromFile(ScriptsPath + 'FyTy\Companion Framework\FollowerPackages.txt');
end;


function Process(e: IInterface): integer;
var
	ePackages, ePackage: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'CREA' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	RemoveElement(e, 'Packages');
	ePackages := Add(e, 'Packages', false);
	
	SetEditValue(ElementByIndex(ePackages, 0), tstrlistFollowerPackages[12]);
	
	for iCounter := Pred(tstrlistFollowerPackages.Count - 1) downto  0 do begin
		ePackage := ElementAssign(ePackages, HighInteger, nil, false);
		SetEditValue(ePackage, tstrlistFollowerPackages[iCounter]);
	end;
	
end;


function Finalize: integer;
begin
  tstrlistFollowerPackages.Free;
end;

end.