unit fytyauxfunctions;

function ModifyRange(OldValue, OldMin, OldMax, NewMin, Newmax: integer): integer;
var
	NewValue, OldRange, NewRange: integer;
begin
	
	OldRange := OldMax - OldMin;
	NewRange := NewMax - NewMin;
	
	NewValue := Round((((OldValue - OldMin) * NewRange) / OldRange) + NewMin);
	
	Result := NewValue;
end;

end.