unit userscript;
const
	strListAntsPath = ScriptsPath + 'FyTy\Damage Overhaul\Ants.txt';
	strlistBarkScorpionsPath = ScriptsPath + 'FyTy\Damage Overhaul\BarkScorpions.txt';
	strHealthpath = 'DATA - \Health';
	eFile = FileByIndex(13);

var
	tstrlistAnts, tstrlistBarkScorpions: TStringList;

function Initialize: integer;
begin

  tstrlistAnts := TStringList.Create;
	tstrlistAnts.LoadFromFile(strListAntsPath);
	
	tstrlistBarkScorpions := TStringList.Create;
	tstrlistBarkScorpions.LoadFromFile(strlistBarkScorpionsPath);
	
end;

procedure ProcessTStrList(list: TStringList; fHealthIncrease: float);
var
	iCounter, iHealth: integer;
	eCreature: IInterface;
	
begin
	
	for iCounter := 0 to pred(list.Count) do begin
	
		eCreature := RecordByFormID(eFile, StrToInt(list[iCounter]), true);
		
		iHealth := StrToInt(GetElementEditValues(eCreature, strHealthPath));
		iHealth := Round(iHealth * fHealthIncrease);
		
		SetElementEditValues(eCreature, strHealthPath, IntToStr(iHealth));
		
	end;
	
end;


function Finalize: integer;
begin
	
	ProcessTStrList(tstrlistBarkScorpions, 3);
	
	tstrlistBarkScorpions.Free;
end;

end.