unit UserScript;

function Process(e: IInterface): integer;
var
  element: string;
  eAdd, eAssign1, eIndex1, eIndex2: IInterface;
  begin

    if Signature(e) <> 'NPC_' then
      Exit;

    AddMessage('Processing: ' + FullPath(e));

    eAdd := Add(e, 'Factions', false);
    eAssign1 := ElementAssign(eAdd, HighInteger, nil, false);
    eIndex1 := ElementByIndex(eAdd, 0);
    eIndex2 := ElementByIndex(eAdd, 1);
    SetElementEditValues(eIndex1, 'Faction', 'PotentialFollowerFaction [FACT:0005C84D]');
    SetElementEditValues(eIndex2, 'Faction', 'PotentialMarriageFaction [FACT:00019809]');

  end;
end.
