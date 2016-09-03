{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
  FarAwayModel: IInterface;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
    if Signature(e) <> 'NPC_' then
      Exit;

  // comment this out if you don't want those messages
  AddMessage('Processing: ' + FullPath(e));
  
  FarAwayModel := ElementByPath (e, 'ANAM');
  
  if GetEditValue(FarAwayModel) = 'SkinNakedFar [ARMO:00040731]' then begin
    Remove(FarAwayModel);
  end;
  
  SetElementEditValues(e, 'DNAM\Far away model distance', '0');

  // processing code goes here

end;

end.