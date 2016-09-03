unit userscript;

var
	ChDollHead: string;
	
	PatchFile : IInterface;
	
	function Initialize: integer; // This section is run once; when the script is applied. It does not run on every selected record.
begin

	//PatchFile := AddNewFile; // Uncomment to create a new file, and allow us to reference it through the "PatchFile" variable. "AddFile" also gives a prompt to name the new file.
	PatchFile := FileByIndex(22);	// You can also reference an already-made file by changing it to: Patchfile := FileByIndex(#);
													//With # being the index of your mod.You'll have to change the index depending on how many other mods there are preceeding it.

	
	ChDollHead := 'DLC04DollHead [MSTT:0A00CB4F]'; // Example string. You can add more, just be sure to define them in the above var settings.
	
end;

var
	RecordCopy: IInterface;
	CheckString1: string;

function Process(e: IInterface): integer; // This runs on every record we selected.
begin
  if Signature(e) <> 'REFR' or 'ACHR' then // If it's not a REFR or ACHR (reference; placed record in a cell), stop the script.
		exit;	
		
	CheckString1 := GetEditValue(ElementBySignature(e, 'NAME'));

	//Example to copy specific object reference. Used {} to comment it out.
	{
	if (GetEditValue(ElementBySignature(e, 'NAME')) = ChDollHead) then begin // Check if the reference's base object is "DLC04DollHead [MSTT:0A00CB4F]"
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true); // Copy record to the patch file, don't copy it as a new record, include reference data (positioning, attached scripts, name of reference, etc.)
		SetIsPersistent(RecordCopy, true); // Set the copied record as persistent
	end;
	}
	
	if AnsiContainsStr(CheckString1, '[NPC_:') = true then begin //Check if CheckString1 has '[NPC_:' somewhere in it. If so, do the following loop:
		{
		RecordCopy := wbCopyElementToFile(e, PatchFile, false, true); // Copy the reference record to the patch file.
		SetIsPersistent (RecordCopy, true); // Make it persistent
		}
		// Only have the above or below lines uncommented; not both.
		{
		SetIsPersistent(e, true); // Sets the NPC ref to persistent
		}
	end; // End the loop
	
	
end;

end.