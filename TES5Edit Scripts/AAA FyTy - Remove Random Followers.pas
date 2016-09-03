unit userscript;
uses mtefunctions;

var
	FollowerList: TStringList;
	CurrentRec, FollowerRec, MyFile: IInterface;
	FollowerFID, NameStr: string;
	iRand, i: integer;

function Initialize: integer;
begin
	MyFile := FileSelect('Select File That Has The NPC_ Records');
	FollowerList := TStringList.Create;
	FollowerList.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Records - Followers.txt');
end;

procedure DoStuff(e: IInterface; iInteger: integer);
begin
	FollowerRec := RecordByFormID(MyFile, StrToInt(FollowerList[iInteger]), true);
	FollowerFID := GetElementEditValues(FollowerRec, 'Record Header\FormID');
	//AddMessage('Doing Stuff');
	//AddMessage(NameStr+'******'+FollowerFID);
	//AddMessage(IntToStr(iRand));
	
	if (iRand = 1) then
		if (NameStr = FollowerFID) then
			RemoveNode(CurrentRec);
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'ACHR' then
		exit;

  //AddMessage('Processing: ' + FullPath(e));
	
	NameStr := GetElementEditValues(e, 'NAME - Base');
	CurrentRec := e;
	
	for i := 0 to FollowerList.Count - 1 do begin
		randomize;
		iRand := Random(3);
		DoStuff(e, i);
	end;
	
	
end;


function Finalize: integer;
begin

end;

end.