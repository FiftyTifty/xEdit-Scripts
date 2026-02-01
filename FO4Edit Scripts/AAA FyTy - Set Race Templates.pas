unit userscript;
uses 'AAA FyTy - Aux Functions';

var
	strStatsPath, strViciousDogRace, strRaiderDogRace, strDogmeatRace: string;
	
	strDogTemplate: string;
	

function Initialize: integer;
begin
	
	strStatsPath := 'ACBS - Configuration\Use Template Actors\Stats';
	
  strViciousDogRace := 'ViciousDogRace [RACE:0003578A]';
	strRaiderDogRace := 'RaiderDogRace [RACE:00187AF9]';
	strDogmeatRace := 'DogmeatRace [RACE:0001D698]';
	
	strDogTemplate := 'AAAFyTy_NPCTemplate_DogStats "Alpha Glowing Mongrel" [NPC_:070AB4F4]';
	
end;

procedure SetStatsTemplate(e: IInterface; strTemplate: string);
var
	eACBS, eTemplateContainer, eTPLT: IInterface;
	strFlag: string;
begin
	
	eACBS := ElementBySignature(e, 'ACBS');
	
	
	SetFlag(ElementByPath(e, 'ACBS - Configuration\Use Template Actors'), 'Stats', true);
	
	if not ElementExists(e, 'TPLT') then begin
		eTPLT := Add(e, 'TPLT', false);
		SetEditValue(eTPLT, strTemplate);
	end;
	
	if not ElementExists(e, 'TPTA') then
		Add(e, 'TPTA', false);
	
	eTemplateContainer := ElementBySignature(e, 'TPTA');
	
	if not ElementExists(eTemplateContainer, 'Stats') then
		Add(eTemplateContainer, 'Stats', false);
	
	SetElementEditValues(e, 'TPTA - Template Actors\Stats', strTemplate);
	
end;

function GetRace(e: IInterface): string;
begin
	
	Result := GetElementEditValues(e, 'RNAM - Race');
	
end;


function Process(e: IInterface): integer;
var
	strRace: string;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strRace := GetRace(e);
	
	if (strRace = strRaiderDogRace) or (strRace = strViciousDogRace) or (strRace = strDogmeatRace) then
		SetStatsTemplate(e, strDogTemplate);
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.