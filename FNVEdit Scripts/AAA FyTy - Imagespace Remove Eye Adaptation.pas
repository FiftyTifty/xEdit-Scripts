unit userscript;

function Initialize: integer;
begin
  Result := 0;
end;

function Process(e: IInterface): integer;
begin

	if Signature(e) = 'IMGS' then begin
	
		AddMessage('Processing: ' + FullPath(e));
		
		SetElementEditValues(e, 'DNAM - DNAM\HDR\Target Lum', '1.0');
		SetElementEditValues(e, 'DNAM - DNAM\HDR\Upper Lum Clamp', '0.0');
		SetElementEditValues(e, 'DNAM - DNAM\HDR\Bright Scale', '1.0');
		SetElementEditValues(e, 'DNAM - DNAM\HDR\Bright Clamp', '1.0');
		
	end
	else if Signature(e) = 'IMAD' then begin
	
		AddMessage('Processing: ' + FullPath(e));
		
		SetElementEditValues(e, 'HDR\Bright Scale\FIAD\[0]\Value', '0.0');
		SetElementEditValues(e, 'HDR\Bright Scale\FIAD\[1]\Value', '0.0');
	
	end
	else
		exit;
	
  

end;

function Finalize: integer;
begin
  Result := 0;
end;

end.