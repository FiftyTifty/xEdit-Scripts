unit userscript;

{
	This is a relatively advanced script. Better off looking at one that has ~30 lines, if you've never looked at this stuff before.
	
	Anyhow, this script:
		Takes a text file containing the full FormIDs of the playable ammo records
		For each line in the text file
			
			Create a leveled list
			
				In each leveled list, add three entries
					Set the first entry to have a count of 5 (so five bullets)
					Set the second to have a count of 10 (ten bullets)
					Set the third to have a count of 15 (fifteen bullets)
				
			Append a three-digit number to the end of the leveled list's Editor ID
	
	Much better than doing it by hand in the Creation Kit, I tell ya.
}

var
	{
		Since this "var" block preceeds the script's Functions and Procedures, these become global variables.
		They aren't cleared after their parent function/procedure finishes.
	}
	fileDestination, eBaseList: IInterface;
	iTally, iPosFoundStr: integer;
	strEDID, strFind: string;
	tstrlistAmmo, tstrlistAmmoNames: TStringList;

function Initialize: integer;
begin
	
	fileDestination := FileByIndex(9); // My load order had all the DLC + the unofficial patch + my mod. The unofficial patch is the 8th file, so mine is the 9th.
	eBaseList := RecordByFormID(fileDestination, 134604557, false); // In my mod, there is a template leveled list, which we'll duplicate a bunch of times.
	
	tstrlistAmmo := TStringList.Create; // In order to reference the data in a text file, we first have to set up our TStringList variables.
	tstrlistAmmoNames := TStringList.Create;
	
	tstrlistAmmo.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Ammo Types.txt'); // Load the text file with the full ammo FormIDs.
	tstrlistAmmoNames.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\Ammo Types - Names.txt'); // Load another that has the names for the ammo.
	
	strEDID := GetEditValue(ElementBySignature(eBaseList, 'EDID')); // Get the Editor ID of the template leveled list.
	strFind := 'Temp'; // The template's Editor ID has the word "Temp", which I intentionally added in order to properly edit the duplicates' own Editor IDs.
	
	iTally := 0; // iTally will be increased by one for each leveled list created, and will be added to the end of each list's Editor ID.
	iPosFoundStr := Pos(strFind, strEDID); // We need to take note of where the string "Temp" is in the Editor ID, in order to replace it.
	
	ProcessTheAmmo(); // Call the procedure that will create the leveled lists.
	
end;


Procedure ProcessTheAmmo;
	{
		Since we want to create records, and have no need for any existing ones, I removed the default "Process" function.
		And in it's stead, I call ProcessTheAmmo() from that lovely Initialize function; the one called at the beginning of every script.
	}
var // These are "local" variables. These are cleared once the parent Procedure/Function finishes.
	eCurrentList, eCurrentEntries, eCurrentEntry: IInterface;
	
	iCounter, iSubCounter: integer;
	strAmmoFullFormID, strReplace, strSuffix, strNewEDID: string;
begin
	
  AddMessage('Processing: ' + FullPath(eBaseList));
	
	{
		Since Pascal starts counting stuff at 0, but getting the amount of something in a variable returns 0 if nothing is there, we subtract
		1 from it, as the loop starts from 0, not 1.
		
		If we started from 1 (iCounter := 1), then we would miss the first entry in the text file, which is at index 0.
		
		It's a bit of a pain to alternate between the two counting systems when you're new, but once you get the hang of coding,
		it makes much more sense. Don't worry if it seems confusing this early on in your adventure.
	}
	
	for iCounter := 0 to tstrlistAmmo.Count - 1 do begin 
	
		inc(iTally); // Inc() without a number specified (e.g, Inc(iTally, 3)), will increase the iTally variable by one.
		
		strReplace := tstrlistAmmoNames[iCounter]; // Get the name of the ammo from the list, which we'll chuck into the Editor ID.
	
		eCurrentList := wbCopyElementToFile(eBaseList, fileDestination, true, true); // Create a duplicate of the template list
		// And assign it to the eCurrentList variable.
		
		eCurrentEntries := Add(eCurrentList, 'Leveled List Entries', false); // The template list doesn't have the Leveled List Entries tree
		//So we add it to our duplicates. Note that a created element tree will create a null (has useless data) child entry.
		
		eCurrentEntry := ElementByIndex(eCurrentEntries, 0); // We'll modify the auto-created entry 
		SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Reference', tstrlistAmmo[iCounter]); // Get the full ammo FormID from our first text file
		SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Level', 1);
		SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Count', 5); // Since it's the first entry, set it to return five bullets.
		
		for iSubCounter := 2 to 3 do begin { Since we already modified the first entry, we only need to create two more.
			 We will use iSubCounter as a multiplier, which is why we're not using (iSubCounter := 0), and since we already have the initial
			 entry, we'll create the second and third entries.
			 
			 And we will use iSubCounter as a multiplier for the number of bullets.
			 }
			
			eCurrentEntry := ElementAssign(eCurrentEntries, HighInteger, nil, false);
			SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Reference', tstrlistAmmo[iCounter]);
			SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Level', 1);
			SetElementEditValues(eCurrentEntry, 'LVLO - Base Data\Count', 5 * iSubCounter);
			
			{	Amazing, right? If it's the second entry (first run of the loop), iSubCounter will have a value of 2.
				If it's the third entry (second run of the loop, which is also the last), iSubCounter will have a value of 3.
				
				5 * 2 = 10 bullets
				5 * 3 = 15 bullets
				
				Et voila!
			}
			
		end;
		
		strNewEDID := strEDID; // The Delete() and Insert() functions modify the given string directly, so we'll create our
		// new Editor ID variable sooner rather than later.
		
		Delete(strNewEDID, iPosFoundStr, Length(strFind)); // In strNewEDID, at the position in the Editor ID where "Temp" is,
		//	delete the number of characters in "Temp" (which is 4).
		
		Insert(strReplace + '_' + Format('%0.3d',[iTally]), strNewEDID, iPosFoundStr);
		//And then we'll insert: The name of the ammo + an underscore + a three digit integer, Into the new Editor ID string, where "Temp" used to be.
		
		SetEditValue(ElementBySignature(eCurrentList, 'EDID'), strNewEDID); // Now we change the new leveled list's Editor ID to our modified one.
	end;

end;


function Finalize: integer; // When present in a script, this function will always be run at the end.
begin
	
	tstrlistAmmo.Free; // Gotta clean up our TStringList variables.
	tstrlistAmmoNames.Free;
	
end;

end.
