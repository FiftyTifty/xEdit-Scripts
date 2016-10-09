unit userscript;

function Initialize: integer;
begin
	
	
	
end;


function Process(e: IInterface): integer;
begin
	if Signature(e) <> 'NPC_' then
		exit;
		
  AddMessage('Processing: ' + FullPath(e));
	
	if GetEditValue(ElementBySignature(e, 'FTST')) = 'NULL - Null Reference [00000000]' then
		Remove(ElementBySignature(e, 'FTST'));
	
	if GetEditValue(ElementBySignature(e, 'HCLF')) = 'NULL - Null Reference [00000000]' then
		Remove(ElementBySignature(e, 'HCLF'));

end;


function Finalize: integer;
begin
	
	
	
end;

end.