{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

// Called before processing
// You can remove it if script doesn't require initialization code
var
  ePath: IInterface;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
  ePath := ElementByPath(e, 'DOFT');
  if GetEditValue(ePath) = '[0203CEEA] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[0303CEEA]');
  if GetEditValue(ePath) = '[0203CEE8] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[0303CEE8]');
  if GetEditValue(ePath) = '[0201F9C6] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[0301F9C6]');
  if GetEditValue(ePath) = '[02037FE8] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[03037FE8]');
  if GetEditValue(ePath) = '[020398CA] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[030398CA]');
  if GetEditValue(ePath) = '[0203CEEC] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[0303CEEC]');
  if GetEditValue(ePath) = '[02026B60] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[03026B60]');
  if GetEditValue(ePath) = '[02039B34] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[03039B34]');
  if GetEditValue(ePath) = '[0203CEE9] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[0303CEE9]');
  if GetEditValue(ePath) = '[02026B5B] < Error: Could not be resolved >' then
    SetEditValue(ePath, '[03026B5B]');
end;

end.
