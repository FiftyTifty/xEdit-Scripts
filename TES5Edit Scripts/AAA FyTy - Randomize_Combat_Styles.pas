unit userscript;

var
  RandNumber: Integer;
  eCElement, eZElement: IInterface;

// Called before processing
// You can remove it if script doesn't require initialization code
function Initialize: integer;
begin
  randomize();
end;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
    Exit;

  // comment this out if you don't want those messages
//  AddMessage('Processing: ' + FullPath(e));
  eCElement := ElementByPath(e, 'CNAM'); // Class
  eZElement := ElementByPath(e, 'ZNAM'); //Combat Style
  RandNumber := random(10) + 1;
//  AddMessage(''+IntToStr(RandNumber)+''); << It worksies!
  if RandNumber = 1 then begin
    SetEditValue(eZElement, 'csForswornBerserker [CSTY:000442CE]');
    SetEditValue(ECElement, 'CombatAssassin "Assassin" [CLAS:0001317F]');
  end;
  if RandNumber = 2 then begin
    SetEditValue(eZElement, 'csHumanBoss2H [CSTY:0003DECF]');
    SetEditValue(ECElement, 'CombatBarbarian "Barbarian" [CLAS:0001CE16]');
  end;
  if RandNumber = 3 then begin
    SetEditValue(eZElement, 'csWEBerserker [CSTY:00105546]');
    SetEditValue(ECElement, 'CombatWarrior1H "Warrior" [CLAS:00013176]');
  end;
  if RandNumber = 4 then begin
    SetEditValue(eZElement, 'csWECompanion [CSTY:00103508]');
    SetEditValue(ECElement, 'CombatWarrior2H "Warrior" [CLAS:0001CE15]');
  end;
  if RandNumber = 5 then begin
    SetEditValue(eZElement, 'csWESpellsword [CSTY:001034FD]');
    SetEditValue(ECElement, 'CombatSpellsword "Spellsword" [CLAS:00013177]');
  end;
  if RandNumber = 6 then begin
    SetEditValue(eZElement, 'csForswornMagic [CSTY:000442CD]');
    SetEditValue(ECElement, 'CombatWitchblade "Witchblade" [CLAS:00013178]');
  end;
  if RandNumber = 7 then begin
    SetEditValue(eZElement, 'csHumanMissile [CSTY:0003BE1D]');
    SetEditValue(ECElement, 'CombatRanger "Ranger" [CLAS:00013181]');
  end;
  if RandNumber = 8 then begin
    SetEditValue(eZElement, 'csHumanTankLvl1 [CSTY:0003CF5A]');
    SetEditValue(ECElement, 'CombatWarrior1H "Warrior" [CLAS:00013176]');
  end;
  if RandNumber = 9 then begin
    SetEditValue(eZElement, 'csThalmorMeleeDual [CSTY:000F960C]');
    SetEditValue(ECElement, 'EncClassThalmorMelee "Thalmor Warrior" [CLAS:0007289D]');
  end;
  if RandNumber = 10 then begin
    SetEditValue(eZElement, 'csWEBattlemage [CSTY:001034F0]');
    SetEditValue(ECElement, 'TrainerDestructionMaster "Sorcerer" [CLAS:000E3A73]');
  end;


end;

// Called after processing
// You can remove it if script doesn't require finalization code
{function Finalize: integer;
begin
  Result := 0;
end;}

end.