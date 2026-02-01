unit userscript;


function Process(e: IInterface): integer;
var
	eFlags: IInterface;
	iFlagsLength: integer;
	strFlags: string;
	bBreakFlagsLoop: boolean;
begin
	
	if Signature(e) <> 'LVLI' then
		exit;
	
	eFlags := ElementBySignature(e, 'LVLF');
	
	SetEditValue(eFlags, '11');

end;

end.
