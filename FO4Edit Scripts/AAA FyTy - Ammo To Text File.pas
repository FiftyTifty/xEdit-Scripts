unit userscript;

	{
		This script will iterate through every selected ammo record. If it's usable by the player,
		it will have it's full FormID added to a TStringList, which is then saved to a file.
		
		Take note that when using Insert(), the first line of the TStringList (which is empty) will be pushed down.
		So make sure to remove it with your favourite text editor.
	}
	
var
	tstrlistAmmoFormIDs: TStringList;
	strTextFileName: string;

function Initialize: integer;
begin
	tstrlistAmmoFormIDs := TStringList.Create; // Create our TStringList
	tstrlistAmmoFormIDs.Sorted := true; // In order to prevent duplicates, we need to make it sort entries alphabetically
	tstrlistAmmoFormIDs.Duplicates := dupIgnore; // Stops duplicates from being added
	strTextFileName := 'Ammo Types.txt'; // We'll use this when saving the TStringList to a text file.
end;


function Process(e: IInterface): integer;
var
	strFullFormID: string;
begin
	
	if Signature(e) <> 'AMMO' then // If the selected record is not an AMMO record
		exit; // Don't process it
	
	
	{
		GetElementNativeValues returns the value of the low level data for an element.
		Since every "Flags" element is a set number of bytes (differes depending on the record type),
		we use GetElementNativeValues to see if a flag is present or not.
		
		Whereas if we used GetElementEditValues, we wouldn't be able to get the value of the flag
		as xEdit doesn't create an element for a flag, if it's set to 0. But using GetElementNativeValues, we can.
	}
	if GetElementNativeValues(e, 'DNAM - \Flags\Non-Playable') = '1' then // If the returned string is the same as 1 then 
		exit; // We don't want it, so quit processing the record damnit
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	
	strFullFormID := GetEditValue(ElementByPath(e, 'Record Header\FormID')); // Get the full FormID of the ammo record, and chuck it into a variable
	tstrlistAmmoFormIDs.Add(strFullFormID); // Add the full FormID string (that we chucked into a string variable) to the TStringList.

end;


function Finalize: integer; // Once everything is done
begin
	tstrlistAmmoFormIDs.SaveToFile(ProgramPath + 'Edit Scripts\FyTy\' + strTextFileName); // Save our TStringList to a text file
	tstrlistAmmoFormIDs.Free; // And dispose of our TStringList variable.
end;

end.