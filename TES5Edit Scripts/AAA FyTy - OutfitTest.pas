unit UserScript;

function Process(e: IInterface): integer;

var
outfitnpc, outfitele, outfitItemsList, item: IInterface;
outfitString, itemstring: string;
i: integer;

begin


    if Signature(e) <> 'NPC_' then
  Exit;

  AddMessage('Processing: ' + FullPath(e));

{  outfitnpc := ElementByPath(e, 'DOFT - Default outfit');
  outfitString := GetEditValue(outfit);
  AddMessage(''+outfitString+'');
}
//Above works! Outputs the outfit element as a string.

  i := 0;
  
  outfitnpc := ElementByPath(e, 'DOFT - Default outfit');
  outfitele := LinksTo(outfitnpc);
  outfitItemsList := ElementByName(outfitele, 'INAM - Items');
  
  for i := 0 to ElementCount(outfitItemsList) do begin
  item := ElementByIndex(outfitItemsList, i);
  itemstring := item;
  AddMessage(''+itemstring'');
  end;
  

{  for i := 0 to ElementCount(itemsList) - 1 do begin
  item := ElementByIndex(itemsList, i);
  itemstring := item;
  AddMessage(''+itemstring+'');
  
   end;
}   end;
end.
