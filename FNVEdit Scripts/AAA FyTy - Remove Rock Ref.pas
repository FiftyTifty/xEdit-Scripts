unit userscript;

uses mteFunctions;

var
	MyFile, CopiedRecord: IInterface;
	Check, Replace: string;
	ListOfRocks: TStringList;
	i: integer;
	
function Initialize: integer;

begin
	ListOfRocks := TStringList.Create;
	AddMessage('Created String List');
	ListOfRocks.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Rock Refrs.txt');
	AddMessage('Loaded List From File');
	ListOfRocks.Sort;
	AddMessage('Sorted List');
	MyFile := FileSelect('Select a file below:');
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
		exit;	
	
	Check := GetEditValue(ElementByPath(e, 'NAME - Base'));
	//AddMessage('Assigned Check Variabe: '+Check);
	
	if (ListOfRocks.IndexOf(Check) <> -1) then begin
		//AddMessage('Removing Useless Rock References');
		CopiedRecord := wbCopyElementToFile(e, MyFile, false, true);
		SetIsInitiallyDisabled(CopiedRecord, true);
	end;

end;

end.
