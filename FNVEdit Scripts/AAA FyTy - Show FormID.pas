unit userscript;

function Initialize: integer;
begin

end;


function Process(e: IInterface): integer;
begin
  AddMessage('Processing: ' + FullPath(e));
	
	AddMessage(IntToStr(FormID(e)));
	AddMessage(IntToStr(FixedFormID(e)));
	AddMessage(IntToHex(FormID(e), 8));
	AddMessage(IntToHex(FixedFormID(e), 8));
end;


function Finalize: integer;
begin

end;

end.