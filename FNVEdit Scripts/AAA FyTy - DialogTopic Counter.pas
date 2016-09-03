unit userscript;

var
	iCount: integer;

function Initialize: integer;
begin
  iCount := 0;
end;


function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'INFO' then
		exit;

  inc(iCount);
		
end;


function Finalize: integer;
begin
  AddMessage(IntToStr(iCount));
end;

end.