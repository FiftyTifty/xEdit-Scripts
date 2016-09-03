unit userscript;

var
	ReplaceChoice: string;
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'INFO' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	ReplaceChoice := 'RadioHello "RadioHello" [DIAL:00000126]';
	
	Remove(ElementByPath(e, 'Script (End)\Embedded Script\SCDA - Compiled Embedded Script'));
	Remove(ElementByPath(e, 'Script (End)\Embedded Script\SCTX - Embedded Script Source'));
	Remove(ElementByPath(e, 'Script (End)\Embedded Script\References'));
	Remove(ElementByPath(e, 'Conditions'));
	
	SetEditValue(ElementByPath(e, 'Script (End)\Embedded Script\SCHR - Basic Script Data\RefCount'), '0');
	SetEditValue(ElementByPath(e, 'Script (End)\Embedded Script\SCHR - Basic Script Data\CompiledSize'), '0');
	
	//SetEditValue(ElementBySignature(e, 'TCLT'), 'ReplaceChoice');
	end;

end.