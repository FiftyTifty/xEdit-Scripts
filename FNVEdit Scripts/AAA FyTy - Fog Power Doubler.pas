
unit userscript;

var
	DayPower: IInterface;
	DayPowerS: string;
	DayPowerFloat: float;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'WTHR' then
		exit;
		
	DayPower := ElementByPath(e, 'FNAM\Day - Near');
	DayPowerFloat := StrToFloat(GetEditValue(DayPower));
	
  if StrToFloat(GetEditValue(DayPower)) < 3000.000000 then begin
		SetEditValue(DayPower, '3000');
	end;

end;


end.
