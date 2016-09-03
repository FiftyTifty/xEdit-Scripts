unit userscript;
var
	sString, testString: string;
	
function Initialize: integer;
begin

end;


function Process(e: IInterface): integer;
begin
  AddMessage('Processing: ' + FullPath(e));
	
	testString := '123';
	AddMessage('The length of an empty string is: '+IntToStr(Length(testString)));
	AddMessage(testString[1]);
	sString := IntToStr(FormID(e));
	AddMessage(sString[1]);
	AddMessage(IntToStr(FormID(e)));
	AddMessage(IntToStr(FixedFormID(e)));
	AddMessage(IntToHex(FormID(e), 8));
	AddMessage(IntToHex(FixedFormID(e), 8));
end;


function Finalize: integer;
begin

end;

end.