unit userscript;

var
	eKeywords: IInterface;

function Initialize: integer;
begin

end;

procedure DoKeywords(e: IInterface);
begin
	eKeywords := Add(e, 'KWDA', false);
end;

function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'Packages') = true then begin
		AddMessage('Packages Exist');
		DoKeywords(e);
	end;
		
	SetEditValue(ElementByIndex(eKeywords, 0), 'AAAFyTyTraveller [KYWD:07163679]');

end;


function Finalize: integer;
begin

end;

end.