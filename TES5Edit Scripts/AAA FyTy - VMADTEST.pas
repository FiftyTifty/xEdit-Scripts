unit UserScript;

function Process(e: IInterface): integer;
var
  e1, e2, e3, e4, e5: IInterface;
begin
  e1 := ElementByPath(e, 'VMAD');
  
  AddMessage(GetElementEditValues(e1, 'Version'));
  
  e2 := ElementByPath(e, 'VMAD\Data\Quest VMAD\Scripts\Script');
  
  AddMessage(GetElementEditValues(e2, 'scriptName'));
  
  e3 := ElementByPath(e, 'VMAD\Data\Quest VMAD\Scripts\Script\Properties\Property');
  
  AddMessage(GetElementEditValues(e3, 'propertyName'));
  
  e4 := ElementByPath(e, 'VMAD\Data\Quest VMAD\Scripts\Script\Properties\Property\Value\Array of Object');
  e5 := ElementAssign(e4, HighInteger, nil, false);
end;

end.
