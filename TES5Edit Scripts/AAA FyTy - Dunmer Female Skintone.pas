unit userscript;

var
DunmerFemaleSkinTone, DunmerFemaleTintLayers: IInterface;
i, i2, RandSkinChange, RandDivide, RandDivide2: integer;
DoSkinColouring, DoChangeSkinTone, PlentyOfBlue: Boolean;

SkinColourArray: Array[1..3] of integer;
RandRGB: Array[1..3] of integer;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	i2 := 0;
	
	DunmerFemaleTintLayers := ElementByPath(e, 'Tint Layers');
	
	randomize();
	RandSkinChange := Random(9) + 1;
	randomize();
	RandRGB[1] := Random(29) + 1;
	randomize();
	RandRGB[2] := Random(29) + 1;
	randomize();
	RandRGB[3] := Random(29) + 1;
	randomize();
	RandDivide := Random(2) + 1;
	randomize();
	RandDivide2 := Random(2) + 1;
	
	for i := 0 to ElementCount(DunmerFemaleTintLayers) do begin
		if GetEditValue(ElementByPath(ElementByIndex(DunmerFemaleTintLayers, i), 'TINI - Tint Index')) = '24' then
			DunmerFemaleSkinTone := ElementByIndex(DunmerFemaleTintLayers, i);
	end;
	
	if RandSkinChange <= 4 then begin
		AddMessage('We will not change the skintone');
		exit;
	end;
	
	if RandSkinChange > 4 then begin
		AddMessage('We will change the skin');
		
		SkinColourArray[1] := strtoint(GetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Red')));
		SkinColourArray[2] := strtoint(GetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Green')));
		SkinColourArray[3] := strtoint(GetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Blue')));
		DoSkinColouring := True;
	end;
	
	if DoSkinColouring = True then begin
		AddMessage('Colouring in the skin');
		
		if SkinColourArray[1] > 110 then
			SkinColourArray[1] := (SkinColourArray[1] - RandRGB[1]) div RandDivide;
			
		if (SkinColourArray[2] - SkinColourArray[3]) > 15 then
			SkinColourArray[2] := (SkinColourArray[2] - RandRGB[2]) div RandDivide2;
			
		if SkinColourArray[3] < 115 then
			Repeat
			SkinColourArray[3] := SkinColourArray[3] + RandRGB[3];
			i2 := i2 + 1;
			AddMessage('Added blue '+inttostr(i2)+' times');
			if SkinColourArray[3] > 120 then
				PlentyOfBlue := True;
			until PlentyofBlue = True;
			
		DoChangeSkinTone := True;
	end;
	
	if DoChangeSkinTone = True then begin
		AddMessage('Now we paint the lass');
		
		SetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Red'), IntToStr(SkinColourArray[1]));
		SetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Green'), IntToStr(SkinColourArray[2]));
		SetEditValue(ElementByPath(DunmerFemaleSkinTone, 'TINC - Tint Color\Blue'), IntToStr(SkinColourArray[3]));
	end;
	
end;

function Finalize: integer;
begin

	AddMessage('Done!');
	
end;

end.