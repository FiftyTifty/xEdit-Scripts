unit userscript;
var
	tstrlistTiers, tstrlistValues: TStringList;

function Initialize: integer;
begin
  
	tstrlistTiers := TStringList.Create;
	tstrlistValues := TStringList.Create;
	
	tstrlistTiers.Add('_Standard');
	tstrlistValues.Add('0.15');
	
	tstrlistTiers.Add('_MoreDamage1');
	tstrlistValues.Add('0.20');
	
	tstrlistTiers.Add('_MoreDamage2');
	tstrlistValues.Add('0.25');
	
	tstrlistTiers.Add('_MoreDamage3');
	tstrlistValues.Add('0.30');
	
	tstrlistTiers.Add('_Heavier');
	tstrlistValues.Add('0.35');
	
	tstrlistTiers.Add('_Long');
	tstrlistValues.Add('0.15');
	
end;

function GetOMODAttackDamage(e: IInterface): IInterface;
var
	eProperties, eProperty: IInterface;
	iCounter: Integer;
begin

	eProperties := ElementByPath(e, 'DATA - Data\Properties');
	
	for iCounter := 0 to ElementCount(eProperties) - 1 do begin
	
		eProperty := ElementByIndex(eProperties, iCounter);
		
		if GetElementEditValues(eProperty, 'Property') = 'AttackDamage' then
			if GetElementEditValues(eProperty, 'Function Type') = 'MUL+ADD' then begin
				
				Result := eProperty;
				exit;
				
			end;
			
	
	end;
	
	eProperty := ElementAssign(eProperties, HighInteger, nil, false);
	SetElementEditValues(eProperty, 'Value Type', 'Float');
	SetElementEditValues(eProperty, 'Function Type', 'MUL+ADD');
	SetElementEditValues(eProperty, 'Property', 'AttackDamage');
	
	Result := eProperty;

end;

procedure ModifyOMODDamage(e: IInterface);
var
	eProperty: IInterface;
	strEDID: string;
	iCounter: integer;
begin

	strEDID := GetElementEditValues(e, 'EDID - Editor ID');
	
	eProperty := GetOMODAttackDamage(e);
	
	for iCounter := 0 to tstrlistTiers.Count - 1 do begin
	
		if pos(tstrlistTiers[iCounter], strEDID) > 0 then begin
		
			SetElementEditValues(eProperty, 'Value 1 - Float', tstrlistValues[iCounter]);
		
		end;
	
	end;

end;

function Process(e: IInterface): integer;
begin
	
  if Signature(e) <> 'OMOD' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  ModifyOMODDamage(e);
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.