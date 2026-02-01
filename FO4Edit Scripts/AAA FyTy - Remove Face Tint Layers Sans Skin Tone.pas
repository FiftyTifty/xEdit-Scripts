unit userscript;
uses 'AAA FyTy - Aux Functions';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eFaceTLayers, eCurrentLayer, eTCIndex: IInterface;
	iCounter: integer;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eFaceTLayers := ElementByPath(e, 'Face Tinting Layers');
	
	for iCounter := ElementCount(eFaceTLayers) - 1 downto 0 do begin
		
		eCurrentLayer := ElementByIndex(eFaceTLayers, iCounter);
		
		if pos('Skin tone', GetElementEditValues(eCurrentLayer, 'TETI - Index\Index')) = 0 then
			RemoveElement(eFaceTLayers, eCurrentLayer);
		
	end;
	
	SetFlag(ElementByPath(e, 'ACBS - Configuration\Flags'), 'Is CharGen Face Preset', false);

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.