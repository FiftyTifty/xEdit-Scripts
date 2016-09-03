{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
  ePath: IInterface;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'IMGS' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
  ePath := ElementByPath(e, 'HNAM - HDR\Eye Adapt Strength');
  SetEditValue(ePath, '0');
end;

end.
