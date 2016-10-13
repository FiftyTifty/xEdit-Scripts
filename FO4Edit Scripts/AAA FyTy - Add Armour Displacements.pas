unit userscript;

{
	
	This script is extremely simple, and was the first one I made for FO4Edit.
	
	What it does, is it takes the armour displacement data (changes the physical size of armour, based upon the scaling data)
	from the Road Leathers outfit, which we then apply on to the selected outfits.
	
	This was intended to be used on the Greaser Jacket outfit, but there was still some clipping since the Road leathers
	outfit is smaller than the Greaser Jacket.
	
}

var
	{
		Since this "var" block isn't parented by a function or a procedure, they will stay at whatever value they are set in the script.
		Unlike "local" variables, which are cleared when their parent function/procedure reaches it's "end;" statement.
	}
	eRoadLeathers, eArmourOffsets: IInterface;
	Fallout4File: IInterface;

function Initialize: integer; // This function, if present, is always called once, at the beginning of a script.
begin
	Fallout4File := FileByIndex(0); // Fallout4.esm is always loaded first, so it's always the first in the load order.
	
	eRoadLeathers := RecordByFormID(Fallout4File, 717025, true); // To find the integer FormID of a record, use my "Show FormID.pas" script
	eArmourOffsets := ElementByPath(eRoadLeathers, 'Bone Data'); // We store the "Bone Data" element into a variable. Easy to copy-paste this way.
end;


function Process(e: IInterface): integer;
	{	The variable "e" is the record we selected in FO4Edit.
		If we have selected more than one record in FO4Edit, the "Process" function will be run on each one.
	}
begin

	if Signature(e) <> 'ARMA' then // ARMA = Signature of an "Armor Addon" record.
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
  AddElement(e, eArmourOffsets); // Since we already got the bone data we want to copy, we just need to paste it over.

end;

end. // End of the script.