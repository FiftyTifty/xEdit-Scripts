unit userscript;
var
  ElementPath: IInterface;
  // IInterface is the variable used for referencing stuff to do with the files.
  // A record or an element (a piece of data that makes up a record) would use this variable.
  CustomSpeedValue: string;
  // The values in a record are stored in strings; even if the value consists of numbers.
  
  
function Initialize: integer;
// We run this section once, before the script actually edits the selected records.
// It's best to set static variables (I.E, things that don't change, such as the speed we want the selected NPCs to move at) here.
begin
	CustomSpeedValue := '100'
	// Change this to how fast you want the NPCs to move. 100 is the default speed.
end;

function Process(e: IInterface): integer;
// This is what will be run on the selected records; this is where you put the modifications you want made.
begin
  if Signature(e) <> 'NPC_' then
  // Make sure we're only running the script on actor records.
	exit;

//  AddMessage('Processing: ' + FullPath(e));
  
  ElementPath := ElementByPath(e, 'ACBS - Configuration\Speed Multiplier');
  // In an NPC_ record (e.g, Skyrim.esm -> Non-Player Character (Actor) -> Ahtar), that's the path to the "Speed Multiplier" value.
  SetEditValue(ElementPath, CustomSpeedValue);
  // Now we set each actor's speed to the value we set at the beginning
end;

end.
