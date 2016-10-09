unit userscript;

function Initialize: integer;
begin

end;


function Process(e: IInterface): integer;
var
	strTest: string;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	strTest := 'theTESTstring';
	AddMessage(strTest);
	Delete(strTest, 4, 1);
	AddMessage(strTest);
	Insert('4', StrTest, 3); // 3rd char is now '4'
	AddMessage(strTest);

end;


function Finalize: integer;
begin

end;

end.