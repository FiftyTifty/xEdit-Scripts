unit userscript;

var
	iRand01, iRand02, iRand03: integer;
	ePath, pSunrise, pNoon, pDay, pSunset, pNight, pMidnight: IInterface;
	

procedure GetPaths;
begin

	pSunrise := ElementByPath(ePath, 'Time #0 (Sunrise)');
	pDay := ElementByPath(ePath, 'Time #1 (Day)');
	pSunset := ElementByPath(ePath, 'Time #2 (Sunset)');
	pNight := ElementByPath(ePath, 'Time #3 (Night)');
	pNoon := ElementByPath(ePath, 'Time #4 (High Noon)');
	pMidnight := ElementByPath(ePath, 'Time #5 (Midnight)');
	
end;

procedure RandomRGB(iR: integer);
begin
	Randomize;
	iRand01 := (Random(20) - 10);
	iRand01 := iR + iRand01;
	Randomize;
	iRand02 := (Random(20) - 10);
	iRand02 := iR + iRand02;
	Randomize;
	iRand03 := (Random(20) - 10);
	iRand03 := iR + iRand03;
end;


function Initialize: integer;
begin
end;


function Process(e: IInterface): integer;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	ePath := ElementByPath(ElementBySignature(e, 'NAM0'), 'Type #3 (Ambient)');
	GetPaths;
	
	
	//Sunrise
	RandomRGB(96);
	SetEditValue(ElementByPath(pSunrise, 'Red'), IntToStr(iRand01));
	SetEditValue(ElementByPath(pSunrise, 'Green'), IntToStr(iRand02));
	SetEditValue(ElementByPath(pSunrise, 'Blue'), IntToStr(iRand03));
	
	
	//Day & Noon
	RandomRGB(150);
	SetEditValue(ElementByPath(pDay, 'Red'), IntToStr(iRand01));
	SetEditValue(ElementByPath(pDay, 'Green'), IntToStr(iRand02));
	SetEditValue(ElementByPath(pDay, 'Blue'), IntToStr(iRand03));
	
	SetEditValue(ElementByPath(pNoon, 'Red'), IntToStr(iRand01));
	SetEditValue(ElementByPath(pNoon, 'Green'), IntToStr(iRand02));
	SetEditValue(ElementByPath(pNoon, 'Blue'), IntToStr(iRand03));
	
	
	//Sunset
	RandomRGB(128);
	SetEditValue(ElementByPath(pSunset, 'Red'), IntToStr(iRand01));
	SetEditValue(ElementByPath(pSunset, 'Green'), IntToStr(iRand02));
	SetEditValue(ElementByPath(pSunset, 'Blue'), IntToStr(iRand03));
	
	
	//Night & Midnight
	SetEditValue(ElementByPath(pNight, 'Red'), '16');
	SetEditValue(ElementByPath(pNight, 'Green'), '16');
	SetEditValue(ElementByPath(pNight, 'Blue'), '16');
	
	SetEditValue(ElementByPath(pMidnight, 'Red'), '16');
	SetEditValue(ElementByPath(pMidnight, 'Green'), '16');
	SetEditValue(ElementByPath(pMidnight, 'Blue'), '16');
	
end;


function Finalize: integer;
begin

end;

end.