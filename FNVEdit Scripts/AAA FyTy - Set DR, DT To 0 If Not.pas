{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
	EditValueDT, EditValueAR, EditValueEDID: string;
// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'ARMO' then
      Exit;

  // comment this out if you don't want those messages
//  AddMessage('Processing: ' + FullPath(e));
  
  EditValueDT := StrToFloat(GetEditValue(ElementByPath(e, 'DNAM\DT')));
  EditValueAR := StrToFloat(GetEditValue(ElementByPath(e, 'DNAM\AR')));
  EditValueEDID := GetEditValue(ElementByPath(e, 'EDID'));
  
  if (EditValueDT > 0) or (EditValueAR > 0) then begin
		AddMessage(EditValueEDID);
		SetEditValue(ElementByPath(e, 'DNAM\DT'), '0');
		SetEditValue(ElementByPath(e, 'DNAM\AR'), '0');
	end;

  // processing code goes here

end;

end.