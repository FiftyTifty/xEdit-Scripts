unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
begin

	if (Signature(e) <> 'CONT') then
		exit;
		
  RemoveElement(e, 'Items');


end;


function Finalize: integer;
begin
	
end;

end.