{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
	EditValueDT, EditValueRepairList, EditValueEDID: string;
// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'ARMO' then
      Exit;

  // comment this out if you don't want those messages
//  AddMessage('Processing: ' + FullPath(e));
  
  EditValueDT := StrToFloat(GetEditValue(ElementByPath(e, 'DNAM\DT')));
	EditValueRepairList := GetEditValue(ElementByPath(e, 'REPL'));
  EditValueEDID := GetEditValue(ElementByPath(e, 'EDID'));
  
  if (EditValueRepairList = 'RepairMetalArmor [FLST:00075205]') and (EditValueDT > 12) then begin
		AddMessage(EditValueEDID);
//		SetEditValue(ElementByPath(e, 'DNAM\DT'), '6');
	end;

  // processing code goes here

end;

end.