unit userscript;

	{
		When I was making my Raider Communications mod, that turns the "Federal Ration Stockpile" location into an exterior and an interior workshop,
		I really did not want to manually link NPCs to the workbench (turns them into settlers that are already living there).
		
		The solution? Script it! Just add the keyword Fallout 4 uses to attach an NPC to the workshop, and make sure it references my placed
		workbench.
	}

var
	strKeyword, strRef: string;
	
	{
		What makes scripts a nightmare to read, or fairly intuitive, are the variable names.
		If you've ever looked at example code from Wikipedia, or any programming language's documentation...It's very autistic.
		Good variable names will give you a good idea of what they're used for, just by looking at them; the type of variable, and the data it contains.
	}

function Initialize: integer; // This function, if present, is always called once, at the beginning of a script.
begin
	
	strKeyword := 'WorkshopItemKeyword [KYWD:00054BA6]';
	
	strRef := 'AAAFyTy_WorkshopWorkbenchInterior [REFR:070B83B8] (places WorkshopWorkbenchInterior "Workshop" [CONT:0012E2C4] in GRUP Cell Persistent Children of FederalRationStockpile01 "Federal Ration Stockpile" [CELL:00035FF4])';
	
end;


function Process(e: IInterface): integer;

	{	The variable "e" is the record we selected in FO4Edit.
		If we have selected more than one record in FO4Edit, the "Process" function will be run on each one.
	}
	
var
	eLinkedRefsContainer, eLinkedRef: IInterface;
	iCounter: integer; // Rather than using an integer called "i", I prefer iCounter for my loops. Much better, right?
	bExisted: boolean;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	if ElementExists(e, 'Linked References') = false then begin
		eLinkedRefsContainer := Add(e, 'Linked References', false); // When we add the "Linked References" tree, take note that it creates an empty linked ref inside it.
		bExisted := false; // There was no "Linked References" element to begin with, so let's keep that in mind
	end
	else
		bExisted := true; // The "Linked References" element already exists, so no need to add it.
		
	
	if bExisted then begin
		eLinkedRefsContainer := ElementByPath(e, 'Linked References');
		
		for iCounter := 0 to ElementCount(eLinkedRefsContainer) - 1 do begin
			if GetEditValue(ElementByPath(ElementByIndex(eLinkedRefsContainer, iCounter), 'Ref')) = strRef then // If we already linked the workshop
				exit; // No need to do anything, so let's stop working on this record, lest we fuck up.
		end;
		
	end;
	
	
	if bExisted = true then // If there already was a LinkedRefs tree in the record
		eLinkedRef := ElementAssign(eLinkedRefsContainer, HighInteger, nil, false) // We'll just add our element to the end of it.
	else // If there wasn't
		eLinkedRef := ElementByIndex(eLinkedRefsContainer, 0); // We'll modify the auto-created linked ref
	
	
	SetEditValue(ElementByPath(eLinkedRef, 'Keyword/Ref'), strKeyword); // Now we'll apply the keyword
	SetEditValue(ElementByPath(eLinkedRef, 'Ref'), strRef); // And point it to the workshop's workbench.

end;


end.