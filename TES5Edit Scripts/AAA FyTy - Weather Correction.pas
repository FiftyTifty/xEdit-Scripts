unit UserScript;
var
	eRFogDay, eGFogDay, eBFogDay, eDayFogDistanceFar, eDayFogPower: IInterface;
	RFogDay, GFogDay, BFogDay, FinRFogDay, FinGFogDay, FinBFogDay: integer;
	DefFogDist, DefDayFogPower, RFogDayDec, GFogDayDec, BFogDayDec, RGBCombDec: float;
	
function Process(e: IInterface): integer;
  begin

    if Signature(e) <> 'WTHR' then
      Exit;

    AddMessage('Processing: ' + FullPath(e));
	
	// Define path variables & convert default string values to floats or integers
	eRFogDay := ElementByPath(e, 'NAM0 - Weather Colors\Fog Far\Color #1 (Day)\Red');
	eGFogDay := ElementByPath(e, 'NAM0 - Weather Colors\Fog Far\Color #1 (Day)\Green');
	eBFogDay := ElementByPath(e, 'NAM0 - Weather Colors\Fog Far\Color #1 (Day)\Blue');
	
	{
	eDayFogDistanceFar := ElementByPath(e, 'FNAM - Fog Distance\Day - Far');
	DefFogDist := strtofloat(GetEditValue(eDayFogDistanceFar));
	
	eDayFogPower := ElementByPath(e, 'FNAM - Fog Distance\Day - Power');
	DefDayFogPower := strtofloat(GetEditValue(eDayFogPower));
	}
	
	//Get day fog RGB values, divide by 255, average the results
	RFogDay := strtoint(GetEditValue(eRFogDay));
	GFogDay := strtoint(GetEditValue(eGFogDay));
	BFogDay := strtoint(GetEditValue(eBFogDay));
	
	RFogDayDec := (RFogDay / 255);
	GFogDayDec := (GFogDay / 255);
	BFogDayDec := (BFogDay / 255);
	
	RGBCombDec := (RFogDayDec + GFogDayDec + BFogDayDec) / 3;
	// Got the decimal percentage!
	
	// Check the percentage of the day fog RGB values. If < 0.75, then * 1.15
	if RGBCombDec < 0.75 then begin
		FinRFogDay := (RFogDay * 1.10);
		FinGFogDay := (GFogDay * 1.10);
		FinBFogDay := (BFogDay * 1.15);
		
		SetEditValue(eRFogDay, inttostr(FinRFogDay));
		SetEditValue(eBFogDay, inttostr(FinBFogDay));
		SetEditValue(eGFogDay, inttostr(FinGFogDay));
	end;
	{
    if DefFogDist <= 350000 then begin
		SetEditValue(eDayFogDistanceFar, floattostr((DefFogDist * 1.5)));
	end;
	
	if DefDayFogPower <= 0.8 then begin
		SetEditValue(eDayFogPower, '1');
	end;
	}
  end;
end.
