unit userscript;

var
	i: integer;

function Initialize: integer;
begin
	
	for i := 0 to FileCount - 1 do begin
		AddMessage(GetFileName(FileByIndex(i))+' is at Index '+IntToStr(i));
	end;
	
end;

end.