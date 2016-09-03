unit userscript;
var
	i: integer;
function Process(e: IInterface): integer;
begin
  //AddMessage(IntToHex(FormID(e), 8));
  i := FormID(e) + 67108864;
  //AddMessage(IntToHex('83898506', 8));
  if IntToHex(i, 8) = IntToHex('83898506', 8) then begin
	AddMessage(GetEditValue(ElementByPath(e, 'Record Header\FormID')));
	AddMessage('Found it');
  end;

end;

end.
