unit userscript;

var
	fileDestination: IInterface;
	strEditorIDPrefix: string;
	
function Initialize: integer;
begin
	
	fileDestination := FileByIndex(9); // Fallout 4 + DLC + Unofficial Patch | Unoff. Is the 8th file. File indexes start counting @ 1
	
	strEditorIDPrefix := 'AAAFyTy_Preset_'
	
end;


function RemoveUnneededElements(ePreset: IInterface): IInterface;
begin
	
	if ElementExists(ePreset, 'VMAD - Virtual Machine Adapter') then
		Remove(ElementBySignature(ePreset, 'VMAD'));
	
	if ElementExists(ePreset, 'Factions') then
		Remove(ElementByPath(ePreset, 'Factions'));
	
	if ElementExists(ePreset, 'VTCK - Voice') then
		Remove(ElementBySignature(ePreset, 'VTCK'));
	
	if ElementExists(ePreset, 'Actor Effects') then
		Remove(ElementByPath(ePreset, 'Actor Effects'));
	
	if ElementExists(ePreset, 'Perks') then
		Remove(ElementByPath(ePreset, 'Perks'));
	
	if ElementExists(ePreset, 'Packages') then
		Remove(ElementByPath(ePreset, 'Packages'));
	
	Result := ePreset;
	
end;


function Process(e: IInterface): integer;
var
	ePreset, eFlags: IInterface;
	strEDID, strFlags: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	if GetEditValue(ElementBySignature(e, 'RNAM')) <> 'HumanRace "Human" [RACE:00013746]' then
		exit;
	
	
	eFlags := ElementByPath(e, 'ACBS - Configuration\Flags');
	strFlags := GetEditValue(eFlags);
	//AddMessage('The flags are: '+strFlags);
	
	if Length(strFlags) < 6 then
		exit;
	
	if strFlags[6] <> '1' then // 6th flag is the "Unique" flag
		exit;
	
	//AddMessage('Processing: ' + FullPath(e));
	
	ePreset := wbCopyElementToFile(e, fileDestination, true, true);
	
	ePreset := RemoveUnneededElements(ePreset);
	
	strEDID := GetEditValue(ElementBySignature(ePreset, 'EDID'));
	strEDID := strEditorIDPrefix + strEDID;
	SetElementEditValues(ePreset, 'EDID - Editor ID', strEDID);
	
	Delete(strFlags, 3, 1);
	Insert (StrFlags, '1', 3);
	//AddMessage('The new flags are: '+strFlags);
	
	setElementEditValues(ePreset, 'ACBS Configuration\Flags', strFlags)

end;