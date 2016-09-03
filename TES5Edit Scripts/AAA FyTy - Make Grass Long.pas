unit userscript;
var
  ePath: IInterface;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'GRAS' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
  ePath := ElementByPath(e, 'DATA\Height Range');
	
  SetEditValue(ePath, '1');
end;

end.
