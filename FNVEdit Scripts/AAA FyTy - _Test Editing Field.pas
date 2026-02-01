unit userscript;

function Initialize: integer;
begin
  
end;

function Process(e: IInterface): integer;
var
	eEffect, eEffectSecond: IInterface;
begin

	if Signature(e) <> 'IMAD' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eEffect := ElementBySignature(ElementByPath(e, 'HDR'), 'cIAD');
	
	eEffectSecond := ElementBySignature(ElementByPath(e, 'HDR'), 'CIAD');
	
	AddMessage(
		'cIAD: ' + GetElementEditValues(ElementByIndex(eEffect, 0), 'Value')
	);
	
	AddMessage(
		'cIAD Full Path: ' + GetElementEditValues(ElementByIndex(ElementByPath(e, 'HDR\cIAD - Bloom Threshold Mult'), 0), 'Value')
	);
	
	AddMessage(
		'CIAD: ' + GetElementEditValues(ElementByIndex(eEffectSecond, 0), 'Value')
	);
	
	//AddMessage(Name(eEffect));
	{
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Time', '0.000000');
	SetElementEditValues(ElementByIndex(eEffect, 0), 'Value', '0.000000');
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Time', '1.000000');
	SetElementEditValues(ElementByIndex(eEffect, 1), 'Value', '0.000000');
	}

end;


function Finalize: integer;
begin
	
end;

end.