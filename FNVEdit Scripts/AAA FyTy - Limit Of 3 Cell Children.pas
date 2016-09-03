unit userscript;

var
	CellGroupTemp: IInterface;
	i, ChildCount, Tally, iNum: Integer;
	CanDelete: boolean;
function Initialize: integer;
begin
	CanDelete := false;
	Tally := 0;
end;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
 if Signature(e) <> 'CELL' then
	exit;

	CellGroupTemp := ElementByIndex(ChildGroup(e), 0); // Assign 'Temporary' record collection to Cell Group Temp (e.g Worldspace\Wasteland\Block\Sub-Block\Cell\Temporary)
	//AddMessage(IntToStr(ElementCount(ElementByIndex(ChildGroup(e), 0))));
	if (ElementCount(CellGroupTemp) > 1) then begin
		ChildCount := ElementCount(CellGroupTemp);
		for i := 0 to ChildCount - 2 do begin
			Inc(Tally);
			//AddMessage(IntToStr(Tally));
			if Tally = (ChildCount - 1) then
				CanDelete := true;
		end;
		
		
		for iNum := ChildCount - 1 downto 1 do begin // Create a reverse loop
			//AddMessage('ReverseLoop');
			if CanDelete = true then
				AddMessage('Deleting');
				RemoveNode(ElementByIndex(CellGroupTemp, iNum));
		end;
		
		
	end;

end;

end.