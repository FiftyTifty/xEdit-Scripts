unit UserScript;

function Process(e: IInterface): integer;
var
  element: string;
  begin

    if Signature(e) <> 'NPC_' then
      Exit;

    AddMessage('Processing: ' + FullPath(e));

//    element := 'ACBS - Configuration\Flags\PC Level Mult';
//    ElementAssign(ElementByPath(e, element), HighInteger, nil, false);
    SetElementEditValues(e, 'ACBS\Flags', '10001101');
    SetElementEditValues(e, 'ACBS\Level Mult', '1');
    //SetElementEditValues(e, 'CNAM', 'CombatNightblade "Nightblade" [CLAS:0001317C]');
    //SetElementEditValues(e, 'ZNAM', 'csForswornBerserkerLow [CSTY:0010F546]');
    SetElementEditValues(e, 'ACBS - Configuration\Calc min level', '6');
    SetElementEditValues(e, 'ACBS - Configuration\Calc max level', '30');
    SetElementEditValues(e, 'AIDT - AI Data\Aggression', 'Aggressive');
    SetElementEditValues(e, 'AIDT - AI Data\Confidence', 'Foolhardy');
    SetElementEditValues(e, 'AIDT - AI Data\Assistance', 'Helps Allies');

  end;
end.
