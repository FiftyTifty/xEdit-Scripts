unit userscript;

function Initialize: integer;
begin
  
	
	
end;


function Process(e: IInterface): integer;
var
	iCounter: Integer;
	eLayers, eLayer: IInterface;
begin
	
  if Signature(e) <> 'NPC_' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  if ElementExists(e, 'Face Tinting Layers') then begin
	
		eLayers := ElementByPath(e, 'Face Tinting Layers');
		
		for iCounter := ElementCount(eLayers) - 1 downto 0 do begin
		
			eLayer := ElementByIndex(eLayers, iCounter);
			
			if GetElementEditValues(eLayer, 'TETI - Index\Index') = '1651' then
				RemoveByIndex(eLayers, iCounter, true);
		
		end;
		
	end;
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.