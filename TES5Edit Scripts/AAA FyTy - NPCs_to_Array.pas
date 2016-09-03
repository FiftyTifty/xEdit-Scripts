{
  1. select NPC records and use a process function
  2. skip NPC record if race/gender doesn't match certain strings
  3. if NPC record good, add its formID to stringlist
  4. put the NPCs in the array
}

unit UserScript;

// these are global variables that can be set/used throughout the script
var
  slNPCs, slRaces, slRecords: TStringList;
  genderpref: string;

function Initialize: integer;
var
  s: string;
begin
  AddMessage('---------------------------------------------------');
  AddMessage('FyTy''s NPCs to Array script.');
  AddMessage('---------------------------------------------------');

  // initialize the NPC list, this'll end up being a list of the NPC record formIDs
  slNPCs := TStringList.Create;
  slRaces := TStringList.Create;
  slRecords := TStringList.Create;
  
  // allow user to set a gender preference
  // this is done with the InputBox function which takes 3 strings and uses them to create an input box for the user to type some input
  // the first string is the title of the box
  // the second string is the description in the box
  // the third string is the default value of the text field in the box
  genderpref := InputBox('Gender preference','If you would like the script to specifically select NPCs of a specific gender, enter it below.  Valid inputs: Male, Female, or leave the field empty','');
  
  // allow user to set races they want to specifically use
  // this is done by using a looping infobox that stops looping when the infobox is left blank (that's when SameText(s, '') returns true)
  // because of this we have to start s with a non-nil value, else the loop will never start.
  s := '0';
  While not SameText(s, '') do begin
    s := InputBox('Valid races','If you want to only select NPCs of specific races, enter the race Editor IDs below (one at a time), else leave the field blank.','');
    // If s was not left blank, add it to the slRaces stringlist
    if not SameText(s, '') then slRaces.Add(s);
  end;
  
  AddMessage(#13#10+'Processing selected objects...');
end;
  
function Process(e: IInterface): integer;
var
  race, gender: string;
begin
  // skip record if it's not an NPC record.
  if Signature(e) <> 'NPC_' then
    exit;
  
  // get the editor ID of the NPC's race.
  // this is done by using LinksTo to get to the race record.  any formID reference in TES5Edit can be followed using LinksTo
  race := GetElementEditValues(LinksTo(ElementByPath(e, 'RNAM')), 'EDID');
  // get npc's gender (returns 1 if npc is female, is left unassigned if NPC is male)
  gender := GetElementEditValues(e, 'ACBS\Flags\Female');
  
  // if npc is male, gender is unassigned, so set it to '0'
  if not Assigned(gender) then gender := '0';
  
  // check if genderpreference is set, if it is we'll check if the processed NPC matches the user's gender preference
  // if it doesn't match the user's gender preference, we'll go to processing the next NPC via "exit"
  if Assigned(genderpref) then begin
    if SameText(Lowercase(genderpref), 'male') and SameText(gender, '1') then exit;
    if SameText(Lowercase(genderpref), 'female') and SameText(gender, '0') then exit;
  end;
  
  // check if user has specified race preferences.  if they haven't we'll just proceed to add the NPC record's formID
  // to the slNPCs list.  if they have we'll see if the race of the NPC we're processing matches ones of the races in slRaces.
  if slRaces.Count > 0 then begin
    // this checks if slRaces has an item matching the string "race".  if it doesn't slRaces.IndexOf(race) will return -1.
    if slRaces.IndexOf(race) = -1 then exit;
  end;
  
  // if all checks pass, add the NPC to the stringlist.
  slNPCs.AddObject(GetElementEditValues(e, 'EDID'), TObject(FormID(e)));
  AddMessage('  Added NPC '+slNPCs[slNPCs.Count - 1]);
end;

function Finalize: integer;
var
  cfile, crecord, path, subpath, subpath2: string;
  i, j: integer;
  f, rfile, element, listarraything, rrecord: IInterface;
begin
  AddMessage('');
  // we're going to have the user specify the file that has the record they want to add the NPCs to.
  While not Assigned(rfile) do begin
    cfile := InputBox('Choose file','Enter the name of the file holding the record you want to add the NPCs to.','AAA_FyTy_NPCs.esp');
    for i := 0 to FileCount - 1 do begin
      f := FileByIndex(i);
      if SameText(GetFileName(f), cfile) then rfile := f;
    end;
    if not Assigned(rfile) then AddMessage('  !Script couldn''t find the file "'+cfile+'", try again (make sure you include the file extension!)');
  end;
  AddMessage('Script is using file: '+cfile);
  
  // now we're going to load all of the editorIDs of the records in this file into a stringlist.  god forbid the user
  // chooses a file with more than 5000 records... (LONG TIME!)
  // zilav recently developed something to process all edids at the start of script execution, but I'm too lazy to learn how to use it.
  AddMessage('  Processing records in file...');
  for i := 0 to RecordCount(rfile) - 1 do begin
    element := RecordByIndex(rfile, i);
    slRecords.AddObject(GetElementEditValues(element, 'EDID'), i);
  end;
  
  // now we're going to have the user specify the editorID of the record they want to add the NPCs to.
  While not Assigned(rrecord) do begin
    crecord := InputBox('Choose record','Enter the editor ID of the record you want to add the NPCs to.','AAA_FyTy_QuestTemp');
    j := slRecords.IndexOf(crecord);
    if j > -1 then rrecord := RecordByIndex(rfile, Integer(slRecords.Objects[i]))
    else AddMessage('  !Script couldn''t find the record '+crecord);
  end;
  AddMessage('  Script is using record: '+GetElementEditValues(rrecord, 'EDID')+#13#10);
  
  // now the user will specify the path they want the NPCs to be added to... >_>  lots of inputs.
  path := InputBox('Enter path','Enter the path to the list of elements you want to add the NPCs to.','VMAD\Data\Quest VMAD\Scripts\Script\Properties\Property\Value\Array of Object');
  subpath := InputBox('Enter subpath','Enter the subpath within a new list object you want to apply the NPCs formID to...','Object v2\FormID');
  subpath2 := InputBox('Enter 2nd subpath','Enter the subpath within a new list object you want to apply the NPCs formID to...','Object v2\Alias');
  
  // now we'll finally do it.
  // Yay!
  AddMessage('Using path "'+path+'" on record "'+crecord);
  listarraything := ElementByPath(rrecord, path);
  for i := 0 to slNPCs.Count - 1 do begin
    AddMessage('    Adding NPC: '+slNPCs[i]);
    element := ElementAssign(listarraything, HighInteger, nil, False);
    SetElementNativeValues(element, subpath, slNPCs.Objects[i]);
    SetElementNativeValues(element, subpath2, '-1');
  end;
  
  
  // and now we'll clean up the mess...
  // and go back and put some addmessages...
  slNPCs.Free;
  slRecords.Free;
  slRaces.Free;
  
end;

end.
