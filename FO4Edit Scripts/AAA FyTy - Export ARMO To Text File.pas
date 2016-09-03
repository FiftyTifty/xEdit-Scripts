unit userscript;

var
FormIDList: TStringList;
ePath: IInterface;
eString: string;
i, iRandom: integer;

function Initialize: integer;
begin
  FormIDList := TStringList.Create;
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'ARMO' then
		exit;

  AddMessage('Processing: ' + FullPath(e));

	ePath := ElementByPath(e, 'Record Header\FormID');
	eString := GetEditValue(ePath);
	
	FormIDList.Add(eString);
end;


function Finalize: integer;
begin

	For i := 0 to (FormIDList.Count - 1) do begin
		Randomize();
		iRandom := Random(FormIDList.Count - i);
		FormIDList.Exchange(i, i + iRandom);
	end;

	FormIDList.SaveToFile(ProgramPath + 'Edit Scripts\FyTy\Clothes FormIDs.txt');
end;

end.