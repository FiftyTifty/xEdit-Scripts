unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if (Signature(e) <> 'CONT') then
		exit;
		
  SetElementEditValues(e, 'DATA - DATA\Flags\Respawns', 0);


end;


function Finalize: integer;
begin
	
end;

end.