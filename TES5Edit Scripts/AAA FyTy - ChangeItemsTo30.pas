{
  THis is a script.  Yada yada. Awesome.
}

unit UserScript;

//The "Process" function typically goes through all the elements you selected (Files, records, elements...)
function Process(e: IInterface): integer;
var
	Number: Integer;
  IHaveAGunAndIWillTravel: IInterface;
  TooLongForU: IInterface;
begin
  // Does a check to see if the selected records are of the "CONT" type; CONT is short for container. If they aren't, the script stops via "Exit;"
  if Signature(e) <> 'CONT' then
    Exit;
    // "e" Stands for elements. They are pretty much everything, but usually refer to the thingies inside records.
    // However, when the line below is processed, it will show the records.
  AddMessage('Processing: ' + FullPath(e));
  
  IHaveAGunAndIWillTravel := ElementByPath(e, 'Items'); // Assigning the IInterface variable "IHaveAGunAndIWillTravel" to the "Items" element.
  
  // Declaring Number to have a value of 0. Using the for loop to go between 0 and the number of elements.
  for Number := 0 to ElementCount(IHaveAGunAndIWillTravel) - 1 do begin
    // Gets the Variable "TooLongForU", sets it to a subelement (such as Item\CNTO - Item), and at the position of Number.
    // Number is set to 0, so it is set to the first subelement. In Pascal, 0 is first. Then 1 is second. 2 Is third. Etc.
    TooLongForU := ElementbyIndex(IHaveAGunAndIWillTravel, Number);
    SetElementEditValues(TooLongForU, 'CNTO - Item\Count', '30');
  end;

end;

end.
