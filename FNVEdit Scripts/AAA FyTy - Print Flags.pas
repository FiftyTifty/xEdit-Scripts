unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin


  AddMessage(GetElementEditValues(e, 'DATA - Data\Flags\Respawns'));


end;


function Finalize: integer;
begin
	
end;

end.