unit UserScript;

function Process(e: IInterface): integer;
var
  Number: Integer;
  BaseThing: IInterface;
  SubBase: IInterface;
  begin

    if Signature(e) <> 'QUST' then
      Exit;

    AddMessage('Processing: ' + FullPath(e));
 
    BaseThing := ElementByPath(e, 'VMAD - Virtual Machine Adapter\Data\Quest VMAD\Scripts\Script\Properties\Property\Value\Array of Object');
    for Number := 0 to ElementCount(BaseThing) - 1 do begin
      SubBase := ElementByIndex(BaseThing, Number);
      SetElementEditValues(SubBase, 'ObjectUnion#\Object v2\Alias', '-1');
  end;
end;

end.
