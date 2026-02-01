unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	RemoveNode(ElementBySignature(e, 'VMAD'));
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.