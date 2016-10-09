unit userscript;

var
  ePath, ePath02: IInterface;
	bChemBox, bArmourBox, bCookingBox, bArmorsmithBox, bChangeCategory: Boolean;

function Initialize: integer;
begin	
	bChemBox := false;
	bArmourBox := false;
	bCookingBox := false;
	bArmorsmithBox := true;
	bChangeCategory := false;
end;
	
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'COBJ' then
	exit;

//  AddMessage('Processing: ' + FullPath(e));

	if ElementExists(e, 'BNAM - Workbench Keyword') = 0 then
		exit;
  
  ePath := ElementByPath(e, 'BNAM - Workbench Keyword');
	ePath02 := ElementByPath(e, 'FNAM - Category\Keyword #0');
	
	if bChemBox then
		SetEditValue(ePath, 'WorkbenchChemlab [KYWD:00102158]');
	
	if bArmourBox then
		SetEditValue(ePath, 'workbencharmor [KYWD:000657FF]');
	
	if bCookingBox then
		SetEditValue(ePath, 'WorkbenchCooking [KYWD:00102152]');

	if bArmorsmithBox then
		SetEditValue(ePath, 'AEC_ck_ArmorsmithCraftingKey [KYWD:08000851]');
		
	if bChangeCategory then
		SetEditValue(ePath02, '00_RecipeCalyps "Cutoffs" [KYWD:020008C2]');
	
end;

end.
