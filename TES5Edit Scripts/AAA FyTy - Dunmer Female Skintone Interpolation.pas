unit userscript;

var
DunmerFemaleSkinTone, DunmerFemaleTintLayers: IInterface;
i: integer;

SkinColourArray: Array[1..3] of integer;
RandRGB: Array[1..3] of integer;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'NPC_' then
		exit;

  AddMessage('Processing: ' + FullPath(e));
	
	DunmerFemaleTintLayers := ElementByPath(e, 'Tint Layers');
	
	for i := 0 to ElementCount(DunmerFemaleTintLayers) do begin
		if GetEditValue(ElementByPath(ElementByIndex(DunmerFemaleTintLayers, i), 'TINI - Tint Index')) = '24' then
			DunmerFemaleSkinTone := ElementByIndex(DunmerFemaleTintLayers, i);
	end;
	
	SetElementEditValues(DunmerFemaleSkinTone, 'TINV - Interpolation Value', '1.0');
	
end;

function Finalize: integer;
begin

	AddMessage('Done!');
	
end;

end.